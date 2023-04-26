# ~/.bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

. "${HOME}/.local/src/bash/.env"
. "${HOME}/.local/src/bash/.config"
. "${HOME}/.local/src/bash/.colors"
. "${HOME}/.local/src/bash/.prompt"
. "${HOME}/.local/src/bash/.aliases"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

complete -C /usr/bin/terraform terraform
