#!/usr/bin/env bash

mkdir -p /alt/.local/bin/
mkdir -p /alt/.local/share/
mkdir -p /alt/.local/src/
mkdir -p /alt/.local/lib/

function add_repositories() {
	sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	sudo dnf install -y epel-release
	sudo dnf config-manager --set-enabled PowerTools
}

function install_langs() {
	# rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >sh.rustup.rs
	chmod +x sh.rustup.rs
	sudo ./sh.rustup.rs
	source "$HOME/.cargo/env"
	rustup default stable
	mv ~/.cargo /alt
	ln -sf /alt/.cargo ~/

	# nodejs
	# removing version installed by forge script
  ln -fs /alt/.nvm ~
	nvm uninstall 12
	nvm install v20.11.0
	nvm alias default v20.11.0
	nvm use --delete-prefix v20.11.0

	# ruby
	sudo dnf module reset ruby -y
	sudo dnf install @ruby:3.1 -y
	sudo dnf install ruby-devel -y

	# python
	python -m pip install --upgrade pip

	# go
	mkdir /alt/.local/src
	sudo rm -rf /usr/local/go
	wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
	sudo tar -C /usr/local/ go1.22.0.linux-amd64.tar.gz
	rm go1.22.0.linux-amd64.tar.gz
}

function install_libraries() {
	# dnf
	sudo dnf --disablerepo="*" --enablerepo="epel" install -y \
		git \
		make \
		cmake \
		curl \
		gcc \
		gcc-c++ \
		vim \
		docker-ce \
		docker-ce-cli \
		containerd.io \
		fontforge \
		fontconfig-devel \
		freetype-devel \
		libuv \
		libevent-devel \
		libxcb-devel \
		libxkbcommon-devel \
		libyaml-devel \
		openssl-devel \
		readline-devel \
		zlib-devel \
		ncurses-devel \
		bison \
		pkg-config
	  ShellCheck \
		python3-pip \
		python3-setuptools \
		powerline-fonts \
		wget \
		stow \
		fuse-libs \
		neofetch \
		ripgrep \
		jq \
		fd-find \
    xclip

	sudo dnf group install "Development Tools"

	# cargo
	source "$HOME/.cargo/env"
	rustup default stable
	rustup +nightly component add \
		rust-analyzer-preview \
		rust-src

	cargo install \
		bat \
		du-dust \
		git-delta \
		eza \
    stylua \
    tealdeer \
    starship \
    zoxide

  cargo install starship --locked

	mkdir -p ~/.local/share/bash-completions/completions/
	rustup completions bash cargo >>~/.local/share/bash-completions/completions/cargo
	rustup completions bash rustup >>~/.local/share/bash-completions/completions/rustup

	# snap
	sudo snap install --edge nvim --classic
	sudo snap install shfmt
	sudo snap install marksman

	# neovim
	sudo curl -o /usr/local/bin/nvim -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
	sudo chmod 755 /usr/local/bin/nvim

	# tmux
	# remove tmux installed by dnf
	sudo dnf -y remove tmux
	git clone https://github.com/tmux/tmux.git /alt/.local/src/tmux
	pushd /alt/.local/src/tmux
	git fetch --tag
	git checkout 3.2
	sh autogen.sh
	./configure
	make && sudo make install
	ln -s /alt/.local/src/tmux/tmux ~/.local/bin/
	popd
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	echo "To complete tmux installation, run tmux and hit prefix + I"

	# npm
	npm i -g \
		yarn \
		markdown-preview \
		markdownlint-cli \
		eslint \
		catj \
		figlet-cli \
		neovim \
		typescript \
		terminal-image-cli \
		nb.sh \
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
		prettier_d_slim \
		typescript-language-server \
		vscode-langservers-extracted \
		vim-language-server \
		yaml-language-server

	#pip
	python -m pip install jedi \
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
		markdownlint-cli2 \
		jedi-language-server \
    ruff-lsp \
		pyright \
    pls-cli

	# ruby
	# TODO - resolve issue with glibc 2.29
	gem install \
		neovim \
		solargraph \
		reek \
		rubocop

  # lua-language-server
  local lls_version="3.7.4"
  local lls_src_dir="/alt/.local/src/lua-language-server/${lls_version}"
  mkdir -p "${lls_src_dir}"
  pushd "${lls_src_dir}"
  wget "https://github.com/LuaLS/lua-language-server/releases/download/${lls_version}/lua-language-server-${lls_version}-linux-x64.tar.gz"
  tar xvzf "lua-language-server-${lls_version}-linux-x64.tar.gz"
  rm "lua-language-server-${lls_version}-linux-x64.tar.gz"
  ln -fs "${lls_src_dir}/bin/lua-language-server" ~/.local/bin/
  popd

	# go
	go install golang.org/x/tools/gopls@latest

	# fonts
	git clone https://github.com/ryanoasis/nerd-fonts ~/.local/src/nerd-fonts --depth 1
	~/.local/src/nerd-fonts/install.sh

	# terraform-docs
	curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.17.0/terraform-docs-v0.17.0-$(uname)-amd64.tar.gz
	tar -xzf terraform-docs.tar.gz
	chmod +x terraform-docs
	sudo mv terraform-docs /usr/local/bin/terraform-docs
	rm terraform-docs.tar.gz

  # tfsec
  go install github.com/aquasecurity/tfsec/cmd/tfsec@latest

  # trivy
  RELEASE_VERSION=$(grep -Po '(?<=VERSION_ID=")[0-9]' /etc/os-release)
  cat << EOF | sudo tee -a /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/$RELEASE_VERSION/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF
  sudo yum -y update
  sudo yum -y install trivy
}
## TODO - create wrappers around markdown-preview, figlet-cli, and terminal-image-cli, nb.sh

add_repositories
install_langs
install_libraries
