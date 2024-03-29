# ALIASES

# Directory navigation
alias cdd="cd -"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
 
# listings
alias ls='ls --color=auto'
alias ll='eza --all --classify --icons --group-directories-first --sort=extension --long --group'

# man alternative
alias man='tldr'
alias mann='/bin/man'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# kubernetes
alias kctl=kubectl
alias k=kubectl

# configuration shortcuts
alias bash_profile='nvim ~/.dotfiles/home/.bash_profile && source ~/.dotfiles/home/.bash_profile'
alias bashrc='nvim ~/.dotfiles/home/.bashrc && source ~/.dotfiles/home/.bashrc'
alias nvimrc='nvim ~/.dotfiles/home/.config/nvim/init.lua'

alias serve='npx http-static -p 8000'

# Todo
alias todo='pls'
