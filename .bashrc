
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

PROMPT_COMMAND=SET_PROMPT_WITH_GIT_AND_EXITSTATUS
function SET_PROMPT_WITH_GIT_AND_EXITSTATUS {
    EXITSTATUS="$?"
    BOLD="\[\033[1m\]"
    RED="\[\033[1;31m\]"
    GREEN="\[\e[1;32m\]"
    BLUE="\[\e[34;1m\]"
    OFF="\[\033[m\]"
    GIT=`parse_git_branch`

    PROMPT="\n\t ${GREEN}${GIT}${OFF} ${BLUE}\w${OFF}\n"

    if [ "${EXITSTATUS}" -eq 0 ]
    then
       PS1="${PROMPT}${BOLD}${GREEN}:)${OFF} \$ "
    else
       PS1="${PROMPT}${BOLD}${RED}:(${OFF} \$ "
    fi
    PS2="${BOLD}>${OFF} "
}

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
    	STAT=`parse_git_dirty`
    	echo "[${BRANCH}${STAT}]"
    else
    	echo "[nonGit]"
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
    	bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
    	bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
    	bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
    	bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
    	bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
    	bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
    	echo " ${bits}"
    else
    	echo ""
    fi
}
