# Stage 01 -- CloudCtl Bastion Setup

### Prerequisites:
  + [01 Build Host]
    
--------------------------------------------------------------------------------
#### 01\. Write LXD CloudCtl Profile
```sh
 . ~/.ccio/ocp-mini-stack/module/cloudctl/aux/bin/build-cloudctl-profile
```
#### 02\. Create & Start CloudCtl Container
```sh
lxc launch images:fedora/31/cloud/amd64 cloudctl -p cloudctl
```
#### 03\. Follow progress until cloud-init finish
  - NOTE: this process takes considerable time and may be anywhere from 5-30 minutes
```sh
lxc exec cloudctl -- tail -f /var/log/cloud-init-output.log
```
  - WARN: Do not proceed until cloud-init completes
#### 04\. SSH to CloudCtl as User
```sh
ssh ${ministack_UNAME}@${int_ministack_SUBNET}.3
```
#### 05\. Enable access to control the host LXD daemon
```sh
lxc remote add host ${ocp_ministack_OCP}.2 --accept-certificate --password ${ocp_ministack_OCP}.2
lxc remote switch host 
```
```sh
lxc list
```
#### 05\. Enable access to control the host Libvirt daemon
```sh
virsh net-list --all
```
#### 05\. Import all required docker images
```sh
podman image import docker.io/containercraft/ccio-dnsmasq:latest
podman image import docker.io/containercraft/ccio-haproxy:latest
podman image import docker.io/containercraft/ccio-isc-dhcp:alpine-latest
podman image import docker.io/containercraft/ccio-nginx
podman image import docker.io/containercraft/ccio-tftpd:alpine-latest
```
#### 06\. Reboot CloudCtl
```sh
sudo shutdown -r now
```
---------------------------------------------------------------------------------
### Next Steps:
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
