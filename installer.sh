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

# put config to home directories

echo "Installing nvim"
apt install -y neovim

# install required plugins for neovim

echo "Installing snap"
apt install -y snapd

echo "-> installing telegram client"
snap install telegram-desktop

# create Telegram desktop icon in all home directories
# wget -O /home/mazanax/Desktop/Telegram.desktop https://raw.githubusercontent.com/mazanax/bebian/master/Desktop/Telegram.desktop
