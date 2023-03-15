#first dump the database
su - postgres
pg_dumpall > dump_pg12.out

#remove the old postgres install
sudo su -
yum list installed | grep post
yum remove postgresql12* 

#update machine to centos 9
dnf update -y --allowerasing
dnf install -y http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-repos-9.0-18.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-stream-release-9.0-18.el9.noarch.rpm http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/centos-gpg-keys-9.0-18.el9.noarch.rpm
dnf -y --releasever=9-stream --allowerasing --setopt=deltarpm=false distro-sync
rpmdb --rebuilddb
dnf clean packages
dnf update -y
dnf -y groupupdate "Core" "Minimal Install"
rm -f /boot/vmlinuz-0-rescue-b2a198ecbfdd451cb905f76f825af01e /boot/initramfs-0-rescue-b2a198ecbfdd451cb905f76f825af01e.img /boot/loader/entries/b2a198ecbfdd451cb905f76f825af01e-0-rescue.conf
/usr/lib/kernel/install.d/51-dracut-rescue.install add $(uname -r) /boot /boot/vmlinuz-$(uname -r)

cd /etc/sysconfig/network-scripts/
mv ifcfg-eth0 ifcfg-enX0
sed -i 's/eth0/enX0/' ifcfg-enX0


reboot
rpm -q kernel-core
dnf remove -y kernel-core-4.18.0-383.el8.x86_64 kernel-core-4.18.0-408.el8.x86_64 kernel-core-4.18.0-394.el8.x86_64 kernel-devel-0:4.18.0-394.el8.x86_64



dnf module reset -y nodejs perl perl-IO-Socket-SSL perl-libwww-perl php httpd python36

dnf list --installed|grep el8

dnf remove -y inih-56-1.el8 iwl6000-firmware
dnf install -y inih

wget https://dl.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/Packages/m/man-pages-overrides-9.0.0.0-1.el9.noarch.rpm 
wget http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/libfido2-1.6.0-7.el9.x86_64.rpm
wget http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/libcbor-0.7.0-5.el9.x86_64.rpm
wget http://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages/javapackages-filesystem-6.0.0-3.el9.noarch.rpm
wget https://kojihub.stream.centos.org/kojifiles/packages/xorg-x11-font-utils/7.5/53.el9/x86_64/xorg-x11-font-utils-7.5-53.el9.x86_64.rpm


yum localinstall -y man-pages-overrides-9.0.0.0-1.el9.noarch.rpm libfido2-1.6.0-7.el9.x86_64.rpm libcbor-0.7.0-5.el9.x86_64.rpm javapackages-filesystem-6.0.0-3.el9.noarch.rpm xorg-x11-font-utils-7.5-53.el9.x86_64.rpm
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf install -y postgresql13 postgresql13-server
/usr/pgsql-13/bin/postgresql-13-setup initdb

systemctl start postgres13.service
#copy dump to new server doet dit wel ff in screen
su - postgres
psql -f dump_pg12.out postgres
 systemctl stop postgresql-13.service
dnf -qy module disable postgresql
dnf install -y postgresql15-server
/usr/pgsql-15/bin/postgresql-15-setup initdb
su - postgres

/usr/pgsql-15/bin/pg_upgrade \
  --old-datadir=/var/lib/pgsql/13/data \
  --new-datadir=/var/lib/pgsql/15/data \
  --old-bindir=/usr/pgsql-13/bin/ \
  --new-bindir=/usr/pgsql-15/bin/ \
  --check
