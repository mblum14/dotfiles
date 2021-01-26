#!/usr/bin/env bash

sudo add-apt-repository ppa:regolith-linux/release -y
sudo apt install -y git \
	      vim \
	      neovim \
		    dconf-cli \
        uuid-runtime \
		    stow \
		    tmux \
		    fonts-powerline \
		    regolith-desktop \
		    i3xrocks-net-traffic \
		    i3xrocks-cpu-usage \
		    i3xrocks-time \
		    ctags \
		    curl \
		    wget \
		    bat \
		    silversearcher-ag \
		    ripgrep \
        nodejs \
		    golang \
        npm \
		    elixir \
        ruby \
        ruby-dev \
        gem \
        python3-venv \
        openjdk-11-jre \
        gnome-online-accounts

# DPK
wget -q https://github.com/dandavison/delta/releases/download/0.5.1/git-delta_0.5.1_amd64.deb
sudo dpkg -i git-delta_0.5.1_amd64.deb
rm git-delta_0.5.1_amd64.deb

# NPM
sudo npm i -g neovim

# Fonts
mkdir -p ~/.local/src/
git clone https://github.com/ryanoasis/nerd-fonts .local/src/nerd-fonts --depth 1 
./.local/src/nerd-fonts/install.sh
