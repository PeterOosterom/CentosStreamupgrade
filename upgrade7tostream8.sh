yum -y update
yum -y install epel-release
yum -y install rpmconf yum-utils
rpmconf -a
sudo package-cleanup --leaves
sudo package-cleanup --orphans
yum -y install dnf 
dnf -y update 
dnf -y install http://vault.centos.org/8.5.2111/BaseOS/x86_64/os/Packages/{centos-linux-repos-8-3.el8.noarch.rpm,centos-linux-release-8.5-1.2111.el8.noarch.rpm,centos-gpg-keys-8-3.el8.noarch.rpm}
dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf clean all
rpm -e `rpm -q kernel`
rpm -e --nodeps sysvinit-tools
#now upgrade centos8 to stream 8
dnf -y install centos-release-stream
dnf swap centos-{linux,stream}-repos
