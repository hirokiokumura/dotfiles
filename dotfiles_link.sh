#!/bin/sh
set -eu

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/Brewfile ~/Brewfile
ln -fnsv ~/dotfiles/.config/peco/config.json ~/.config/peco/config.json
