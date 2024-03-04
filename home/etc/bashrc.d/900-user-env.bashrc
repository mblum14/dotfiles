#!/usr/bin/env bash
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

EDITOR=/usr/bin/nvim
TERM=screen-256color

if [[ -f /alt/GIT_TOKEN ]]; then
	. /alt/GIT_TOKEN
else
	echo 'GITHUB_TOKEN unset. Could not find /alt/GIT_TOKEN'
fi

# handled by ~/etc/bashrc.d/101-nvm-dir.bashrc
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # this loads nvm

export GOPATH=/alt/.local/lib/go
PATH=$HOME/.cargo/bin:$GOPATH/bin:/snap/bin:$PATH:/alt/.fzf/bin
MYVIMRC=$HOME/.local/nvim/init.vim
JAVA_HOME=/usr/lib/jvm/default-java
JDK_HOME=/usr/lib/jvm/default-java

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

