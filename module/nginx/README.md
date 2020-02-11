[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-nginx/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-nginx/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-nginx?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-nginx)<br>
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-nginx) || [Find on Github](https://github.com/containercraft/ccio-nginx)

### Prerequisites:
  + [01 Host Hypervisor - Bare Metal]
  + [02 CloudCtl RDP Bastion - LXD Container]
  + [03 VFW Firewall & Gateway - LXD Container]
  + [04 DNS & DHCP Service			- OCI Podman Container]
  + [05 Application Router Proxy - OCI Podman Container]
--------------------------------------------------------------------------------
    
# Part 06 -- [Nginx]: Simple Artifact Server
####    Step.01 Launch [Nginx] on [Alpine Linux] Container with [Podman]
```sh
sudo podman run \
    --rm                                                                                                  \
    --detach                                                                                              \
    --name     ccio-nginx                                                                                 \
    --publish  ${ocp_ministack_SUBNET}.3:8080:8080                                                        \
    --volume   ~/.ccio/ocp-mini-stack/module/nginx/aux/html/:/var/www/html/:ro                            \
    --volume   ~/.ccio/ocp-mini-stack/module/nginx/aux/config/nginx.conf:/etc/nginx/nginx.conf            \
    --volume   ~/.ccio/ocp-mini-stack/module/nginx/aux/config/default.conf:/etc/nginx/conf.d/default.conf \
  docker.io/containercraft/ocp-nginx
```
    
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [07 TFTP Boot Artifact Server - OCI Podman Container]
  + [08 Deploy OpenShift Red Hat CoreOS Nodes]
    
---------------------------------------------------------------------------------
    
######  + [Repo Module] Index
```sh
.
├── aux
│   ├── bin
│   │   └── scrape-artifact-mirrors
│   ├── config
│   │   ├── default.conf
│   │   └── nginx.conf
│   └── html
│       ├── boot
│       └── README.txt
└── README.md
```

<!-- Markdown link & img dfn's -->
[Repo Module]:/module/nginx
[Nginx]:https://www.nginx.com/
[alpine linux]: https://alpinelinux.org/
[podman]: https://podman.io
[01 Host Hypervisor				- Bare Metal]:/01_HostSetup.md
[02 CloudCtl RDP Bastion		- LXD Container]:/02_CloudCTL.md
[03 VFW Firewall & Gateway		- LXD Container]:/03_Gateway.md
[04 DNS & DHCP Service			- OCI Podman Container]:/04_Dnsmasq.md
[05 Application Router Proxy	- OCI Podman Container]:/05_HAProxy.md
[06 Simple Artifact Server		- OCI Podman Container]:/06_Nginx.md
[07 TFTP Boot Artifact Server	- OCI Podman Container]:/07_Tftpd.md
[08 Deploy OpenShift Red Hat CoreOS Nodes]:/08_DeployNodes.md
