#!/usr/bin/env bash

# Directory navigation
alias cdd="cd -"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# listings
alias ls='ls --color=auto'
alias ll='eza --all --classify --icons --group-directories-first --sort=extension --long --group --git'

# kubernetes
alias kctl=kubectl
alias k=kubectl

# configuration shortcuts
alias bash_profile='nvim ~/.bash_profile && source ~/.bash_profile'
alias bashrc='nvim ~/.bashrc && source ~/.bashrc'
alias nvimrc='nvim ~/.config/nvim/init.lua'

alias serve='npx http-static -p 8000'

# Todo
alias todo='pls'

# lazygit
alias lg='lazygit'

# awsume
#alias awsume="source $(pyenv which awsume)"

# chezmoi
alias cm="chezmoi"
