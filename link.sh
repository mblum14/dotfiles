#!/usr/bin/env bash

if ! command -v stow &>/dev/null; then
	sudo dnf -y install stow
fi

function override_managed_files() {
	unlink ~/code >/dev/null 2>&1
	unlink ~/dev >/dev/null 2>&1
	unlink ~/.local/bin >/dev/null 2>&1
	mkdir -p ~/.local/bin
	rm ~/.gitconfig >/dev/null 2>&1
}

override_managed_files
stow home -t $HOME --ignore .bash_profile
pushd /alt/.local
stow bin -t $HOME/.local/bin
popd
