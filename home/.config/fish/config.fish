set -g theme_display_node yes
set -g theme_display_vi yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
set -g theme_display_aws_vault_profile yes
set -g theme_display_sudo_user yes
set -g theme_display_git_default_branch yes
set -g theme_color_scheme gruvbox
set -g theme_show_exit_status yes

set --universal FZF_DEFAULT_OPTS "--height 40"
set --universal FZF_ENABLE_OPEN_PREVIEW 1
set --universal FZF_FIND_FILE_COMMAND "fdfind --type f --hidden --follow --exclude .git --exclude node_modules"
set --universal FZF_CD_COMMAND "fdfind --type f --hidden --follow --exclude .git --exclude node_modules"
set --universal FZF_CD_WITH_HIDDEN_COMMAND "fdfind --type f --hidden --follow --exclude .git --exclude node_modules"
set --universal FZF_PREVIEW_FILE_CMD "bat"

set --universal JAVA_HOME "/usr/lib/jvm/default-java"
set --universal JDK_HOME "/usr/lib/jvm/default-java"

if status is-interactive
and not set -q TMUX
  exec tmux
end
#starship init fish | source
