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
	nvm uninstall 12
	nvm install v20.11.0
	nvm alias default v20.11.0
	nvm use --delete-prefix v20.11.0

	# ruby
	sudo snap install ruby --classic

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
		ncurses-devel \
		gcc \
		make \
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
		fd-find
	#regolith-desktop  \
	#i3xrocks-net-traffic  \
	#i3xrocks-cpu-usage  \
	#i3xrocks-time  \
	#i3xrocks-memory  \
	#i3xrocks-weather
	sudo dnf group install "Development Tools"

	# cargo
	source "$HOME/.cargo/env"
	rustup default stable
	rustup +nightly component add \
		rust-analyzer-preview \
		rust-src

	cargo install \
		du-dust \
		git-delta \
		eza

	mkdir -p ~/.local/share/bash-completions/completions/
	rustup completions bash cargo >>~/.local/share/bash-completions/completions/cargo
	rustup completions bash rustup >>~/.local/share/bash-completions/completions/rustup

	# snap
	sudo snap install --edge nvim --classic
	sudo snap install shfmt

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
		pyright

	# ruby
	# TODO - resolve issue with glibc 2.29
	gem install \
		neovim \
		solargraph \
		reek \
		rubocop

	# go
	go install golang.org/x/tools/gopls@latest

	# fonts
	git clone https://github.com/ryanoasis/nerd-fonts ~/.local/src/nerd-fonts --depth 1
	~/.local/src/nerd-fonts/install.sh

	# wezterm
	sudo dnf install -y https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203_110809_5046fc22-1.centos8.x86_64.rpm

	# alacritty
	pushd /alt/.local/src/
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty
	cargo build --release
	sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
	sudo ln -fs target/release/alacritty /usr/local/bin
	sudo ln -fs extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	sudo desktop-file-install extra/linux/Alacritty.desktop
	sudo update-desktop-database
	cp extra/completions/alacritty.bash ~/.bash_completion.d/alacritty
	popd
}

## TODO - create wrappers around markdown-preview, figlet-cli, and terminal-image-cli, nb.sh

# TODO - install the following:
# nodejs golang npm ruby gem terraform python3-venv
#: elixir
#: default-jd
#: dconf-cli
#: uuid-runtime
#: universal-ctags
#: fzf

#add_repositories
#install_langs
#install_libraries
