# Stage 00 -- Introduction & Objectives
--------------------------------------------------------------------------------
```
Currently under heavy development this ocp ministack has been functionally
tested extensively and is a mature v1 architecture design. 

Feature highlights of current gen design includes:
 - Ability to publicly deliver services via low cost ensign host.
 - Completely self contained single host lab with multi host expandability options
 - Zero network or service configuration dependencies external to the host
 - Zero risk of dns/dhcp leakage onto external networks
 - Fully featured and normal network implimentation & behavior
 - Fully automated production like multi-node-cloud CoreOS provisioning (virtual guest nodes)

Current development status:
 - Manual setup method documentation is over 90% complete & functional
 - Ansible Development
   - Host Hypervisor Playbook 100% functional (see issue board for rc1 tasks)
   - VFW Gateway Playbook 90% functional - (see issue board for rc1 tasks)
   - CloudCtl Bastion Playbook ~25% functional - incomplete -
   - Infra Docker Container Playbook 0% complete, will be the most simple playbook
   - Infrastructure Docker Container images & deployment steps are 100% complete & Functional

RC1 Development Cycle architecture objectives can be seen in the design below. All
feature development for RC1 has been implimented in the project at this time and
barring extenuating circumstances we are in a feature freeze. Additional FRE
bugs are welcome and will immidiately be staged to RC2 development cycle 
objectives. 
```
![CCIO_OCP MiniStack Lab_Diagram](zweb/drawio/rc1-design-goals/rc1-design-objectives.svg)

  + [00 Introduction]
  + [01 Build Host]
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
