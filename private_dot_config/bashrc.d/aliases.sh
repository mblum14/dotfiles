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
alias lt='eza --tree --level=2 --long --icons --git'

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

# terraform
alias tf="terraform"

# terragrunt
alias tg="terragrunt"
alias tg.unlock="terragrunt force-unlock -force"
alias tg.plan="terragrunt plan --source-update --download-dir ~/.terragrunt-cache"
alias tg.apply="terragrunt apply --source-update --download-dir ~/.terragrunt-cache"
alias tg.output="terragrunt output --source-update --download-dir ~/.terragrunt-cache"
alias tg.init="terragrunt init --source-update --download-dir ~/.terragrunt-cache"
alias tg.import="terragrunt import --source-update --download-dir ~/.terragrunt-cache"
alias tg.state="terragrunt state --source-update --download-dir ~/.terragrunt-cache"
alias tg.destroy="terragrunt destroy --source-update --download-dir ~/.terragrunt-cache"

# aws profiles
alias sq-combine='aws.login sequoia-combine'
alias hz-dev='aws.login hz-dev'
alias hz-dev-legacy='aws.login hz-dev-legacy'
alias hz-dev-admin='aws.login hz-dev-adm'
alias hz-dev-ro='aws.login hz-dev-ro'
alias hz-prod='aws.login hz-prod'
alias hz-prod-legacy='aws.login hz-prod-legacy'
alias hz-prod-admin='aws.login hz-prod-adm'
alias hz-prod-ro='aws.login hz-prod-ro'
alias labs-infra='aws.login labs-infra'
alias labs-infra-admin='aws.login labs-infra-adm'
alias labs-playground='aws.login labs-playground'
alias labs-playground-admin='aws.login labs-playground-adm'
alias localstack='export AWS_PROFILE=localstack'
