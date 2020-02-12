[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-isc-dhcp/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-isc-dhcp/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-isc-dhcp?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-isc-dhcp)<br>
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-isc-dhcp) || [Find on Github](https://github.com/containercraft/ccio-isc-dhcp)

### Prerequisites:
  + [01 Host Hypervisor - Bare Metal]
  + [02 CloudCtl RDP Bastion - LXD Container]
  + [03 VFW Firewall & Gateway - LXD Container]
--------------------------------------------------------------------------------
    
# Part 04 -- [isc-dhcp]: DHCP & DNS Service
####    Step.01 Launch [isc-dhcp] on [Alpine Linux] Container with [Podman]
```sh
sudo podman run \
    --name      ocp-isc-dhcp                                                   \
    --rm                                                                       \
    --detach                                                                   \
    --net=host                                                                 \
    --cap-add=NET_ADMIN                                                        \
    --publish 67:67/udp                                                        \
    --volume ~/.ccio/ocp-mini-stack/module/isc-dhcp/aux/config/dhcp:/etc/dhcp/                 \
    --volume ~/.ccio/ocp-mini-stack/module/isc-dhcp/aux/config/defaults:/etc/defaults          \
    --volume ~/.ccio/ocp-mini-stack/module/isc-dhcp/aux/config/var/lib/dhcp/:/var/lib/dhcp/ \
  docker.io/containercraft/ccio-isc-dhcp:alpine-latest
```
    
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [05 Application Router Proxy - OCI Podman Container]
  + [06 Simple Artifact Server - OCI Podman Container]
  + [07 TFTP Boot Artifact Server - OCI Podman Container]
  + [08 Deploy OpenShift Red Hat CoreOS Nodes]
    
---------------------------------------------------------------------------------
    
######  + [Repo Module] Index
```sh 
.
├── aux
│   └── config
│       ├── defaults
│       ├── dhcpd.conf
│       ├── dhcpd.leases
│       └── dhcpd.libvirt
├── README.md
└── run
```

<!-- Markdown link & img dfn's -->
[Repo Module]:/module/isc-dhcp
[alpine linux]: https://alpinelinux.org/
[isc-dhcp]: http://www.thekelleys.org.uk/isc-dhcp/doc.html
[podman]: https://podman.io
[01 Host Hypervisor				- Bare Metal]:/01_HostSetup.md
[02 CloudCtl RDP Bastion		- LXD Container]:/02_CloudCTL.md
[03 VFW Firewall & Gateway		- LXD Container]:/03_Gateway.md
[04 DNS & DHCP Service			- OCI Podman Container]:/04_Dnsmasq.md
[05 Application Router Proxy	- OCI Podman Container]:/05_HAProxy.md
[06 Simple Artifact Server		- OCI Podman Container]:/06_Nginx.md
[07 TFTP Boot Artifact Server	- OCI Podman Container]:/07_Tftpd.md
[08 Deploy OpenShift Red Hat CoreOS Nodes]:/08_DeployNodes.md
