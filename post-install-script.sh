#!/bin/bash


#nala 
apt update;
apt install -y wget;

echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null

apt install -y nala;

#system apps

nala install -y \
	zsh \
       	vim-gtk3 \
       	git \
       	curl \
       	wget \
       	flatpak \
       	python3 \
       	python3-pip \
       	python3-venv \
      	tilix \
       	input-remapper \
       	ubuntu-restricted-extras \
	gparted \
	timeshift \
	wifi-qr \
	gnome-sushi \
	gnome-tweaks \
	tree \
	;

#docker
nala install -y\
    ca-certificates \
    curl \
    gnupg \
    lsb-release;

mkdir -p /etc/apt/keyrings;

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg ;

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

nala update;
nala install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin;

# set text editor
update-alternatives --set editor /usr/bin/vim.gtk3;

#apps

echo 'INSTALL APPS' 

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;

flatpak install -y \
	com.google.Chrome \
	com.spotify.Client \
	com.discordapp.Discord \
	org.videolan.VLC \
	com.bitwarden.desktop \
	org.telegram.desktop \
	com.slack.Slack \
	us.zoom.Zoom \
	org.kde.okular \
	com.vscodium.codium \
	org.gnome.Cheese \
	net.ankiweb.Anki \
	org.signal.Signal \
	;

# Autoremove
nala autoremove -y

#ohmyzsh

echo 'CHANGE SHELL'
sudo -u $SUDO_USER sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

#install anaconda3
mkdir temp;
cd temp;
wget -O - https://www.anaconda.com/distribution/ 2>/dev/null | sed -ne 's@.*\(https:\/\/repo\.anaconda\.com\/archive\/Anaconda3-.*-Linux-x86_64\.sh\)\">64-Bit (x86) Installer.*@\1@p' | xargs wget;
sudo -u sh *.sh
cd ..;
rm -rf temp;
