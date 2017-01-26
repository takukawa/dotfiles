#!/bin/bash

DOT_FILES=(.bash_profile .bashrc .gitconfig .tmux.conf .vimrc)

vimdir=$HOME/.vim
if [ ! -d $vimdir ]; then
    mkdir $vimdir
fi

if [ ! -d $vimdir/rc ]; then
    ln -fs $HOME/dotfiles/.vim/rc $vimdir/rc
fi

for file in ${DOT_FILES[@]}
do
    ln -fs $HOME/dotfiles/$file $HOME/$file
done
