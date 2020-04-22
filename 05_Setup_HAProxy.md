[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-haproxy/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-haproxy/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-haproxy?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-haproxy)    
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-haproxy)  ||  [Find on Github](https://github.com/containercraft/ccio-haproxy)    
    
### Prerequisites:
  + [01 Host Hypervisor				- Bare Metal]
  + [02 CloudCtl RDP Bastion		- LXD Container]
  + [03 VFW Firewall & Gateway		- LXD Container]
  + [04 DNS & DHCP Service			- OCI Podman Container]
    
---------------------------------------------------------------------------------
    
# Part 05 -- [HAProxy]: [Application Router] & [Load Balancer] 
####    Step.01 Launch Simple [HAProxy] on [Alpine Linux] Container with [Podman]
```sh
sudo podman run \
    --rm                                                                                    \
    --detach                                                                                \
    --name     ocp-haproxy                                                                  \
    --publish  ${ocp_ministack_SUBNET}.3:2022:22                                            \
    --publish  ${ocp_ministack_SUBNET}.3:80:80                                              \
    --publish  ${ocp_ministack_SUBNET}.3:443:443                                            \
    --publish  ${ocp_ministack_SUBNET}.3:6443:6443                                          \
    --publish  ${ocp_ministack_SUBNET}.3:22623:22623                                        \
    --volume   ~/.ccio/ocp-mini-stack/module/haproxy/aux/config/:/usr/local/etc/haproxy/:ro \
  docker.io/containercraft/ccio-haproxy:latest
```
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [06 Simple Artifact Server		- OCI Podman Container]
  + [07 TFTP Boot Artifact Server	- OCI Podman Container]
  + [08 Deploy OpenShift Red Hat CoreOS Nodes]
    
    
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
