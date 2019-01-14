#!/bin/sh
set -eu

if [ ! -L ~/.zprezto -a -d ~/dotfiles/prezto ]; then
    ln -s ~/dotfiles/prezto ~/.zprezto
fi

ln -sf ~/dotfiles/.config/peco/config.json ~/.config/peco/config.json

FILELIST="
.z*
.vimrc
Brewfile
.gitconfig
"

for FILE in ${FILELIST};
do
    rm -rf ~/${FILE}
    ln -s $PWD/${FILE} ~/${FILE}
done
