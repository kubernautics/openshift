[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-tftpd/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-tftpd/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-tftpd?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-tftpd)<br>
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-tftpd) || [Find on Github](https://github.com/containercraft/ccio-tftpd)

### Prerequisites:
  + [01 Host Hypervisor - Bare Metal]
  + [02 CloudCtl RDP Bastion - LXD Container]
  + [03 VFW Firewall & Gateway - LXD Container]
  + [04 DNS & DHCP Service			- OCI Podman Container]
  + [05 Application Router Proxy - OCI Podman Container]
  + [06 Simple Artifact Server - OCI Podman Container]
--------------------------------------------------------------------------------
    
# Part 07 -- TFTPd: Network PXE Boot Resources
####    Step.01 Launch [tftp-hpa] on [Alpine Linux] Container with [Podman]
  - the tftp container will serve all files mounted to `/tftpboot/`
```sh
sudo podman run \
    --rm                                                                                     \
    --detach                                                                                 \
    --name     ocp-tftpd                                                                     \
    --publish  ${ocp_ministack_SUBNET}.3:69:69/tcp                                           \
    --publish  ${ocp_ministack_SUBNET}.3:69:69/udp                                           \
    --volume   ~/.ccio/ocp-mini-stack/module/tftp/aux/pxelinux.cfg:/tftpboot/pxelinux.cfg:ro \
  docker.io/containercraft/ccio-tftpd:latest
```
    
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [08 Deploy OpenShift Red Hat CoreOS Nodes]
    
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
