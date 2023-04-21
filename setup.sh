#!/usr/bin/env bash

brew update --auto-update

brew install \
  asdf \
  git \
  make  \
  curl  \
  exa  \
  gcc  \
  gpg \
  libpolkit-gobject-1-dev  \
  node \
  golang  \
  python@3.11
  npm  \
  elixir  \
  ruby  \
  ruby-dev \
  gem \
  neovim  \
  terraform \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  shellcheck \
  python3-venv  \
  openjdk-11-jre  \
  libglib2.0-dev-bin  \
  python3-pip  \
  python3-setuptools  \
  default-jd \
  uuid-runtime  \
  universal-ctags  \
  curl  \
  shfmt \
  rustup \
  wget  \
  stow  \
  tmux \
  cargo \
  fonts-powerline  \
  neofetch  \
  silversearcher-ag  \
  ripgrep  \
  jq  \
  fzf  \
  fd-find

# install ruby
asdf plugin add ruby
asdf install ruby 3.2.2
asdf global ruby 3.2.2

#exit 0
#
#mkdir -p ~/.local/bin/
#mkdir -p ~/.local/share/
#mkdir -p ~/.local/src/
#mv ~/.bashrc ~/.bashrc.orig

## snap
#sudo snap install shfmt
#sudo snap install rustup --classic

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# NPM
sudo npm i -g \
  neovim \
  yarn \
  eslint \
  catj \
  figlet-cli \
  neovim \
  typescript \
  terminal-image-cli \
  nb.sh

# TODO - create wrappers around markdown-preview, figlet-cli, and terminal-image-cli, nb.sh

# pip
python3.11 -m pip install --user \
  jedi \
  rich \
  flake8 \
  pylint \
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
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
rustup +nightly component add rust-analyzer-preview rust-src
cargo install \
  bat \
  git-delta \
  du-dust
mkdir -p ~/.local/share/bash-completions/completions/
rustup completions bash cargo >> ~/.local/share/bash-completions/completions/cargo
rustup completions bash rustup >> ~/.local/share/bash-completions/completions/rustup

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-3270-nerd-font
brew install --cask font-fira-mono-nerd-font
brew install --cask font-inconsolata-go-nerd-font
brew install --cask font-inconsolata-lgc-nerd-font
brew install --cask font-inconsolata-nerd-font
brew install --cask font-monofur-nerd-font
brew install --cask font-overpass-nerd-font
brew install --cask font-ubuntu-mono-nerd-font
brew install --cask font-agave-nerd-font
brew install --cask font-arimo-nerd-font
brew install --cask font-anonymice-nerd-font
brew install --cask font-aurulent-sans-mono-nerd-font
brew install --cask font-bigblue-terminal-nerd-font
brew install --cask font-bitstream-vera-sans-mono-nerd-font
brew install --cask font-blex-mono-nerd-font
brew install --cask font-caskaydia-cove-nerd-font
brew install --cask font-code-new-roman-nerd-font
brew install --cask font-cousine-nerd-font
brew install --cask font-daddy-time-mono-nerd-font
brew install --cask font-dejavu-sans-mono-nerd-font
brew install --cask font-droid-sans-mono-nerd-font
brew install --cask font-fantasque-sans-mono-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-go-mono-nerd-font
brew install --cask font-gohufont-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-hasklug-nerd-font
brew install --cask font-heavy-data-nerd-font
brew install --cask font-hurmit-nerd-font
brew install --cask font-im-writing-nerd-font
brew install --cask font-iosevka-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-lekton-nerd-font
brew install --cask font-liberation-nerd-font
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-monoid-nerd-font
brew install --cask font-mononoki-nerd-font
brew install --cask font-mplus-nerd-font
brew install --cask font-noto-nerd-font
brew install --cask font-open-dyslexic-nerd-font
brew install --cask font-profont-nerd-font
brew install --cask font-proggy-clean-tt-nerd-font
brew install --cask font-roboto-mono-nerd-font
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-shure-tech-mono-nerd-font
brew install --cask font-space-mono-nerd-font
brew install --cask font-terminess-ttf-nerd-font
brew install --cask font-tinos-nerd-font
brew install --cask font-ubuntu-nerd-font
brew install --cask font-victor-mono-nerd-font

curl -fLO https://releases.hashicorp.com/terraform-ls/0.25.2/terraform-ls_0.25.2_linux_amd64.zip
unzip terraform-ls_0.25.2_linux_amd64.zip -d "$HOME/.local/src/terraform-ls"
ln -s "/home/mblumber/.local/src/terraform-ls/terraform-ls" "/home/mblumber/.local/bin/"
rm terraform-ls_0.25.2_linux_amd64.zip

# terraform lsp
wget -q https://releases.hashicorp.com/terraform-ls/0.13.0/terraform-ls_0.13.0_linux_amd64.zip -o ~/local/bin/terraform-ls
chmod +x ~/local/bin/terraform-ls

# use bash 5
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

echo "To complete tmux installation, run tmux and hit prefix + I"
