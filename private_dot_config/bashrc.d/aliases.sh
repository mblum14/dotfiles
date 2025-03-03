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
# Execute a command with an AWS profile or set the AWS_PROFILE to the target
function _with_aws_profile() {
  # Check if the AWS_PROFILE argument is provided
  if [[ -z "$1" ]]; then
    echo "Usage: _with_aws_profile <AWS_PROFILE> [command...]"
    return 1
  fi

  local profile="$1"
  shift

  if [[ $# -eq 0 ]]; then
    export AWS_PROFILE="${profile}"
  fi

  # Execute the command with AWS_PROFILE set
  AWS_PROFILE="${profile}" "$@"
}

alias ea-infra='_with_aws_profile ea-infra'
alias ea-infra-admin='_with_aws_profile ea-infra-adm'
alias ea-dev='_with_aws_profile ea-dev'
alias ea-dev-admin='_with_aws_profile ea-dev-adm'
alias ea-prod='_with_aws_profile ea-prod'
alias ea-prod-admin='_with_aws_profile ea-prod-adm'
alias hz-dev='_with_aws_profile hz-dev'
alias hz-dev-admin='_with_aws_profile hz-dev-admin'
alias hz-prod='_with_aws_profile hz-prod'
alias hz-prod-admin='_with_aws_profile hz-prod-admin'
