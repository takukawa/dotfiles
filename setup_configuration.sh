#!/bin/bash

mode=faster
read -p "to faster (y/n) : " pronpt
if [ $pronpt = 'n' ]; then
    read -p "restore? (y/n) : " pronpt
    [ $pronpt = 'y' ] && mode='restore' || mode='nothing'
fi

if [ $mode = 'faster' ]; then
    echo 'animation faster'
    ## window animation
    defaults write -g NSWindowResizeTime -float 0.005
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

    ## finder animation
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
    defaults write com.apple.finder DisableAllAnimations -bool true

    ## mission-control animation
    defaults write com.apple.dock expose-animation-duration -float 0.05

    ## dock animation
    defaults write com.apple.dock launchanim -bool false

    ## quick-look animation
    defaults write -g QLPanelAnimationDuration -float 0
elif [ $mode = 'restore' ]; then
    echo 'restore animation-speed'
    ## window animation
    defaults write -g NSWindowResizeTime -float 1
    defaults write NSGlobalDomain NSWindowResizeTime -float 1

    ## finder animation
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool true
    defaults write com.apple.finder DisableAllAnimations -bool false

    ## mission-control animation
    defaults write com.apple.dock expose-animation-duration

    ## dock animation
    defaults write com.apple.dock launchanim -bool true

    ## quick-look animation
    defaults write -g QLPanelAnimationDuration -float 1
else
    echo 'nothing to do.'
fi

if [ ! $mode = 'nothing' ]; then
    echo 'killall Dock'
    killall Dock
fi
