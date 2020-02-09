# [Dnsmasq]: DHCP & DNS Service
[Image Source](https://hub.docker.com/r/containercraft/ccio-dnsmasq)

#### 01\. Launch [Dnsmasq] Container with [Podman]
```sh
sudo podman run \
    --rm                                                                                                      \
    --detach                                                                                                  \
    --name    ocp-haproxy                                                                                     \
    --cap-add=NET_ADMIN                                                                                       \
    --publish ${ocp_ministack_SUBNET}.3:53:53/udp                                                             \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.conf:/etc/dnsmasq.conf                 \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.ethers:/etc/ethers                     \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.hosts:/etc/hosts                       \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.leases:/var/lib/dnsmasq/dnsmasq.leases \
    --volume  ~/.ccio/ocp-mini-stack/module/dnsmasq/aux/config/dnsmasq.resolv.conf:/etc/resolv.conf           \
  docker.io/containercraft/ccio-dnsmasq:latest
```
## [Repo Module Index](/ocp-mini-stack/module/dnsmasq)
```sh
.
├── aux
│   └── config
│       ├── dnsmasq.conf
│       ├── dnsmasq.ethers
│       ├── dnsmasq.hosts
│       ├── dnsmasq.leases
│       └── dnsmasq.resolv.conf
├── index.txt
└── README.md
```
<!-- Markdown link & img dfn's -->
[Podman]:https://podman.io
[Dnsmasq]:http://www.thekelleys.org.uk/dnsmasq/doc.html
[Application Router]:https://blog.openshift.com/ocp-custom-routing/

/etc/dnsmasq.conf
/etc/ethers 
/etc/hosts 
/var/lib/dnsmasq/dnsmasq.leases
/etc/resolv.conf 
# REFRENCE
# watch -c cat dnsmasq.leases 
# arp -f
# https://www.redhat.com/en/blog/five-nines-dnsmasq
