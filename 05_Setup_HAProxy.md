[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-haproxy/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-haproxy/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-haproxy?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-haproxy)    
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-haproxy)  ||  [Find on Github](https://github.com/containercraft/ccio-haproxy)    
    
### Prerequisites:
  + [00 Introduction]
  + [01 Build Host]
  + [02 Build Bastion]
  + [03 Build Gateway]
  + [04 Setup_Dns]
    
---------------------------------------------------------------------------------
    
# Part 05 -- [HAProxy]: [Application Router] & [Load Balancer] 
####    Step.01 Launch Simple [HAProxy] on [Alpine Linux] Container with [Podman]
```sh
sudo podman run \
    --rm                                                                                    \
    --detach                                                                                \
    --name     ocp-haproxy                                                                  \
    --publish  ${ocp_ministack_SUBNET}.3:2022:22                                            \
    --publish  ${ocp_ministack_SUBNET}.3:80:8080                                            \
    --publish  ${ocp_ministack_SUBNET}.3:443:8843                                           \
    --volume   ~/.ccio/ocp-mini-stack/module/haproxy/aux/config/:/usr/local/etc/haproxy/:ro \
  docker.io/containercraft/ccio-haproxy:latest
```
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
  + [08 Setup Tftpd]
  + [09 Deploy Cloud]
  + [10 Configure Cloud]
    
---------------------------------------------------------------------------------
    
######  + [Repo Module] Index
```sh
.
├── aux
│   └── config
│       ├── errors
│       │   ├── 400.http
│       │   ├── 403.http
│       │   ├── 408.http
│       │   ├── 500.http
│       │   ├── 502.http
│       │   ├── 503.http
│       │   └── 504.http
│       └── haproxy.cfg
└── README.md
```

<!-- Markdown link & img dfn's -->
[Repo Module]:/module/haproxy
[Podman]:https://podman.io
[HAProxy]:https://haproxy.org
[Alpine Linux]:https://alpinelinux.org/
[Load Balancer]:https://blog.openshift.com/an-open-source-load-balancer-for-openshift/
[Application Router]:https://blog.openshift.com/ocp-custom-routing/
[01 Host Hypervisor				- Bare Metal]:/01_HostSetup.md
[02 CloudCtl RDP Bastion		- LXD Container]:/02_CloudCTL.md
[03 VFW Firewall & Gateway		- LXD Container]:/03_Gateway.md
[04 DNS & DHCP Service			- OCI Podman Container]:/04_Dnsmasq.md
[05 Application Router Proxy	- OCI Podman Container]:/05_HAProxy.md
[06 Simple Artifact Server		- OCI Podman Container]:/06_Nginx.md
[07 TFTP Boot Artifact Server	- OCI Podman Container]:/07_Tftpd.md
[08 Deploy OpenShift Red Hat CoreOS Nodes]:/08_DeployNodes.md
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
