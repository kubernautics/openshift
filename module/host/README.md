# Part 01 -- Host System Setup
## Review checklist of prerequisites:
1. You have a clean install of Fedora Desktop
2. You have no critical or unsaved data on this system
3. You are familiar with and able to ssh between machines
4. You have created an ssh key pair
5. Your Public key is uploaded to a git service such as [Gitlab](https://gitlab.com/) or [Github](https://github.com/)
6. Recommended: Follow these guides using ssh to copy/paste commands as you read along

--------------------------------------------------------------------------------
# System Setup & User Access

#### 00\. Change to Root & Backup User Files
```sh
sudo -i 
passwd root
mkdir ~/.bak && mv ~/* ~/.bak/
```

#### 00\. Configure SSH & Keys
```sh
ssh-keygen -f ~/.ssh/id_rsa -N ''
curl -L https://github.com/usrbinkat.keys | tee -a ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys && chown root:root -R ~/.ssh
systemctl enable --now sshd
```

#### 00\. Set SELinux to Permissive
```sh
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
```

#### 00\. Run System Updates & Install Base Packages
```sh
dnf update  -y
dnf install -y xz tar git tmux htop grubby iperf3 glances hostname neofetch net-tools vim-enhanced openssh-server
```
#### 00\. Install Libvirt / Qemu / KVM & Utilities
```sh
dnf  install -y libvirt qemu-kvm virt-top qemu-kvm qemu-img edk2-ovmf virt-viewer virt-manager virt-install libvirt-client python3-libvirt libguestfs-tools libvirt-daemon-kvm libguestfs-tools-c libvirt-daemon-qemu 
```
#### 00\. Install OpenVSwitch Packages
```sh
dnf install -y openvswitch network-scripts-openvswitch
```
#### 00\. Install LXC via LXD Container Stack
```sh
dnf install -y snapd && snap list & sleep 3
install snapd
ln -s /var/lib/snapd/snap /snap
snap install lxd
```
#### 00\. Configure Kernel Module
```sh
echo 'options kvm_intel nested=1' >/etc/modprobe.d/qemu-system-x86.conf
echo 'vfio-pci'                   >/etc/modules-load.d/vfio-pci.conf
```
#### 00\. Configure Grub Menu
```sh
sed  -i 's/GRUB_TERMINAL_OUTPUT="console"/GRUB_TERMINAL_OUTPUT="serial"/g'                     /etc/default/grub
echo    'GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"' >>/etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```
#### 00\. Configure Kernel Arguments
```sh
grubby --update-kernel=ALL --remove-args="quiet splash"
grubby --update-kernel=ALL --args="intel_iommu=on iommu=pt kvm-intel.nested=1 kvm_intel.nested=1 net.ifnames=0 biosdevname=0 pci=noaer console=ttyS0,115200n8"
```
## 00\. Reboot
```sh
shutdown -r now
```

--------------------------------------------------------------------------------
## 00\. A
```sh
```

### 00\. Clone the ocp-mini-stack repo:

```sh
git clone git@github.com:containercraft/ocp-mini-stack.git
```

### 01\. Create CCIO OCP-Mini-Stack Profile
