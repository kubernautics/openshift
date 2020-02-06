# Stage 01 -- CloudCtl Bastion Setup
--------------------------------------------------------------------------------
# Part 00 -- 
#### 00\. 
```sh
```
--------------------------------------------------------------------------------
# Part 00 -- Build LXD CloudCtl Container
#### 00\. Write LXD CloudCtl Profile
```sh
 . ~/.ccio/module/cloudctl/aux/bin/build-cloudctl-profile
```
#### 00\. Create & Start CloudCtl Container
```sh
lxc init images:fedora/31 cloudctl -p cloudctl
lxc start cloudctl
```
#### 00\. Push host SSH assets to CloudCtl
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
lxc file push /etc/sudoers.d/kmorgan cloudctl/etc/sudoers.d/kmorgan
lxc file push -r ~/.ssh cloudctl/home/${ministack_UNAME}/
lxc exec cloudctl -- /bin/bash -c "chown -R ${ministack_UNAME}:${ministack_UNAME} /home/${ministack_UNAME}"
lxc config device add cloudctl ccio-home disk source=~/.ccio path=/home/${ministack_UNAME}/.ccio
lxc exec cloudctl -- /bin/bash -c "passwd ${ministack_UNAME}"
```
#### 00\. 
```sh
lxc exec cloudctl -- /bin/bash -c "dnf update && dnf install openssh-server -y"
lxc exec cloudctl -- /bin/bash -c "systemctl enable --now sshd"
ssh ${ministack_UNAME}@$(lxc list -c n,4 --format=csv | awk -F'[, ]' '/eth0/{print $2}')
```
#### 00\. Setup NetworkManager Configuration
```sh
sudo dnf install -y NetworkManager NetworkManager-tui
sudo systemctl enable --now NetworkManager
sudo nmcli con del ens3
sudo nmcli device set eth0 managed yes
sudo nmcli device set eth1 managed yes
sudo nmcli connection add type ethernet con-name eth1 ifname eth1 ipv4 ${ocp_ministack_SUBNET}.3/24 ipv4.dns "8.8.8.8 8.8.4.4"

```
#### 00\. 
```sh
```
#### 00\. 
```sh
```
#### 00\. 
```sh
```
#### 00\. 
```sh
```
#### 00\. 
```sh
```
#### 00\. 
```sh
```
#### 00\. 
```sh
```
#### 00\. 
```sh
```
#### 00\. 
```sh
```

# REFRENCE
grep ccio /etc/group
lxc config device add cloudctl ccio disk source=~/.ccio path=/home/${ministack_UNAME}/.ccio shift=true
lxc config set c1 raw.idmap "both 1000 1000"

