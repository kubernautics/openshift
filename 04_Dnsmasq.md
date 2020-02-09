# [Dnsmasq]: DHCP & DNS Service
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-dnsmasq)  |  [Image Source](https://github.com/containercraft/ccio-haproxy)    
[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-dnsmasq/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-dnsmasq/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-dnsmasq?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-dnsmasq)

## Prerequisites:
  + [01 Host Hypervisor				- Bare Metal](/module/host/README.md)
  + [02 CloudCtl RDP Bastion		- LXD Container](/module/cloudctl/README.md)
  + [03 VFW Firewall & Gateway		- LXD Container](/module/openwrt/README.md)

#### 01\. Launch [Dnsmasq] on [Alpine Linux] Container with [Podman]
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
#### [Repo Module Index](/module/dnsmasq)
```sh
.
├── aux
│   └── config
│       ├── dnsmasq.conf
│       ├── dnsmasq.ethers
│       ├── dnsmasq.hosts
│       ├── dnsmasq.leases
│       └── dnsmasq.resolv.conf
└── README.md
```
#### REFRENCE
  + `watch -c cat dnsmasq.leases`
  + `arp -f`
  + `https://www.redhat.com/en/blog/five-nines-dnsmasq`

## Next Steps:
  + [05 Application Router Proxy	- OCI Podman Container]
  + [06 Simple Artifact Server		- OCI Podman Container]
  + [07 TFTP Boot Artifact Server	- OCI Podman Container]
    
<!-- Markdown link & img dfn's -->
[Podman]:https://podman.io
[Dnsmasq]:http://www.thekelleys.org.uk/dnsmasq/doc.html
[Alpine Linux]:https://alpinelinux.org/
[01 Host Hypervisor				- Bare Metal]:(/module/host/README.md)
[02 CloudCtl RDP Bastion		- LXD Container]:(/module/cloudctl/README.md)
[03 VFW Firewall & Gateway		- LXD Container]:(/module/openwrt/README.md)
[04 DNS & DHCP Service			- OCI Podman Container]:(/module/dnsmasq/README.md)
[05 Application Router Proxy	- OCI Podman Container]:(/module/haproxy/README.md)
[06 Simple Artifact Server		- OCI Podman Container]:(/module/nginx/README.md)
[07 TFTP Boot Artifact Server	- OCI Podman Container]:(/module/tftpd/README.md)
