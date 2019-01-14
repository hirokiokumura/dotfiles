#!/bin/sh
set -eu

if [ ! -L ~/.zprezto -a -d ~/dotfiles/prezto ]; then
    ln -s ~/dotfiles/prezto ~/.zprezto
fi

#ln -sf ~/dotfiles/.vimrc ~/.vimrc
#ln -sf ~/dotfiles/.zshrc ~/.zshrc
#ln -sf ~/dotfiles/Brewfile ~/Brewfile
#ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.config/peco/config.json ~/.config/peco/config.json

for file in .z* .vimrc Brewfile .gitconfig ; do
    rm -i ~/$file
    ln -s $PWD/$file ~/$file
done
