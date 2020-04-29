# Stage 01 -- Base Hypervisor Setup
## Review checklist of prerequisites:
1. You have a clean install of [Fedora Workstation](https://getfedora.org/en/workstation/)
2. You have no critical data on this system
3. You are familiar with and able to ssh between machines
4. You have created an ssh key pair
5. Your SSH Public key is uploaded to a git service such as [Gitlab](https://gitlab.com/) or [Github](https://github.com/)
    
--------------------------------------------------------------------------------
# Part 00 -- Clone Project
#### 00\. Clone the ocp-mini-stack repo
```sh
sudo -i 
dnf update -y && dnf install git -y
git clone https://github.com/containercraft/ocp-mini-stack.git ~/.ccio/ocp-mini-stack
```
#### 00\. Build CCIO User Profile
```sh
 . ~/.ccio/ocp-mini-stack/module/host/aux/bin/build-profile-ccio
```
--------------------------------------------------------------------------------
# Part 01 -- System Setup & User Access
#### 00\. Change to Root & Backup User Files
```sh
passwd root
mkdir ~/.bak 2>/dev/null ; mv ~/*.log ~/*.cfg ~/*.xml ~/.bak/ 2>/dev/null
```
#### 00\. Change to Root & Backup User Files
```sh
systemctl set-hostname base.ministack.dev
```
#### 01\. Run System Updates & Install Base Packages
```sh
dnf update -y && dnf install -y xz tar tmux htop grubby iperf3 glances hostname neofetch net-tools vim-enhanced openssh-server
```
#### 02\. Configure SSH & Keys
```sh
ssh-keygen -f ~/.ssh/id_rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
curl -L https://github.com/${ccio_SSH_UNAME}.keys | tee -a ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys && chown root:root -R ~/.ssh
systemctl enable --now sshd
```
#### 03\. Set SELinux to Permissive
```sh
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
```
#### 04\. Install Libvirt / Qemu / KVM & Utilities
```sh
dnf  install -y libvirt qemu-kvm virt-top qemu-kvm qemu-img edk2-ovmf virt-viewer virt-manager virt-install libvirt-client python3-libvirt libguestfs-tools libvirt-daemon-kvm libguestfs-tools-c libvirt-daemon-qemu 
```
#### 05\. Install OpenVSwitch Packages
```sh
dnf install -y openvswitch network-scripts-openvswitch
```
#### 05\. Install Wireguard Packages for Ensign Kingpin Overlay Network
```sh
sudo dnf copr enable jdoss/wireguard -y && sudo dnf update -y
sudo dnf install -y wireguard-dkms wireguard-tools
```
#### 06\. Install LXC via LXD Container Stack
```sh
dnf install -y snapd fuse-overlayfs criu fuse3 fuse3-devel && sleep 3 && snap list && sleep 3
snap install snapd
ln -s /var/lib/snapd/snap /snap
snap install lxd
snap switch --channel edge lxd
snap refresh lxd
lxc profile set default security.privileged=true
lxc profile device set default eth0 nictype bridged
lxc profile copy default original
```
#### 07\. Configure Kernel Modules
```sh
echo 'options kvm_intel nested=1' >/etc/modprobe.d/qemu-system-x86.conf
echo 'vfio-pci'                   >/etc/modules-load.d/vfio-pci.conf
```
#### 08\. Configure Grub Menu
```sh
sed  -i 's/GRUB_TERMINAL_OUTPUT="console"/GRUB_TERMINAL_OUTPUT="serial"/g'                     /etc/default/grub
echo    'GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"' >>/etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```
#### 09\. Configure Kernel Arguments
```sh
grubby --update-kernel=ALL --remove-args="quiet splash"
grubby --update-kernel=ALL --args="intel_iommu=on iommu=pt kvm-intel.nested=1 kvm_intel.nested=1 net.ifnames=0 biosdevname=0 pci=noaer console=ttyS0,115200n8"
```
#### 10\. Reboot
```sh
shutdown -r now
```
--------------------------------------------------------------------------------
## Part 02 -- Create Host Virtual Network Architecture
#### 00\. Create Network Config Directory
```sh
mkdir -p /etc/systemd/network
```
#### 01\. Define 'external_NIC' Host Primary External Interface Variable
```sh
export external_NIC="eth0"
```
#### 02\. Write '$external_NIC' External Bridge Interface Networkd Configuration
```sh
cat <<EOF >/etc/systemd/network/${external_NIC}.network
[Match]
Name=${external_NIC}
[Network]
DHCP=no
IPv6AcceptRA=no
LinkLocalAddressing=no
EOF
    
```
#### 03\. Write 'external' External Bridge Networkd Configuration
```sh
cat <<EOF >/etc/systemd/network/external.network
[Match]
Name=external
[Network]
DHCP=no
IPv6AcceptRA=no
LinkLocalAddressing=no
EOF
    
```
#### 04\. Write 'mgmt0' External Bridge Host Virtual Port Interface Configuration
```sh
cat <<EOF >/etc/systemd/network/mgmt0.network 
[Match]
Name=mgmt0
[Link]
#MACAddress=02:49:92:7d:ae:1c
[Network]
DHCP=no
IPv6AcceptRA=no
LinkLocalAddressing=no
Address=$(ip a s ${external_NIC} | awk '/inet /{print $2}' | head -n 1)
Gateway=$(ip r | awk '/default /{print $3}' | head -n 1)
DNS=8.8.8.8
DNS=8.8.4.4
EOF
    
```
#### 05\. Write 'internal' Internal Bridge Networkd Configuration
```sh
cat <<EOF >/etc/systemd/network/internal.network
[Match]
Name=internal
[Network]
DHCP=no
IPv6AcceptRA=no
LinkLocalAddressing=no
EOF
    
```
#### 06\. Write 'mgmt0' External Bridge Host Virtual Port Interface Configuration
```sh
cat <<EOF >/etc/systemd/network/mgmt1.network 
[Match]
Name=mgmt1
[Network]
DHCP=no
IPv6AcceptRA=no
LinkLocalAddressing=no
Domains=ministack.dev
Address=${ocp_ministack_SUBNET}.2/24
EOF
    
```
#### 07\. Write 'ocp-mini-stack' OpenShift Internal Bridge Networkd Configuration
```sh
cat <<EOF >/etc/systemd/network/ocp-mini-stack.network
[Match]
Name=ocp-mini-stack
[Network]
DHCP=no
IPv6AcceptRA=no
LinkLocalAddressing=no
EOF
    
```
#### 08\. Write External Network Build & Hand Off OneShot Utility
```sh
cat <<EOF >~/external-mgmt0-setup
#!/bin/bash
run_net_setup () {
 systemctl stop    NetworkManager
 systemctl enable --now ovs-vswitchd
 ovs-vsctl add-br external             \
  -- add-port external ${external_NIC} \
  -- add-port external mgmt0           \
  -- set interface mgmt0 type=internal \
  -- set interface mgmt0 mac="$(echo "${HOSTNAME} external mgmt0" | md5sum \
  | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02\\:\1\\:\2\\:\3\\:\4\\:\5/')"
 ln -fs /usr/lib/systemd/resolv.conf /etc/resolv.conf
 systemctl restart ovs-vswitchd.service
 systemctl enable  --now systemd-networkd.service
 systemctl enable  --now systemd-resolved.service
ovs-clear
}
run_net_setup
EOF
    
```
#### 09\. Write Internal Network Build & Hand Off OneShot Utility
```sh
cat <<EOF >~/internal-mgmt1-setup
#!/bin/bash
ovs-vsctl add-br internal \
 -- add-port internal mgmt1 \
 -- set interface mgmt1 type=internal \
 -- set interface mgmt1 mac="$(echo "$HOSTNAME internal mgmt1" | md5sum \
 | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02\\:\1\\:\2\\:\3\\:\4\\:\5/')"
systemctl restart systemd-networkd.service
ovs-clear
EOF
    
```
#### 10\. Write OCP-MINI-STACK Network Build OneShot Utility
```sh
cat <<EOF >~/ocp-mini-stack-bridge-setup
#!/bin/bash
ovs-vsctl add-br ocp-mini-stack
systemctl restart systemd-networkd.service
ovs-clear
EOF
    
```
#### 11\. Write OpenVSwitch Cleaning Maintenance Utility
```sh
cat <<EOF >/usr/bin/ovs-clear
#!/bin/bash
run_ovs_clear () {
for i in \$(ovs-vsctl show | awk '/error: /{print \$7}'); do
  ovs-vsctl del-port \$i;
done
clear && ovs-vsctl show
}
run_ovs_clear
EOF
    
```
```sh
chmod +x /usr/bin/ovs-clear
```
#### 12\. Link OVS Network-Online.wants dependencies
```sh
ln -s /usr/lib/systemd/system/ovsdb-server.service /etc/systemd/system/network-online.target.wants/ovdb-server.service
ln -s /usr/lib/systemd/system/ovs-vswitchd.service /etc/systemd/system/network-online.target.wants/ovs-vswitchd.service
```
#### 13\. Disable NetworkManager & Link Configuration Files for easy refrence
```sh
ln -f /etc/systemd/network/*.network ~
systemctl disable NetworkManager
```
#### 14\. Run Network Standup Utilities
```sh
 . ~/external-mgmt0-setup
 . ~/internal-mgmt1-setup
 . ~/ocp-mini-stack-bridge-setup

```
#### 15\. Reboot
```sh
shutdown -r now
```
--------------------------------------------------------------------------------
# Part 03 -- Create Libvirt OpenVSwitch Configurations
#### 00\. Enable Libvirt Service
```sh
systemctl enable --now libvirtd
```
#### 00\. Backup & Destroy 'default' NAT Libvirt Bridge
```sh
mkdir ~/.bak 2>/dev/null \
  ; virsh net-dumpxml default | tee ~/.bak/virsh-net-default-bak.xml \
  ; virsh net-destroy default && virsh net-undefine default
    
```
#### 00\. Write 'external' Network Profile xml
```sh
cat <<EOF >~/virsh-net-external-on-external.xml
<network>
  <name>external</name>
  <forward mode='bridge'/>
  <bridge name='external' />
  <virtualport type='openvswitch'/>
</network>
EOF
    
```
#### 00\. Write 'default' Network Profile .xml
```sh
cat <<EOF >~/virsh-net-default-on-internal.xml
<network>
  <name>default</name>
  <forward mode='bridge'/>
  <bridge name='internal' />
  <virtualport type='openvswitch'/>
</network>
EOF
     
```
#### 00\. Write 'internal' Network Profile xml
```sh
cat <<EOF >~/virsh-net-internal-on-internal.xml
<network>
  <name>internal</name>
  <forward mode='bridge'/>
  <bridge name='internal' />
  <virtualport type='openvswitch'/>
</network>
EOF
    
```
#### 00\. Write 'ocp-mini-stack' Network Profile xml
```sh
cat <<EOF >~/virsh-net-ocp-mini-stack-on-ocp-mini-stack.xml
<network>
  <name>ocp-mini-stack</name>
  <forward mode='bridge'/>
  <bridge name='ocp-mini-stack' />
  <virtualport type='openvswitch'/>
</network>
EOF
    
```
#### 00\. Define all networks from xml definitions
```sh
for xml in virsh-net-default-on-internal.xml virsh-net-internal-on-internal.xml virsh-net-external-on-external.xml virsh-net-ocp-mini-stack-on-ocp-mini-stack.xml ; do virsh net-define ~/${xml}; done
```
#### 00\. Set all networks to start & autostart
```sh
for virshet in external default internal ocp-mini-stack; do virsh net-start ${virshet}; virsh net-autostart ${virshet}; done
```
#### 00\. Verify Networks & Status
```sh
virsh net-list --all
```
  - Example Output:
```sh
 Name             State    Autostart   Persistent
---------------------------------------------------
 default          active   yes         yes
 external         active   yes         yes
 internal         active   yes         yes
 ocp-mini-stack   active   yes         yes
```
--------------------------------------------------------------------------------
# Part 04 -- Initialize LXC / LXD Container Service
#### 00\. Add user to LXD Group
```sh
usermod -aG lxd ${ministack_UNAME}
```
#### 00\. Initialize LXD Daemon & Base Configuration Settings
```sh
lxd init
```
  - Example Init Configuration:
```sh
WARNING: cgroup v2 is not fully supported yet, proceeding with partial confinement
Would you like to use LXD clustering? (yes/no) [default=no]: no
Do you want to configure a new storage pool? (yes/no) [default=yes]: yes
Name of the new storage pool [default=default]: default
Name of the storage backend to use (btrfs, ceph, dir, lvm) [default=btrfs]: btrfs
Create a new BTRFS pool? (yes/no) [default=yes]: yes
Would you like to use an existing block device? (yes/no) [default=no]: no
Size in GB of the new loop device (1GB minimum) [default=15GB]: 32
Would you like to connect to a MAAS server? (yes/no) [default=no]: no
Would you like to create a new local network bridge? (yes/no) [default=yes]: no
Would you like to configure LXD to use an existing bridge or host interface? (yes/no) [default=no]: yes
Name of the existing bridge or host interface: external
Would you like LXD to be available over the network? (yes/no) [default=no]: yes
Address to bind LXD to (not including port) [default=all]: all
Port to bind LXD to [default=8443]: 8443
Trust password for new clients: 
Again: 
Would you like stale cached images to be updated automatically? (yes/no) [default=yes] yes
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: yes
```
#### 00\. Backup original container profile
```sh
lxc profile copy default original
```
#### 00\. Reboot
```sh
shutdown -r now
```
--------------------------------------------------------------------------------
# Optional Configuration Settings 
#### 00\. Disable Desktop GUI Environment (CLI Console / Headless SSH Mode)
```sh
systemctl set-default multi-user.target
```
#### 00\. Set VIM as Default Editor
```sh
update-alternatives --set editor /usr/bin/vim
```
#### 00\. Disable Password Requirement for Primary User (WARNING: Lab Use Only)
```sh
echo "${ministack_UNAME} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${ministack_UNAME}
```
--------------------------------------------------------------------------------
## Next Steps:
  + [02 Build Bastion]
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
