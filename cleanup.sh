rpm -q kernel-core
dnf remove -y kernel-core-4.18.0-383.el8.x86_64 kernel-core-4.18.0-408.el8.x86_64
dnf list --installed|grep el8
dnf remove -y inih-56-1.el8
dnf install -y inih
rm -f /boot/vmlinuz-0-rescue-b2a198ecbfdd451cb905f76f825af01e /boot/initramfs-0-rescue-b2a198ecbfdd451cb905f76f825af01e.img /boot/loader/entries/b2a198ecbfdd451cb905f76f825af01e-0-rescue.conf
/usr/lib/kernel/install.d/51-dracut-rescue.install add $(uname -r) /boot /boot/vmlinuz-$(uname -r)
nf module reset -y nodejs perl perl-IO-Socket-SSL perl-libwww-perl php satellite-5-client virt
firewall-cmd --permanent --zone=public --add-forward
firewall-cmd --reload
