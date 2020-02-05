# Additional refrence configuration

```sh
bash <(curl -Ss https://my-netdata.io/kickstart.sh)
pip install --upgrade glances
snap switch --channel=edge lxd
snap refresh lxd
cp -r /home/kmorgan/.ssh ~
/usr/bin/qemu-kvm -machine help
cat /proc/cpuinfo | egrep "vmx|svm"
dmesg | grep -E "DMAR|IOMMU"
```
```sh
dnf  install -y \
            m4 \
            gcc \
            gzip \
            gawk \
            dkms \
            flex \
            make \
            xmlto \
            gettext \
            openssl \
            hmaccalc \
            findutils \
            rpm-build \
            zlib-devel \
            java-devel \
            newt-devel \
            kernel-tools \
            kernel-devel \
            numactl-devel \
            ncurses-devel \
            kernel-headers \
            elfutils-devel \
            module-init-tools \
            elfutils-libelf-devel
```
