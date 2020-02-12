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
lxc init images:fedora/31 cloudctl -p cloudctl
lxc start cloudctl
```
#### 00\. Push host bashrc & SSH assets to CloudCtl
```sh
lxc file push -r ~/.ssh    cloudctl/root/
lxc file push -r ~/.bashrc cloudctl/root/
lxc file push -r ~/.bashrc cloudctl/etc/skel/
```
#### 00\. Create CCIO Group & Add 'root' to group 'ccio'
```sh
lxc exec cloudctl -- /bin/bash -c "groupadd ccio -f --gid $(grep ccio /etc/group | cut -d ':' -f 3)"
lxc exec cloudctl -- /bin/bash -c "usermod -a -G ccio root"
```
#### 00\. Create Primary User
```sh
lxc exec cloudctl -- /bin/bash -c "useradd --groups wheel,ccio --create-home ${ministack_UNAME}"
lxc exec cloudctl -- /bin/bash -c "passwd ${ministack_UNAME}"
```
#### 00\. Add sudoer permissions
```sh
lxc file push     /etc/sudoers.d/kmorgan cloudctl/etc/sudoers.d/kmorgan
```
#### 00\. Push SSH assets to 'ministack_UNAME' and set permissions
```sh
lxc file push -r ~/.ssh cloudctl/home/${ministack_UNAME}/
lxc exec cloudctl -- /bin/bash -c "chown -R ${ministack_UNAME}:${ministack_UNAME} /home/${ministack_UNAME}/.ssh && rm -rf /home/${ministack_UNAME}/.cache"
```
#### 00\. Attach .ccio home path to CloudCtl container
```sh
lxc config device add cloudctl ccio-home disk source=~/.ccio path=/home/${ministack_UNAME}/.ccio
```
#### 00\. Install CloudCtl instance package requirements
```sh
lxc exec cloudctl -- /bin/bash -c "rpm --nodeps --allmatches -e fedora-release-container"
lxc exec cloudctl -- /bin/bash -c "dnf update -y && dnf distrosync -y"
lxc exec cloudctl -- /bin/bash -c "dnf group install 'Fedora Workstation' --excludepkg xorg-x11-drv-omap --excludepkg totem-nautilus --excludepkg xorg-x11-drv-armsoc --excludepkg powerpc-utils --excludepkg lsvpd --excludepkg fedora-release-container -y --allowerasing"
lxc exec cloudctl -- /bin/bash -c "dnf install -y xz jq tar git sudo tmux htop snapd p7zip iperf3 podman skopeo glances buildah hostname neofetch net-tools squashfuse vim-enhanced openssh-server libvirt-client NetworkManager* xrdp xorgxrdp xrdp-devel virt-viewer virt-manager xrdp-selinux libvirt-client gnome-tweaks && snap refresh virt-install syslinux lynx"
```
#### 00\. Setup NetworkManager Configuration
```sh
lxc exec cloudctl -- /bin/bash -c "systemctl disable systemd-networkd"
lxc exec cloudctl -- /bin/bash -c "systemctl enable --now NetworkManager"
lxc exec cloudctl -- /bin/bash -c "nmcli connection add type ethernet con-name eth0 ifname eth0 ipv4.method auto connection.autoconnect yes"
lxc exec cloudctl -- /bin/bash -c "nmcli connection add type ethernet con-name eth1 ifname eth1 ip4 ${ocp_ministack_SUBNET}.3/24 ipv4.dns '8.8.8.8 8.8.4.4' connection.autoconnect yes"
lxc exec cloudctl -- /bin/bash -c "nmcli connection add type ethernet con-name eth2 ifname eth2 ip4 172.10.0.3/16 ipv4.dns '172.10.0.1' connection.autoconnect yes"
lxc exec cloudctl -- /bin/bash -c "nmcli con up eth0"
lxc exec cloudctl -- /bin/bash -c "nmcli con up eth1"
lxc exec cloudctl -- /bin/bash -c "nmcli con up eth2"
```
#### 00\. Set System Services
```sh
lxc exec cloudctl -- /bin/bash -c "systemctl enable --now sshd"
lxc exec cloudctl -- /bin/bash -c "systemctl unmask systemd-logind"
lxc exec cloudctl -- /bin/bash -c "systemctl enable systemd-logind"
lxc exec cloudctl -- /bin/bash -c "systemctl enable xrdp.service"
lxc exec cloudctl -- /bin/bash -c "systemctl enable xrdp-sesman.service"
lxc exec cloudctl -- /bin/bash -c "systemctl set-default graphical.target"
lxc exec cloudctl -- /bin/bash -c "systemctl disable firewalld"
```
#### 00\. Destroy local libvirt network bridge & mask services
```sh
lxc exec cloudctl -- /bin/bash -c "systemctl enable --now libvirtd.service"
lxc exec cloudctl -- /bin/bash -c "virsh net-destroy default"
lxc exec cloudctl -- /bin/bash -c "virsh net-undefine default"
lxc exec cloudctl -- /bin/bash -c "virsh net-list --all"
lxc exec cloudctl -- /bin/bash -c "systemctl disable libvirtd.service"
lxc exec cloudctl -- /bin/bash -c "systemctl mask libvirtd.service"
```
#### 00\. Install LXC / LXD Stack
```sh
lxc exec cloudctl -- /bin/bash -c "ln -s /var/lib/snapd/snap /snap"
lxc exec cloudctl -- /bin/bash -c "snap refresh ; snap install snapd ; sleep 2 ; snap install snapd"
lxc exec cloudctl -- /bin/bash -c "snap install lxd"
```
#### 00\. Add user to required groups
```sh
lxc exec cloudctl -- /bin/bash -c "usermod -a -G wheel,ccio,kvm,libvirt,lxd ${ministack_UNAME}"
```
#### 00\. Disable SELINUX for development purposes
```sh
lxc exec cloudctl -- /bin/bash -c "sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config"
```
#### 00\. Reboot CloudCtl
```sh
lxc exec cloudctl -- /bin/bash -c "shutdown -r now"
```
#### 00\. SSH to CloudCtl as User
```sh
ssh ${ministack_UNAME}@$(lxc list -c n,4 --format=csv | awk -F'[, ]' '/eth0/{print $1}')
```
#### 00\. Setup Libvirt Access && Add host ssh keys
```sh
echo 'alias virsh="virsh -c qemu+ssh://root@${ocp_ministack_SUBNET}.2/system"' >>.bashrc && source ~/.bashrc
ssh-keyscan -H ${ocp_ministack_SUBNET}.2 >>~/.ssh/known_hosts
ssh -oStrictHostKeyChecking=accept-new root@${ocp_ministack_SUBNET}.2 hostname
virsh list --all
```
#### 00\. Setup LXD Access
```sh
lxc remote add msbase ${ocp_ministack_SUBNET}.2
lxc remote switch msbase
```
---------------------------------------------------------------------------------
    
### Next Steps:
  + [03 VFW Firewall & Gateway - LXD Container]
  + [04 DNS & DHCP Service			- OCI Podman Container]
  + [05 Application Router Proxy - OCI Podman Container]
  + [06 Simple Artifact Server - OCI Podman Container]
  + [07 TFTP Boot Artifact Server - OCI Podman Container]
  + [08 Deploy OpenShift Red Hat CoreOS Nodes]
     
---------------------------------------------------------------------------------
<!-- Markdown link & img dfn's -->
[01 Host Hypervisor				- Bare Metal]:/01_HostSetup.md
[02 CloudCtl RDP Bastion		- LXD Container]:/02_CloudCTL.md
[03 VFW Firewall & Gateway		- LXD Container]:/03_Gateway.md
[04 DNS & DHCP Service			- OCI Podman Container]:/04_Dnsmasq.md
[05 Application Router Proxy	- OCI Podman Container]:/05_HAProxy.md
[06 Simple Artifact Server		- OCI Podman Container]:/06_Nginx.md
[07 TFTP Boot Artifact Server	- OCI Podman Container]:/07_Tftpd.md
[08 Deploy OpenShift Red Hat CoreOS Nodes]:/08_DeployNodes.md
