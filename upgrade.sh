yum upgrade
dnf update -y
dnf install rpmconf
dnf install yum-utils
rpmconf -a  # answer "n" to both things
dnf repoquery --unneededdnf remove -y NetworkManager-initscripts-updown-1:1.40.0-1.el8.noarch grub2-tools-efi-1:2.02-129.el8.x86_64  libmetalink-0:0.1.3-7.el8.x86_64 pciutils-0:3.7.0-1.el8.x86_64 python3-configobj-0:5.0.6-11.el8.noarch python3-schedutils-0:0.6-6.el8.x86_64 rdma-core-0:41.0-1.el8.x86_64
package-cleanup --leaves
package-cleanup --orphans
dnf install -y http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-repos-9.0-18.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-release-9.0-18.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-gpg-keys-9.0-18.el9.noarch.rpm
rpm -Uvh *.rpm
yum update dnf module disable python36 python39 perl perl-IO-Socket-SSL perl-libwww-perl
rpm -e `rpm -q kernel`
dnf -y --releasever=9 --allowerasing --setopt=deltarpm=false distro-sync swap python39-setuptools python3-setuptools
dnf clean all
restorecon -Rv /var/lib/rpm
rpmdb --rebuilddb
dnf clean all
dnf -y groupupdate "Core" "Minimal Install"
reboot
