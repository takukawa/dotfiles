#!/bin/bash

# sudo xcodebuild -license

# homebrew
mode=nothing
package=homebrews
if [ ! -e /usr/local/bin/brew ]; then
    echo "install ${package}..."
else
    read -p "update ${package}? (y/n) : " pronpt
fi
if [ $pronpt = 'y' ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "skip ${mode} ${package}"
fi

# coreutils
mode=nothing
package=coreutils
if [ ! -e /usr/local/bin/gls ]; then
    echo "install ${package}..."
    mode='install'
else
    read -p "update ${package}? (y/n) : " pronpt
    [ $pronpt = 'y' ] && mode='upgrade'
fi
if [ ! $mode = 'nothing' -a -e /usr/local/bin/brew ]; then
    brew $mode $package
else
    echo "skip ${mode} ${package}"
fi

# tmux
mode=nothing
package=tmux
if [ ! -e /usr/local/bin/$package ]; then
    echo "install ${package}..."
    mode='install'
else
    read -p "update ${package}? (y/n) : " pronpt
    [ $pronpt = 'y' ] && mode='upgrade'
fi
if [ ! $mode = 'nothing' -a -e /usr/local/bin/brew ]; then
    brew $mode $package
else
    echo "skip ${mode} ${package}"
fi

# vim +lua
mode=nothing
package=vim
check_vim=`vim --version | grep -e +lua`
if [ -z "$check_vim" ]; then
    echo "install ${package}..."
    mode='install'
else
    read -p "update ${package}? (y/n) : " pronpt
    [ $pronpt = 'y' ] && mode='upgrade'
fi
if [ ! $mode = 'nothing' -a -e /usr/local/bin/brew ]; then
    brew $mode $package --with-lua
else
    echo "skip ${mode} ${package}"
fi

# dotfiles
# dotfiles init
dotfilesdir=$HOME/dotfiles
if [ -d $dorfilesdir ]; then
    source $dotfilesdir/setup_dotfiles.sh
fi
