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
alias awsume="source awsume"

# chezmoi
alias cm="chezmoi"

# podman
alias docker="podman"
alias docker-compose="podman-compose"

# terragrunt
alias unlock="terragrunt force-unlock -force"
alias plan="terragrunt plan --source-update --download-dir ~/.terragrunt-cache"
alias apply="terragrunt apply --source-update --download-dir ~/.terragrunt-cache"
alias output="terragrunt output --source-update --download-dir ~/.terragrunt-cache"
alias init="terragrunt init --source-update --download-dir ~/.terragrunt-cache"
alias import="terragrunt import --source-update --download-dir ~/.terragrunt-cache"
alias state="terragrunt state --source-update --download-dir ~/.terragrunt-cache"
alias destroy="terragrunt destroy --source-update --download-dir ~/.terragrunt-cache"

# aws profiles
alias ea-infra='aws.login ea-infra'
alias ea-infra-admin='aws.login ea-infra-adm'
alias ea-dev='aws.login ea-dev'
alias ea-dev-admin='aws.login ea-dev-adm'
alias ea-prod='aws.login ea-prod'
alias ea-prod-admin='aws.login ea-prod-adm'
alias hz-dev='aws.login hz-dev'
alias hz-dev-admin='aws.login hz-dev-admin'
alias hz-prod='aws.login hz-prod'
alias hz-prod-admin='aws.login hz-prod-admin'
alias localstack='aws.login localstack'
