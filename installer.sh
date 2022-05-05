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

