set -g theme_display_node yes
set -g theme_display_vi yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
set -g theme_display_aws_vault_profile yes
set -g theme_display_sudo_user yes
set -g theme_display_git_default_branch yes
set -g theme_color_scheme gruvbox
set -g theme_show_exit_status yes

if status is-interactive
and not set -q TMUX
  exec tmux
end
#starship init fish | source
