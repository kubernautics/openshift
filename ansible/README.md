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
This playbook is a rough work in progress and stubs out the future automation
of ministack setup with the goal of full CI/CD IaC implimentation in the future.
To date this playbook has been predominantly run locally on the target machine 
and executed against localhost. The following instructions loosely direct the
user on the steps required to build the full ocp stack with the aid of this
playbook. 
````
--------------------------------------------------------------------------------
# Part 00 -- Prepare Repo & Environment
#### 00\. Clone the ocp-mini-stack repo
```sh
sudo dnf install git ansible -y
git clone https://github.com/containercraft/ocp-mini-stack.git ~/.ccio/ocp-mini-stack
cd ~/.ccio/ocp-mini-stack/ansible/
```
#### 02\. Configure Ansible Values
```sh
 vi ~/.ccio/ocp-mini-stack/ansible/vars/user.yml
 vi ~/.ccio/ocp-mini-stack/ansible/hosts.yml
```
--------------------------------------------------------------------------------
# Part 01 -- Build Hypervisor
#### 01\. Run Hypervisor Setup Playbook
```sh
 ./hypervisor-setup -i hosts.yml
```
#### 02\. Run Network Systemd-Networkd Handoff script
```sh
 sudo /bin/bash bin/init-hypervisor-network
```
--------------------------------------------------------------------------------
# Part 02 -- Build RDP Enabled Bastion
#### 01\. Run Fedora LXD CloudCtl Bastion Setup Playbook
```sh
 ./bastion-setup -i hosts.yml
```
--------------------------------------------------------------------------------
# Part 03 -- Build Gateway
#### 01\. Stage OpenWRT LXD Gateway Profile and Config Files
```sh
 ./gateway-setup -i hosts.yml
```
#### 02\. Add Image Server & Initialize Gateway
```sh
 lxc remote add bcio https://images.braincraft.io --public --accept-certificate
 lxc init bcio:beeef940cbcb gateway -p openwrt
```
#### 03\. Push Config directory to Gateway
```sh
 lxc file push -r /tmp/openwrt/config gateway/etc/
```
#### 04\. Start Gateway and monitor for Address Configuration
```sh
 lxc start gateway
 watch -c lxc list
```
#### 05\. Start Gateway and monitor for Address Configuration
  - Login to the OpenWRT WebUI @ the 'eth0' IP address with `http://${address}:8081`
