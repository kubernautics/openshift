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
sudo dnf update -y && sudo dnf install git ansible -y
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
 vim ~/.ccio/ocp-mini-stack/ansible/hosts.yml
```
--------------------------------------------------------------------------------
# Part 01 -- Build Hypervisor
#### 01\. Run Hypervisor Setup Playbook
```sh
cd ~/.ccio/ocp-mini-stack/ansible/
./hypervisor-setup -i ~/.ccio/ocp-mini-stack/hosts.yml
```
#### 02\. Run Network Systemd-Networkd Handoff script
```sh
 scp ~/.ccio/ocp-mini-stack/ansible/bin/init-hypervisor-network root@10.0.0.4:/bin/
 ssh root@10.0.0.4 'TERM=screen init-hypervisor-network'
 ssh root@10.0.0.4 'TERM=screen shutdown -r now'
```
