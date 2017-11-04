PS1='[\u@\h]\$ '

# dotfiles init
dotfilesdir=$HOME/dotfiles
if [ -d $dorfilesdir ]; then
    source $dotfilesdir/setup_dotfiles.sh
fi

eval $(/usr/local/bin/gdircolors ${dotfilesdir}/colors/dircolors.ansi-dark.txt)

export TERM="screen-256color"
alias tmux="tmux -2"
alias ls='gls'
alias ll='gls -lah --color=auto'
alias vi='vim'
alias g='git'
