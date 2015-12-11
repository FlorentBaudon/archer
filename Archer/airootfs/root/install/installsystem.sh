time cp -ax / /mnt
cp -vaT /run/archiso/bootmnt/arch/boot/x86_64/vmlinuz /mnt/boot/vmlinuz-linux
genfstab -U /mnt > /mnt/etc/fstab

#Lancement de la configuation de archer en chroot
arch-chroot /mnt /bin/bash -c "/root/install/configure.sh"

umount -R /mnt
