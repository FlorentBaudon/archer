sed -i 's/Storage=volatile/#Storage=auto/' /etc/systemd/journald.conf

rm /etc/udev/rules.d/81-dhcpcd.rules

systemctl disable pacman-init.service choose-mirror.service
rm -r /etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount,getty@tty1.service.d}
rm /etc/systemd/scripts/choose-mirror

rm /etc/systemd/system/getty@tty1.service.d/autologin.conf
rm /root/{.automated_script.sh,.zlogin}
rm /etc/mkinitcpio-archiso.conf
rm -r /etc/initcpio
#Language genration Eng Text Fr Layout
locale-gen
#localectl set-x11-keymap fr

cp /root/install/syslinux.cfg /boot/syslinux/

syslinux-install_update -iam

mkinitcpio -p linux

rm -f /etc/systemd/system/default.target
systemctl enable dhcpcd
systemctl enable sddm

#initialisation de pacman
pacman-key --init
pacman-key --populate archlinux

#Configure bash par defaut
chsh -s /bin/bash root
rm -rf /root/.zshrc /root/.zcompdump /root/.zsh_history

rm -rf /root/install /root/install.txt /root/install.sh

#create user
read -p "Username : " name
read -s -p "Password : " password_clear
password=$(openssl passwd -1 $password_clear)
useradd -m $name -p $password
echo "$name ALL=(ALL) ALL" >> /etc/sudoers

#change
echo -e "$password_clear\n$password_clear" | passwd root
