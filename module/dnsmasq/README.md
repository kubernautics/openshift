# [Dnsmasq]: DHCP & DNS Service
[Repo Module](./module/dnsmasq)
[Image Source](https://hub.docker.com/r/containercraft/ccio-dnsmasq)

#### 01\. Launch [Dnsmasq] Container with [Podman]
```sh
sudo podman run \
                -d \
                --name ocp-dnsmasq \
                --cap-add=NET_ADMIN \
                -p ${ocp_ministack_SUBNET}.3:53:53/udp \
                -v ~/.ccio/ocp-mini-stack/module/dnsmasq/dnsmasq.conf:/etc/dnsmasq.conf \
                -v ~/.ccio/ocp-mini-stack/module/dnsmasq/resolv.dnsmasq.conf:/etc/resolv.dnsmasq.conf \
                -v ~/.ccio/ocp-mini-stack/module/dnsmasq/dnsmasq.conf.hosts \
                -v ~/.ccio/ocp-mini-stack/module/dnsmasq/ethers:/etc/ethers \
     docker.io/containercraft/ccio-dnsmasq:latest
```

<!-- Markdown link & img dfn's -->
[Podman]:https://podman.io
[Dnsmasq]:http://www.thekelleys.org.uk/dnsmasq/doc.html
[Application Router]:https://blog.openshift.com/ocp-custom-routing/
