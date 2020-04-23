[![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-tftpd/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-tftpd/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-tftpd?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-tftpd)<br>
[Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-tftpd) || [Find on Github](https://github.com/containercraft/ccio-tftpd)

### Prerequisites:
  + [00 Introduction]
  + [01 Build Host]
  + [02 Build Bastion]
  + [03 Build Gateway]
  + [04 Setup_Dns]
  + [05 Setup HAProxy]
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
--------------------------------------------------------------------------------
    
# Part 07 -- TFTPd: Network PXE Boot Resources
####    Step.01 Launch [tftp-hpa] on [Alpine Linux] Container with [Podman]
  - the tftp container will serve all files mounted to `/tftpboot/`
```sh
sudo podman run \
    --rm \
    --detach                                                                                        \
    --name    ocp-tftpd                                                                             \
    --publish ${ocp_ministack_SUBNET}.3:69:69/udp                                                   \
    --publish ${ocp_ministack_SUBNET}.3:69:69/tcp                                                   \
    --volume  ~/.ccio/ocp-mini-stack/module/tftpd/aux/tftpboot/pxelinux.cfg/:/tftpboot/pxelinux.cfg \
  docker.io/containercraft/ccio-tftpd:alpine-latest
```
    
    
---------------------------------------------------------------------------------
    
### Next Steps:
  + [09 Deploy Cloud]
  + [10 Configure Cloud]
    
---------------------------------------------------------------------------------
    
######  + [Repo Module] Index
```sh
.
├── aux
│   ├── systemd
│   │   └── tftp.service
│   └── tftpboot
│       └── pxelinux.cfg
│           ├── bootstrap.cfg
│           ├── compute.cfg
│           ├── infra.cfg
│           └── ldlinux.c32
└── README.md
```

<!-- Markdown link & img dfn's -->
[Repo Module]:/module/tftpd
[podman]: https://podman.io
[Alpine Linux]:https://alpinelinux.org/
[TFTPd]:http://freshmeat.sourceforge.net/projects/tftp-hpa/
[tftp-hpa]:http://freshmeat.sourceforge.net/projects/tftp-hpa/
--------------------------------------------------------------------------------
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
