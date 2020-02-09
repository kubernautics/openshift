# Part 05 -- CCIO [HAProxy]: [Application Router] & [Load Balancer] 
## [![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-haproxy/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-haproxy/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-haproxy?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-haproxy)  [Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-haproxy)  |  [Image Source](https://github.com/containercraft/ccio-haproxy)
    
## Prerequisites:
  + [01 Host Hypervisor				- Bare Metal]
  + [02 CloudCtl RDP Bastion		- LXD Container]
  + [03 VFW Firewall & Gateway		- LXD Container]
  + [04 DNS & DHCP Service			- OCI Podman Container]
    
#### 01\. Launch Simple [HAProxy] on [Alpine Linux] Container with [Podman]
```sh
sudo podman run 
    --rm                                                                                    \
    --detach                                                                                \
    --name     ocp-haproxy                                                                  \
    --publish  172.10.0.3:2022:22                                                           \
    --publish  172.10.0.3:69:6969                                                           \
    --publish  172.10.0.3:80:8080                                                           \
    --publish  172.10.0.3:443:8843                                                          \
    --volume   ~/.ccio/ocp-mini-stack/module/haproxy/aux/config/:/usr/local/etc/haproxy/:ro \
  docker.io/containercraft/ccio-haproxy:latest
```
#### [Repo Module Index](/module/haproxy)
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
    
## Next Steps:
  + [06 Simple Artifact Server		- OCI Podman Container]
  + [07 TFTP Boot Artifact Server	- OCI Podman Container]

<!-- Markdown link & img dfn's -->
[Podman]:https://podman.io
[HAProxy]:https://haproxy.org
[Alpine Linux]:https://alpinelinux.org/
[Load Balancer]:https://blog.openshift.com/an-open-source-load-balancer-for-openshift/
[Application Router]:https://blog.openshift.com/ocp-custom-routing/
[01 Host Hypervisor				- Bare Metal]:(/module/host/README.md)
[02 CloudCtl RDP Bastion		- LXD Container]:(/module/cloudctl/README.md)
[03 VFW Firewall & Gateway		- LXD Container]:(/module/openwrt/README.md)
[04 DNS & DHCP Service			- OCI Podman Container]:(/module/dnsmasq/README.md)
[05 Application Router Proxy	- OCI Podman Container]:(/module/haproxy/README.md)
[06 Simple Artifact Server		- OCI Podman Container]:(/module/nginx/README.md)
[07 TFTP Boot Artifact Server	- OCI Podman Container]:(/module/tftpd/README.md)
