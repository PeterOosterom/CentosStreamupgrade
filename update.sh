dnf update -y
dnf repoquery --extras
dnf remove -y NetworkManager-initscripts-updown-1:1.40.0-1.el8.noarch grub2-tools-efi-1:2.02-129.el8.x86_64  libmetalink-0:0.1.3-7.el8.x86_64 pciutils-0:3.7.0-1.el8.x86_64 python3-configobj-0:5.0.6-11.el8.noarch python3-schedutils-0:0.6-6.el8.x86_64 rdma-core-0:41.0-1.el8.x86_64
dnf install -y http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-repos-9.0-18.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-release-9.0-18.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-gpg-keys-9.0-18.el9.noarch.rpm
dnf -y --releasever=9-stream --allowerasing --setopt=deltarpm=false distro-sync
rpmdb --rebuilddb
dnf clean packages
dnf update -y
dnf -y groupupdate "Core" "Minimal Install"
rpm -q kernel-core
dnf install -y inih
rm -f /boot/vmlinuz-0-rescue-b2a198ecbfdd451cb905f76f825af01e /boot/initramfs-0-rescue-b2a198ecbfdd451cb905f76f825af01e.img /boot/loader/entries/b2a198ecbfdd451cb905f76f825af01e-0-rescue.conf
/usr/lib/kernel/install.d/51-dracut-rescue.install add $(uname -r) /boot /boot/vmlinuz-$(uname -r)
dnf module reset -y nodejs perl perl-IO-Socket-SSL perl-libwww-perl php virt
