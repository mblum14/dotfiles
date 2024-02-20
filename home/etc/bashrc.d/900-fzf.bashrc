#!/usr/bin/env bash

export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git --exclude node_modules'
export FZF_COMPLETION_TRIGGERS='**'
export FZF_COMPLETION_OPTS='+c -x'
export FZF_TMUX_OPTIONS='-p 50'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_OPTS=" --color=bg+:#3c3836,bg:#32302f,spinner:#8ec07c,hl:#83a598""\
 --color=fg:#bdae93,header:#83a598,info:#fabd2f,pointer:#8ec07c""\
 --color=marker:#8ec07c,fg+:#ebdbb2,prompt:#fabd2f,hl+:#83a598"
