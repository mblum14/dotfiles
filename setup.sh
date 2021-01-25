#!/usr/bin/env bash

# TODO - install
sudo apt install git \
	         vim \
	         neovim \
		 dconf-cli \
                 uuid-runtime \
		 stow \
		 tmux \
		 fonts-powerline


# Remap caps-lock -> ctrl
setxkbmap -layout us -option ctrl:nocaps
