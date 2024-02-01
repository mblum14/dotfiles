# ~/.bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

. ~/.local/src/bash/.env
. ~/.local/src/bash/.config
. ~/.local/src/bash/.colors
. ~/.local/src/bash/.prompt
. ~/.local/src/bash/.aliases
. ~/.local/src/bash/.functions

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

complete -C /usr/bin/terraform terraform
