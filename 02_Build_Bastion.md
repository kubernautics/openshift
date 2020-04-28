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
#### 00\. SSH to CloudCtl as User
```sh
lxc list
```
```sh
ssh ${ministack_UNAME}@${int_ministack_SUBNET}.3
```
#### 00\. Setup LXD Access
```sh
lxc remote add msbase ${ocp_ministack_SUBNET}.2
lxc remote switch msbase
```
#### 00\. Install CloudCtl Fedora Workstation Desktop packages
  - (used for RDP access)
```sh
dnf group install 'Fedora Workstation' --excludepkg xorg-x11-drv-omap --excludepkg totem-nautilus --excludepkg xorg-x11-drv-armsoc --excludepkg powerpc-utils --excludepkg lsvpd --excludepkg fedora-release-container -y --allowerasing
```
#### 00\. Reboot CloudCtl
```sh
lxc exec cloudctl -- /bin/bash -c "shutdown -r now"
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
