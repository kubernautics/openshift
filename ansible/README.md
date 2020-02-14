# Stage 01 -- Base Hypervisor Setup
## Review checklist of prerequisites:
1. You have a clean install of [Fedora Workstation](https://getfedora.org/en/workstation/)
2. You have no critical data on this system
3. You are familiar with and able to ssh between machines
4. You have created an ssh key pair
5. Your SSH Public key is uploaded to a git service such as [Gitlab](https://gitlab.com/) or [Github](https://github.com/)
    
--------------------------------------------------------------------------------
# Part 00 -- Prepare Repo & Environment
#### 00\. Clone the ocp-mini-stack repo
```sh
sudo -i 
dnf update -y && dnf install git ansible -y
git clone https://github.com/containercraft/ocp-mini-stack.git ~/Git/ocp-mini-stack
ln -s ~/Git/ocp-mini-stack ~/.ccio/ocp-mini-stack
```
#### 01\. Build CCIO User Profile
```sh
 . ~/.ccio/ocp-mini-stack/module/host/aux/bin/build-profile-ccio
```
#### 02\. Configure Ansible Values
```sh
 vim ~/.ccio/ocp-mini-stack/ansible/user.yml
```
--------------------------------------------------------------------------------
# Part 01 -- Build Hypervisor
#### 01\. Run Hypervisor Setup Playbook
```sh
./hypervisor-setup -i ~/.ccio/ocp-mini-stack/hosts.yml
```
#### 02\. Run Hypervisor Setup Playbook
