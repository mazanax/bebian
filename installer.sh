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
	mkdir -p "$d/.config/tilda/"
	pushd "$d/.config/tilda/"
	rm config_0 2> /dev/null # remove config if exists
	wget https://raw.githubusercontent.com/mazanax/bebian/master/.config/tilda/config_0
	chown -R $CURRENT_USER:$CURRENT_USER "$d/.config/tilda/"
	popd
	
	mkdir -p "$d/.local/share/systemd/user/"
	pushd "$d/.local/share/systemd/user/"
	rm tilda.service 2> /dev/null # remove tilda.service if exists
	wget https://raw.githubusercontent.com/mazanax/bebian/master/.local/share/systemd/user/tilda.service
	chown -R $CURRENT_USER:$CURRENT_USER "$d/.local/share/systemd/user/"
	sudo -u $CURRENT_USER systemctl --user enable tilda.service
	popd
done

echo "Installing nvim"
apt install -y neovim

# install required plugins for neovim

echo "Installing snap"
apt install -y snapd

echo "-> installing telegram client"
snap install telegram-desktop

for d in /home/*/ ; do
	CURRENT_USER=$(basename $d)
	pushd "$d/Desktop"
	rm Telegram.desktop 2> /dev/null # remove desktop entry if exists
	wget https://raw.githubusercontent.com/mazanax/bebian/master/Desktop/Telegram.desktop
	chown -R $CURRENT_USER:$CURRENT_USER $d/Desktop
	chmod +x Telegram.desktop
	popd
done
