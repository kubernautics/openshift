# Part 02 -- [OpenWRT]: LXD Virtual Firewall Gateway
     
### Prerequisites:
  + [01 Host Hypervisor - Bare Metal]
  + [02 CloudCtl RDP Bastion - LXD Container]
    
--------------------------------------------------------------------------------
# Part 00 -- Build Gateway Container
#### 00\. Write 'openwrt' LXD Profile
```sh
lxc profile copy original openwrt
lxc profile set openwrt boot.autostart true
lxc profile set openwrt security.privileged true
lxc profile set openwrt linux.kernel_modules wireguard,ip6_udp_tunnel,udp_tunnel
lxc profile device set openwrt eth0 nictype bridged
lxc profile device set openwrt eth0 parent external
lxc profile device add openwrt eth1 nic nictype=bridged parent=internal name=eth1
lxc profile device add openwrt eth2 nic nictype=bridged parent=ocp-mini-stack name=eth2
```
#### 00\. Initialize OpenWRT Gateway Container & Snapshot pre-config Image
```sh
lxc init bcio:beeef940cbcb gateway -p openwrt
lxc snapshot gateway gateway-pre-config-base-n00
```
#### 00\. Export Gateway Config Directory
```sh
export gw_CONFIGDIR="~/.ccio/ocp-mini-stack/module/gateway/aux/lib/config"
```
#### 00\. Write network address variables to configuration files
```sh
sed -i "s/ocp_ministack_SUBNET/${ocp_ministack_SUBNET}/g" ${gw_CONFIGDIR}/*
sed -i "s/int_ministack_SUBNET/${int_ministack_SUBNET}/g" ${gw_CONFIGDIR}/*
```
#### 00\. Export Gateway Config Directory & Load Config Files
```sh
for cfg in $(ls ${gw_CONFIGDIR}); do echo "Loading Config: $cfg "; lxc file push ${gw_CONFIGDIR}/$cfg gateway/etc/config/ ; done
```
#### 00\. Launch Gateway
```sh
lxc start gateway
```
#### 00\. Check IP Addresses 
  - a. network initialization may take a few moments
  - b. OpenWRT WebUI should be available on port 8081 of the eth0 external address
  - c. OpenWRT WebUI should be available on port 80 of all internal networks
```sh
watch -c lxc list
```
#### 00\. 
```sh
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
│   ├── bin
│   │   ├── build-cloudctl-profile
│   │   ├── init-ansible-fedora
│   │   ├── init-ocp-install-config-yml
│   │   ├── init-ocp-pull-secrets
│   │   └── start-nodes
│   ├── config
│   │   ├── bashrc
│   │   ├── htpasswd.yaml
│   │   ├── ssh-config
│   │   ├── ssh-config.2
│   │   └── users.htpasswd
│   ├── doc
│   │   ├── cloudctl.log
│   │   └── oc.log
│   └── inventory
│       ├── ethers
│       └── pxelinux.cfg
│           ├── AC1E00
│           ├── AC1E01
│           └── default
└── README.md
```
    
<!-- Markdown link & img dfn's -->
[Repo Module]:/module/cloudctl
[01 Host Hypervisor				- Bare Metal]:/01_HostSetup.md
[02 CloudCtl RDP Bastion		- LXD Container]:/02_CloudCTL.md
[03 VFW Firewall & Gateway		- LXD Container]:/03_Gateway.md
[04 DNS & DHCP Service			- OCI Podman Container]:/04_Dnsmasq.md
[05 Application Router Proxy	- OCI Podman Container]:/05_HAProxy.md
[06 Simple Artifact Server		- OCI Podman Container]:/06_Nginx.md
[07 TFTP Boot Artifact Server	- OCI Podman Container]:/07_Tftpd.md
[08 Deploy OpenShift Red Hat CoreOS Nodes]:/08_DeployNodes.md
