#!/usr/bin/env bash

# Show thumbnails
dconf write /org/gnome/nautilus/preferences/show-image-thumbnails '"always"'

# remap capslock to control
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

sudo add-apt-repository ppa:regolith-linux/release -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update

sudo apt-get install -y git
sudo apt-get install -y make 
sudo apt-get install -y curl 
sudo apt-get install -y exa 
sudo apt-get install -y gcc 
sudo apt-get install -y libgtk-3-dev 
sudo apt-get install -y libpolkit-gobject-1-dev 
sudo apt-get install -y vim 
sudo apt-get install -y nodejs 
sudo apt-get install -y golang 
sudo apt-get install -y npm 
sudo apt-get install -y elixir 
sudo apt-get install -y ruby 
sudo apt-get install -y ruby-dev 
sudo apt-get install -y gem 
sudo apt-get install -y python3-venv 
sudo apt-get install -y openjdk-11-jre 
sudo apt-get install -y libglib2.0-dev-bin 
sudo apt-get install -y python3-pip 
sudo apt-get install -y python3-setuptools 
sudo apt-get install -y default-jd
sudo apt-get install -y neovim 
sudo apt-get install -y dconf-cli 
sudo apt-get install -y uuid-runtime 
sudo apt-get install -y universal-ctags 
sudo apt-get install -y curl 
sudo apt-get install -y wget 
sudo apt-get install -y stow 
sudo apt-get install -y tmux
sudo apt-get install -y cargo
sudo apt-get install -y fonts-powerline 
sudo apt-get install -y regolith-desktop 
sudo apt-get install -y i3xrocks-net-traffic 
sudo apt-get install -y i3xrocks-cpu-usage 
sudo apt-get install -y i3xrocks-time 
sudo apt-get install -y i3xrocks-memory 
sudo apt-get install -y i3xrocks-weather 
sudo apt-get install -y neofetch 
sudo apt-get install -y silversearcher-ag 
sudo apt-get install -y ripgrep 
sudo apt-get install -y jq 
sudo apt-get install -y fzf 
sudo apt-get install -y fd-find

exit 0

mkdir -p ~/.local/bin/
mkdir -p ~/.local/share/
mkdir -p ~/.local/src/
mv ~/.bashrc ~/.bashrc.orig

# snap
sudo snap install shfmt
sudo snap install rustup --classic

# DPK
wget -q https://github.com/dandavison/delta/releases/download/0.5.1/git-delta_0.5.1_amd64.deb
sudo dpkg -i git-delta_0.5.1_amd64.deb
rm git-delta_0.5.1_amd64.deb

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# NPM
sudo npm i -g \
  neovim \
  yarn \
  markdown-preview \
  eslint \
  catj \
  figlet-cli \
  neovim \
  typescript \
  terminal-image-cli \
  nb.sh \

# TODO - create wrappers around markdown-preview, figlet-cli, and terminal-image-cli, nb.sh

# pip
sudo pip3 install jedi \
  rich \
  commonmark \
  virtualenv \
  poetry \
  neovim \
  pynvim \
  rope \
  black \
  autopep8 \
  yapf \
  vim-vint \
  markdownlint-cli2

# ruby
sudo gem install neovim

# rust
rustup +nightly component add rust-analyzer-preview
cargo install bat

# Fonts
git clone https://github.com/ryanoasis/nerd-fonts ~/.local/src/nerd-fonts --depth 1
~/.local/src/nerd-fonts/install.sh

# login image customizer
git clone https://github.com/thiggy01/gdm-background ~/.local/src/gdm-background
pushd ~/.local/src/gdm-background > /dev/null 2>&1
make
sudo make install
popd > /dev/null 2>&1

# language servers (LSP)
sudo npm i -g \
  awk-language-server \
  bash-language-server \
  cssmodules-language-server \
  diagnostic-languageserver \
  dockerfile-language-server-nodejs \
  emmet-ls \
  eslint \
  eslint_d \
  flow-bin \
  graphql-language-service-cli \
  stylelint \
  prettier \
  typescript-language-server  \
  vscode-langservers-extracted \
  vim-language-server \
  yaml-language-server

sudo pip3 install jedi-language-server pyright

go install golang.org/x/tools/gopls@latest

gem install --user-install \
  solargraph \
  reek

curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
unzip elixir-ls.zip -d "$HOME/.local/src/elixir-ls"
chmod +x "$HOME/.local/src/elixir-ls/language-server.sh"
ln -s "$HOME/.local/src/elixir-ls/language-server.sh" "$HOME/.local/bin/elixir-ls"
rm elixir-ls.zip

curl -fLO https://releases.hashicorp.com/terraform-ls/0.25.2/terraform-ls_0.25.2_linux_amd64.zip
unzip terraform-ls_0.25.2_linux_amd64.zip -d "$HOME/.local/src/terraform-ls"
ln -s "$HOME/.local/src/terraform-ls/terraform-ls" "$HOME/.local/bin/"
rm terraform-ls_0.25.2_linux_amd64.zip

# terraform lsp
wget -q https://releases.hashicorp.com/terraform-ls/0.13.0/terraform-ls_0.13.0_linux_amd64.zip -o ~/local/bin/terraform-ls
chmod +x ~/local/bin/terraform-ls

# use local timezone
sudo timedatectl set-local-rtc 1 --adjust-system-clock

echo "To complete tmux installation, run tmux and hit prefix + I"
