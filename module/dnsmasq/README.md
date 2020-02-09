[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-dnsmasq/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-dnsmasq/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-dnsmasq?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-dnsmasq)<br>
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-dnsmasq) || [Find on Github](https://github.com/containercraft/ccio-haproxy)

### Prerequisites:
  + [01 Host Hypervisor - Bare Metal]
  + [02 CloudCtl RDP Bastion - LXD Container]
  + [03 VFW Firewall & Gateway - LXD Container]
--------------------------------------------------------------------------------
    
# Part 04 -- [Dnsmasq]: DHCP & DNS Service
####    Step.01 Launch [Dnsmasq] on [Alpine Linux] Container with [Podman]
```sh
sudo podman run \
    --rm                                                                                                      \
    --detach                                                                                                  \
    --name    ocp-dnsmasq                                                                                     \
    --cap-add=NET_ADMIN                                                                                       \
    --publish ${ocp_ministack_SUBNET}.3:53:53/udp                                                             \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.conf:/etc/dnsmasq.conf                 \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.ethers:/etc/ethers                     \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.hosts:/etc/hosts                       \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.leases:/var/lib/dnsmasq/dnsmasq.leases \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.resolv.conf:/etc/resolv.conf           \
  docker.io/containercraft/ccio-dnsmasq:latest
```
    
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [05 Application Router Proxy - OCI Podman Container]
  + [06 Simple Artifact Server - OCI Podman Container]
  + [07 TFTP Boot Artifact Server - OCI Podman Container]
    
---------------------------------------------------------------------------------
    
######  + [Repo Module] Index
```sh
.
├── aux
│   └── config
│       ├── dnsmasq.conf
│       ├── dnsmasq.ethers
│       ├── dnsmasq.hosts
│       ├── dnsmasq.leases
│       └── dnsmasq.resolv.conf
└── README.md
```

<!-- Markdown link & img dfn's -->
[Repo Module]:/module/dnsmasq
[01 host hypervisor                - bare metal]: (/module/host/README.md)
[02 cloudctl rdp bastion        - lxd container]: (/module/cloudctl/README.md)
[03 vfw firewall & gateway        - lxd container]: (/module/openwrt/README.md)
[04 dns & dhcp service            - oci podman container]: (/module/dnsmasq/README.md)
[05 application router proxy    - oci podman container]: (/module/haproxy/README.md)
[06 simple artifact server        - oci podman container]: (/module/nginx/README.md)
[07 tftp boot artifact server    - oci podman container]: (/module/tftpd/README.md)
[alpine linux]: https://alpinelinux.org/
[dnsmasq]: http://www.thekelleys.org.uk/dnsmasq/doc.html
[podman]: https://podman.io
