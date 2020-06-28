# Stage 01 -- Base Hypervisor Setup
## Review checklist of prerequisites:
1. You have a clean install of [Fedora Workstation](https://getfedora.org/en/workstation/)
2. You have no critical data on the target system
3. You are familiar with and able to ssh between machines
4. You have created an ssh key pair & can ssh to the target host
5. Your SSH Public key is uploaded to a git service such as [Gitlab](https://gitlab.com/) or [Github](https://github.com/)
    
--------------------------------------------------------------------------------
#### Ansible Playbook Notes:
````
These playbooks are a rough work in progress and stubs out the future automation
of ministack setup with the goal of full CI/CD IaC implimentation in the future.
To date this playbook has been predominantly run locally on the target machine 
and executed against localhost. The following instructions loosely direct the
user on the steps required to build the full ocp stack with the aid of this
playbook. 
````
#### Alternatively, use the fully tested [Manual Method]
--------------------------------------------------------------------------------
# Part 00 -- Prepare Repo & Environment
#### 00\. Clone the ocp-mini-stack repo
```sh
sudo -i
dnf install git ansible -y
mkdir ~/.ccio 2>/dev/null && ln -s ~/.ccio ~/ccio
git clone https://github.com/ministackio/hypervisor.git ~/.ccio/hypervisor; cd ~/.ccio/Git/hypervisor/ansible/
```
#### 00\. Build MiniStack OpenShift Profile
```sh
 . ~/.ccio/ocp-mini-stack/module/host/aux/bin/init-ccio-profile
```
#### 02\. Configure Ansible Values
```sh
 vi ~/.ccio/ocp-mini-stack/ansible/hosts.yml
```
--------------------------------------------------------------------------------
# Part 01 -- Build Hypervisor Networking Layer
```sh
 ./network-setup -i hosts.yml
```
  - NOTE: you will loose SSH access if you are connected via ssh at this time
  - Resolution: ssh back to the same IP and start a new ssh session
--------------------------------------------------------------------------------
# Part 01 -- Build Hypervisor Virtualization Layer
```sh
 cd ~/.ccio/ocp-mini-stack/ansible/
 ./hypervisor-setup -i hosts.yml
```
--------------------------------------------------------------------------------
# Part 03 -- Build Gateway
#### 01\. Stage OpenWRT LXD Gateway Profile and Config Files
```sh
 ./gateway-setup -i hosts.yml
```
#### 02\. Build OpenWRT Image & Initialize Gateway
```sh
mkdir /tmp/openwrt
sudo podman run --privileged --rm -it --name openwrt_builder --volume /tmp/openwrt:/root/bin:z containercraft/ccio-openwrt-builder:19.07.2
/bin/bash
lxc image import /tmp/openwrt/openwrt-19.07.2-x86-64-lxd.tar.gz --alias openwrt/19.07.2/x86_64
lxc init openwrt/19.07.2/x86_64 gateway -p openwrt
```
#### 03\. Push Config directory to Gateway
```sh
 lxc file push -r /tmp/openwrt/config gateway/etc/
```
#### 04\. Start Gateway and monitor for Address Configuration
```sh
 lxc start gateway
 watch -c lxc list
 lxc exec gateway -- passwd root
```
#### 05\. Start Gateway and monitor for Address Configuration
  - Login to the OpenWRT WebUI @ the 'eth0' IP address with `http://${address}:8081`
---------------------------------------------------------------------------------
## Optional:
#### Connect additional physical host interfaces to OVS bridges
  - Example: attaching port 'eth1' to ovs bridge 'external'
```sh
 add-port external eth1
```
  - Example: attaching port 'enp2s0' to ovs bridge 'internal'
```sh
 add-port internal enp2s0
```

---------------------------------------------------------------------------------
### Next Steps:
  + [03 Build Bastion]
  + [04 Setup_Dns]
  + [05 Setup HAProxy]
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
  + [08 Setup Tftpd]
  + [09 Deploy Cloud]
  + [10 Configure Cloud]
--------------------------------------------------------------------------------
<!-- Markdown link & img dfn's -->
[Ansible Automation]:/ansible/README.md
[Manual Method]:/01_Build_Host_ManualMethod.md
[00 Introduction]:/00_Introduction.md
[01 Build Host]:/01_Build_Host.md
[02 Build Gateway]:/02_Build_Gateway.md
[03 Build Bastion]:/03_Build_Bastion.md
[04 Setup_Dns]:/04_Setup_DNS.md
[05 Setup HAProxy]:/05_Setup_HAProxy.md
[06 Setup Dhcp]:/06_Setup_DHCP.md
[07 Setup Nginx]:/07_Setup_Nginx.md
[08 Setup Tftpd]:/08_Setup_Tftpd.md
[09 Deploy Cloud]:/09_Deploy_Cloud.md
[10 Configure Cloud]:/10_Configure_Cloud.md
