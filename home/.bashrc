# ~/.bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

for bashrc in $(find ${HOME}/etc/bashrc.d/ -name "*.bashrc" | sort); do
	source ${bashrc}
done
