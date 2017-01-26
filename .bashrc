PS1='[\u@\h]\$ '

# dotfiles init
dotfilesdir=$HOME/dotfiles
if [ -d $dorfilesdir ]; then
    source $dotfilesdir/setup_dotfiles.sh
fi

export TERM="screen-256color"
alias tmux="tmux -2"
alias ls='gls'
alias ll='gls -lah --color=auto'
alias vi='vim'
alias g='git'
