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

# terragrunt
alias unlock="terragrunt force-unlock -force"
alias plan="terragrunt plan --source-update --download-dir ~/.terragrunt-cache"
alias apply="terragrunt apply --source-update --download-dir ~/.terragrunt-cache"
alias output="terragrunt output --source-update --download-dir ~/.terragrunt-cache"
alias init="terragrunt init --source-update --download-dir ~/.terragrunt-cache"
alias import="terragrunt import --source-update --download-dir ~/.terragrunt-cache"
alias state="terragrunt state --source-update --download-dir ~/.terragrunt-cache"
alias destroy="terragrunt destroy --source-update --download-dir ~/.terragrunt-cache"
