yum upgrade
dnf install epel-release
dnf install rpmconf
dnf install yum-utils
rpmconf -a  # answer "n" to both things
package-cleanup --leaves
package-cleanup --orphans
dnf install http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-repos-9.0-9.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-release-9.0-9.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-gpg-keys-9.0-9.el9.noarch.rpm
curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
curl -O https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm
rpm -Uvh *.rpm
yum update dnf module disable python36 python39 perl perl-IO-Socket-SSL perl-libwww-perl
dnf clean all
rpm -e `rpm -q kernel`
dnf -y --releasever=9 --allowerasing --setopt=deltarpm=false distro-sync swap python39-setuptools python3-setuptools
dnf clean all
rm -f /var/lib/rpm/__db*
rpm --rebuilddb
dnf -y groupupdate "Core" "Minimal Install"
