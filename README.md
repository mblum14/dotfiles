# Dotfiles

## Initial Setup

```bash
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install minimal necessary binaries
/opt/homebrew/bin/brew install git chezmoi gpg

# set up SSH key
mkdir -p ~/.ssh
pushd ~/.ssh || exit 1
ssh-keygen -t ed25519 -C "mblum14@gmail.com" -f ~/.ssh/id_github
ssh-keygen -t ed25519 -C "mblum14@gmail.com" -f ~/.ssh/id_gitlab
eval "$(ssh-agent -s)"
echo "Add $(cat ~/.ssh/id_github.pub) to github SSH keys"
echo "Add $(cat ~/.ssh/id_gitlab.pub) to gitlab SSH keys"
read -p 'Press `enter` to continue once SSH keys have been uploaded'
popd || exit 1

# clone dotfiles
mkdir -p ~/Documents/projects/github/mblum14/
git clone git@github.com:mblum14/dotfiles ~/Documents/projects/github/mblum14/dotfiles
mkdir -p ~/.local/share
ln -fs ~/Documents/projects/github/mblum14/dotfiles ~/.local/share/chezmoi

# Apply dotfiles
export PATH="/opt/homebrew/bin:$PATH"
/opt/homebrew/bin/chezmoi init
/opt/homebrew/bin/chezmoi apply

```
