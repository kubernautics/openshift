# Stage 01 -- CloudCtl Bastion Setup

### Prerequisites:
  + [01 Host Hypervisor				- Bare Metal]
    
--------------------------------------------------------------------------------
# Part 00 -- Build LXD CloudCtl Container
#### 00\. Write LXD CloudCtl Profile
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/build-cloudctl-profile
```
#### 00\. Create & Start CloudCtl Container
```sh
lxc start images:fedora/31/cloud/amd64 cloudctl -p cloudctl
```
#### 00\. Install CloudCtl Fedora Workstation Desktop packages
  - (used for RDP access)
```sh
lxc exec cloudctl -- /bin/bash -c "dnf group install 'Fedora Workstation' --excludepkg xorg-x11-drv-omap --excludepkg totem-nautilus --excludepkg xorg-x11-drv-armsoc --excludepkg powerpc-utils --excludepkg lsvpd --excludepkg fedora-release-container -y --allowerasing"
```
#### 00\. Setup NetworkManager Configuration
```sh
lxc exec cloudctl -- /bin/bash -c "nmcli connection add type ethernet con-name eth0 ifname eth0 ipv4.method auto ipv4.dns '8.8.8.8 8.8.4.4' connection.autoconnect yes"
lxc exec cloudctl -- /bin/bash -c "nmcli connection add type ethernet con-name eth1 ifname eth1 ip4 ${int_ministack_SUBNET}.3/24 connection.autoconnect yes"
lxc exec cloudctl -- /bin/bash -c "nmcli connection add type ethernet con-name eth2 ifname eth2 ip4 ${ocp_ministack_SUBNET}.3/16 connection.autoconnect yes"
#lxc exec cloudctl -- /bin/bash -c "nmcli connection add type ethernet con-name eth2 ifname eth2 ip4 ${ocp_ministack_SUBNET}.3/16 ipv4.dns '172.10.0.1' connection.autoconnect yes"

lxc exec cloudctl -- /bin/bash -c "nmcli con up eth0"
lxc exec cloudctl -- /bin/bash -c "nmcli con up eth1"
lxc exec cloudctl -- /bin/bash -c "nmcli con up eth2"
```
#### 00\. Install LXC / LXD Stack
```sh
lxc exec cloudctl -- /bin/bash -c "ln -s /var/lib/snapd/snap /snap"
lxc exec cloudctl -- /bin/bash -c "snap refresh ; snap install snapd ; sleep 2 ; snap install snapd"
lxc exec cloudctl -- /bin/bash -c "snap install lxd"
```
#### 00\. Reboot CloudCtl
```sh
lxc exec cloudctl -- /bin/bash -c "shutdown -r now"
```
#### 00\. SSH to CloudCtl as User
```sh
lxc list
ssh ${ministack_UNAME}@${int_ministack_SUBNET}.3
#ssh ${ministack_UNAME}@$(lxc list -c n,4 --format=csv | awk -F'[, ]' '/cloudctl/{print $2}')
#ssh ${ministack_UNAME}@$(lxc list -c n,4 --format=csv | awk -F'[, "]' '/cloudctl/{print $3}')
```
#### 00\. Setup Libvirt Access && Add host ssh keys
```sh
echo 'alias virsh="virsh -c qemu+ssh://root@${ocp_ministack_SUBNET}.2/system"' >>.bashrc && source ~/.bashrc
ssh-keyscan -H ${int_ministack_SUBNET}.2 >>~/.ssh/known_hosts
ssh -oStrictHostKeyChecking=accept-new root@${ocp_ministack_SUBNET}.2 hostname
virsh list --all
```
#### 00\. Setup LXD Access
```sh
lxc remote add msbase ${ocp_ministack_SUBNET}.2
lxc remote switch msbase
```
```
lxc exec cloudctl -- /bin/bash -c "curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux-4.3.13.tar.gz | sudo tar xzvf - --directory /usr/local/bin/ openshift-install"
lxc exec cloudctl -- /bin/bash -c "curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.3.13.tar.gz | sudo tar xzvf - --directory /usr/local/bin/ kubectl oc"
```
---------------------------------------------------------------------------------
    
### Next Steps:
  + [03 Build Gateway]
  + [04 Setup_Dns]
  + [05 Setup HAProxy]
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
  + [08 Setup Tftpd]
  + [09 Deploy Cloud]
  + [10 Configure Cloud]
--------------------------------------------------------------------------------
[00 Introduction]:/00_Introduction.md
<!-- Markdown link & img dfn's -->
[Ansible Automation]:/ansible/README.md
[00 Introduction]:/00_Introduction.md
[01 Build Host]:/01_Build_Host.md
[02 Build Bastion]:/02_Build_Bastion.md
[03 Build Gateway]:/03_Build_Gateway.md
[04 Setup_Dns]:/04_Setup_DNS.md
[05 Setup HAProxy]:/05_Setup_HAProxy.md
[06 Setup Dhcp]:/06_Setup_DHCP.md
[07 Setup Nginx]:/07_Setup_Nginx.md
[08 Setup Tftpd]:/08_Setup_Tftpd.md
[09 Deploy Cloud]:/09_Deploy_Cloud.md
[10 Configure Cloud]:/10_Configure_Cloud.md
