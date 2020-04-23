### Prerequisites:
  + [00 Introduction]
  + [01 Build Host]
  + [02 Build Bastion]
  + [03 Build Gateway]
  + [04 Setup_Dns]
  + [05 Setup HAProxy]
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
  + [08 Setup Tftpd]
--------------------------------------------------------------------------------
    
# Part 08 -- Deploy: Write Final Configuration Files & Build/Deploy Nodes
####    Step.01 Stash OCP Pull Secrets
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/init-ocp-pull-secrets
```

####    Step.02 Acquire RH CoreOS Boot Artifacts
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/scrape-artifact-mirrors 
```

####    Step.03 Generate ignition files
```sh
 cp ~/.ccio/ocp-mini-stack/build/install-config.yaml   ~/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition
 openshift-install create manifests        --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/
 openshift-install create ignition-configs --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/
 mkdir ~/.kube ; cp -f ~/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/auth/kubeconfig ~/.kube/config
```

####    Step.04 Set CCIO Group Permissions
```sh
 sudo chmod -R 755        ~/.ccio/ocp-mini-stack/module/nginx/aux/html/
 sudo chown -R $USER:ccio ~/.ccio/ocp-mini-stack/module/nginx/aux/html/
```

####    Step.05 Create Libvirt VMs
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/init-nodes-libvirt
```

####    Step.06 Restart DHCP service with node specific configs
```sh
 sudo podman stop ocp-isc-dhcp ; sleep 3 ; sudo podman start ocp-isc-dhcp
```

####    Step.07 Initialize Cluster Libvirt Virtual Machines && watch cluster operator status
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/start-nodes
 watch -c oc get co
```

####    Step.08 Initialize Cluster Libvirt Virtual Machines & Restart Services
```sh
 openshift-install --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/ wait-for bootstrap-complete --log-level=debug
 openshift-install --dir=${HOME}/.ccio/ocp-mini-stack/module/nginx/aux/html/ignition/ wait-for install-complete --log-level=debug
```
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [10 Configure Cloud]
    
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
--------------------------------------------------------------------------------
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
