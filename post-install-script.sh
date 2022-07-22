#!/bin/bash


#nala 
sudo apt update;
sudo apt install -y wget;

echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null

sudo apt install -y nala;

#system apps

sudo nala install -y \
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
sudo nala install -y\
    ca-certificates \
    curl \
    gnupg \
    lsb-release;

sudo mkdir -p /etc/apt/keyrings;

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg ;

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

sudo nala update;
sudo nala install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin;

# set text editor
sudo update-alternatives --set editor /usr/bin/vim.gtk3;

#apps

echo 'INSTALL APPS' 

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;

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
	;

# Autoremove
sudo nala autoremove -y

#ohmyzsh

echo 'CHANGE SHELL'
chsh -s $(which zsh);
zsh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

