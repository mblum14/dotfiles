#!/usr/bin/env bash

# Show thumbnails
dconf write /org/gnome/nautilus/preferences/show-image-thumbnails '"always"'

sudo add-apt-repository ppa:regolith-linux/release -y
sudo apt-get install -y git \
												make \
												gcc \
												libgtk-3-dev \
												libpolkit-gobject-1-dev \
												vim \
												nodejs \
												golang \
												npm \
												elixir \
												ruby \
												ruby-dev \
												gem \
												python3-venv \
												openjdk-11-jre \
												libglib2.0-dev-bin \
												python3-pip \
												python3-setuptools \
												neovim \
												dconf-cli \
												uuid-runtime \
												universal-ctags \
												curl \
												wget \
												stow \
												tmux \
												fonts-powerline \
												regolith-desktop-complete \
												i3xrocks-net-traffic \
												i3xrocks-cpu-usage \
												i3xrocks-time \
												neofetch \
												bat \
												silversearcher-ag \
												ripgrep \
												zsh \
												fish \
												jq \
												fzf \
												fd-find

# snap
sudo snap install shfmt

# DPK
wget -q https://github.com/dandavison/delta/releases/download/0.5.1/git-delta_0.5.1_amd64.deb
sudo dpkg -i git-delta_0.5.1_amd64.deb
rm git-delta_0.5.1_amd64.deb

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# NPM
sudo npm i -g neovim yarn markdown-preview eslint catj figlet-cli neovim typescript diagnostic-languageserver terminal-image-cli nb.sh

# TODO - create wrappers around markdown-preview, figlet-cli, and terminal-image-cli, nb.sh

# pip
sudo pip3 install jedi rich commonmark virtualenv poetry neovim pynvim rope black autopep8 yapf vim-vint markdownlint-cli2

# Fonts
mkdir -p ~/.local/src/
git clone https://github.com/ryanoasis/nerd-fonts ~/.local/src/nerd-fonts --depth 1 
~/.local/src/nerd-fonts/install.sh

# login image customizer
mkdir -p ~/.local/src/
git clone https://github.com/thiggy01/gdm-background ~/.local/src/gdm-background
pushd ~/.local/src/gdm-background > /dev/null 2>&1
make
sudo make install
popd > /dev/null 2>&1

# use local timezone
sudo timedatectl set-local-rtc 1 --adjust-system-clock

# oh-my-zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install PatrickF1/fzf.fish
fisher install oh-my-fish/theme-bobthefish

# default shell
chsh -s $(which fish)
