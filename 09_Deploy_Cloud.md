### Prerequisites:
  + [01 Host Hypervisor - Bare Metal]
  + [02 CloudCtl RDP Bastion - LXD Container]
  + [03 VFW Firewall & Gateway - LXD Container]
  + [04 DNS & DHCP Service			- OCI Podman Container]
  + [05 Application Router Proxy - OCI Podman Container]
  + [06 Simple Artifact Server - OCI Podman Container]
--------------------------------------------------------------------------------
    
# Part 08 -- Deploy: Write Final Configuration Files & Build/Deploy Nodes
####    Step.01 Stash OCP Pull Secrets
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/init-ocp-pull-secrets
```
####    Step.02 Initialize Cluster Libvirt Virtual Machines & Restart Services
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/init-nodes-libvirt
 sudo podman stop ocp-isc-dhcp ; sleep 3 ; sudo podman start ocp-isc-dhcp
 openshift-install --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/ wait-for bootstrap-complete --log-level=debug
 openshift-install --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/ wait-for install-complete --log-level=debug
 export KUBECONFIG=~/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/auth/kubeconfig
 oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}'
 oc get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc adm certificate approve
 sudo dnf install httpd-tools
 htpasswd -c -B -b users.htpasswd ocadmin admin
 oc create secret generic htpass-secret --from-file=htpasswd=./users.htpasswd -n openshift-config
 oc apply -f ~/.ccio/ocp-mini-stack/module/cloudctl/aux/config/htpasswd.yaml
 oc adm policy add-cluster-role-to-user cluster-admin ocadmin
```
####    Step.02 
```sh
curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux-4.3.0.tar.gz | sudo tar xzvf - --directory /usr/local/bin/ openshift-install
curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.3.0.tar.gz | sudo tar xzvf - --directory /usr/local/bin/ kubectl oc
```
####    Step.02 Generate ignition files
```sh
 cp ~/.ccio/ocp-mini-stack/build/install-config.yaml ~/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition
 openshift-install create manifests --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/
 openshift-install create ignition-configs --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/
 sudo chmod -R 777 ~/.ccio/ocp-mini-stack/module/nginx/aux/html/
```
####    Step.02 Initialize Cluster Libvirt Virtual Machines
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/start-nodes
```
    
    
---------------------------------------------------------------------------------
    
### Next Steps:
    
---------------------------------------------------------------------------------
    
######  + [Repo Module] Index
```sh
.
├── aux
│   ├── pxelinux.cfg
│   │   ├── AC1E00
│   │   └── default
│   └── systemd
│       └── tftp.service
└── README.md
```

<!-- Markdown link & img dfn's -->
[Repo Module]:/module/tftpd
[podman]: https://podman.io
[Alpine Linux]:https://alpinelinux.org/
[TFTPd]:http://freshmeat.sourceforge.net/projects/tftp-hpa/
[tftp-hpa]:http://freshmeat.sourceforge.net/projects/tftp-hpa/
[01 Host Hypervisor				- Bare Metal]:/01_HostSetup.md
[02 CloudCtl RDP Bastion		- LXD Container]:/02_CloudCTL.md
[03 VFW Firewall & Gateway		- LXD Container]:/03_Gateway.md
[04 DNS & DHCP Service			- OCI Podman Container]:/04_Dnsmasq.md
[05 Application Router Proxy	- OCI Podman Container]:/05_HAProxy.md
[06 Simple Artifact Server		- OCI Podman Container]:/06_Nginx.md
[07 TFTP Boot Artifact Server	- OCI Podman Container]:/07_Tftpd.md
[08 Deploy OpenShift Red Hat CoreOS Nodes]:/08_DeployNodes.md
--------------------------------------------------------------------------------
  + [00 Introduction]
  + [01 Build Host]
  + [02 Build Bastion]
  + [03 Build Gateway]
  + [04 Setup_Dns]
  + [05 Setup HAProxy]
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
  + [08 Setup Tftpd]
  + [09 Deploy Cloud]
  + [10 Configure Cloud]
--------------------------------------------------------------------------------
[00 Introduction]:/00_Introduction.md
<!-- Markdown link & img dfn's -->
[00 Introduction]:/00_Introduction.md
[01 Build Host]:/01_Build_Host.md
[02 Build Bastion]:/02_Build_Bastion.md
[03 Build Gateway]:/03_Build_Gateway.md
[04 Setup_Dns]:/04_Setup_DNS.md
[05 Setup HAProxy]:/05_Setup_HAProxy.md
[06 Setup Dhcp]:/06_Setup_DHCP.md
[07 Setup Nginx]:/07_Setup_Nginx.md
[08 Setup Tftpd]:/08_Setup_Tftpd.md
[09 Deploy Cloud]:/09_Deploy_Cloud.md
[10 Configure Cloud]:/10_Configure_Cloud.md
