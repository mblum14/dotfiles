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
PATH=$HOME/.cargo/bin:$GOPATH/bin:/snap/bin:$PATH
MYVIMRC=$HOME/.local/nvim/init.vim
JAVA_HOME=/usr/lib/jvm/default-java
JDK_HOME=/usr/lib/jvm/default-java

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# pls - todo cli app
export PLS_ERROR_LINE_STYLE="#fb4934"
export PLS_ERROR_TEXT_STYLE="#cc241d bold"

export PLS_WARNING_LINE_STYLE="#d79921"
export PLS_WARNING_TEXT_STYLE="#d79921 bold"

export PLS_UPDATE_LINE_STYLE="#b8bb26"
export PLS_UPDATE_TEXT_STYLE="#b8bb26 bold"

export PLS_INSERT_DELETE_LINE_STYLE="#b16286"

export PLS_INSERT_DELETE_TEXT_STYLE="#ebdbb2"

export PLS_MSG_PENDING_STYLE="#b8bb26"
export PLS_TABLE_HEADER_STYLE="#d3869b"
export PLS_TASK_DONE_STYLE="#ebdbb2"
export PLS_TASK_PENDING_STYLE="#b16286"
export PLS_HEADER_GREETINGS_STYLE="#d79921"
export PLS_QUOTE_STYLE="#ebdbb2"
export PLS_AUTHOR_STYLE="#ebdbb2"

export PLS_BACKGROUND_BAR_STYLE="bar.back"
export PLS_COMPLETE_BAR_STYLE="bar.complete"
export PLS_FINISHED_BAR_STYLE="bar.finished"
