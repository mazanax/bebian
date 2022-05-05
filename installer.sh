#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

echo "Updating repositories"
apt update

echo "Upgrading software"
apt upgrade -y

echo "Installing tilda"
apt install -y tilda

for d in /home/*/ ; do
	CURRENT_USER=$(basename $d)
	mdkir -p "$d/.config/tilda/"
	pushd !$
	wget https://raw.githubusercontent.com/mazanax/bebian/master/.config/tilda/config_0
	chown -R $CURRENT_USER:$CURRENT_USER $d.config/tilda/
	popd
done

echo "Installing nvim"
apt install -y neovim

# install required plugins for neovim

echo "Installing snap"
apt install -y snapd

echo "-> installing telegram client"
snap install telegram-desktop

# create Telegram desktop icon in all home directories
# wget -O /home/mazanax/Desktop/Telegram.desktop https://raw.githubusercontent.com/mazanax/bebian/master/Desktop/Telegram.desktop
for d in /home/*/ ; do
	CURRENT_USER=$(basename $d)
	pushd "$d/Desktop"
	wget https://raw.githubusercontent.com/mazanax/bebian/master/Desktop/Telegram.desktop
	chown -R $CURRENT_USER:$CURRENT_USER $d/Desktop
	chmod +x Telegram.desktop
	popd
done
