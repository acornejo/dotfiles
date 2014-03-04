# This file is sourced by all *interactive* bash shells on startup.  This
# file should generate *no output* or it will break the scp and rcp commands.

# Check if SSH agent present, if not start one.
if [ -z "$SSH_AGENT_PID" ]; then
    SSH_AGENT_FILE=$HOME/.ssh-agent-${HOSTNAME}
    SSH_NEED_AGENT="yes"
    if [ -f "$SSH_AGENT_FILE" ]; then
        . $SSH_AGENT_FILE
        if kill -0 $SSH_AGENT_PID &> /dev/null
        then
            SSH_NEED_AGENT="no"
        fi
    fi
    if [ "$SSH_NEED_AGENT" = "yes" ]; then
        ssh-agent | sed "s/^echo/#echo/" > $SSH_AGENT_FILE
        . $SSH_AGENT_FILE
    fi
    unset SSH_AGENT_FILE SSH_NEED_AGENT
fi

# Set path
if [[ ":$PATH:" != *":$HOME/.bin:"* ]]; then
    export PATH=$HOME/.bin:/usr/local/bin:$PATH
fi

# Latex environment variables
if [ -e "$HOME/.latex" ]; then
    export TEXINPUTS=.:$HOME/.latex:
    export BSTINPUTS=$TEXINPUTS
    export BIBINPUTS=$TEXINPUTS
fi

# Python startup
if [ -e "$HOME/.pythonrc" ]; then
    export PYTHONSTARTUP="$HOME/.pythonrc"
fi

# Load color palette for dir listing
if [ -f "$HOME/.DIR_COLORS" ] && hash dircolors 2>/dev/null
then
    eval $(dircolors -b $HOME/.DIR_COLORS)
fi
# Set bash completion
if [ -f "$HOME/.bash_completion" ]; then
    . "$HOME/.bash_completion"
fi

# Set bc options
if [ -f "$HOME/.bc" ]; then
    export BC_ENV_ARGS="$HOME/.bc"
fi

if hash ack-grep 2>/dev/null; then
    alias ack="ack-grep"
fi

# Customize prompt
if [ "$PS1" ]; then
    # Change colors and display depending on terminal
    if [ "$TERM" = "dumb" ]; then
        HCOLOR=""
        PCOLOR=""
        TCOLOR=""
        UCOLOR=""
        USYMBOL="$"
        GCOLOR=""
    else
        HCOLOR='\[\e[1;31m\]'
        PCOLOR='\[\e[34m\]'
        TCOLOR='\[\e[00m\]'
        UCOLOR='\[\e[1;32m\]'
        GCOLOR='\[\e[33m\]'
        USYMBOL='$'
        PKIND='\w'
        # Use different color for root user
        if [ "$USER" = "root" ]; then
            UCOLOR='\[\e[1;31m\]'
            USYMBOL='#'
        fi
        # Display special string if on SSH connection
        if [ -n "$SSH_CONNECTION" ] && [ -z "$STY" ]; then
            PSTRING="[ssh@${HCOLOR}\h${TCOLOR}]"
            HSTRING=""
        else
            PSTRING=""
            HSTRING=""
        fi
        # Set terminal title
        if [ "$TERM" = "xterm" ]; then
            export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a; echo -ne "\033]0;${PSTRING}${PWD/${HOME}/~}\007""
        else
            export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
        fi
    fi

    GIT_PS1=""
    if [ -r "$HOME/.git-prompt.sh" ]; then
        . "$HOME/.git-prompt.sh"
        GIT_PS1="\$(__git_ps1)"
    fi

    export PS1="${PSTRING}${TCOLOR}[${HSTRING}${PCOLOR}${PKIND}${GCOLOR}${GIT_PS1}${TCOLOR}]${UCOLOR}${USYMBOL}${TCOLOR} "
    export PS2="> "
    export PS4="+ "

    unset HCOLOR PCOLOR TCOLOR GCOLOR UCOLOR USYMBOL PKIND PSTRING GIT_PS1
fi

# for autojump
if [ -f "/usr/share/autojump/autojump.bash" ]; then
    . /usr/share/autojump/autojump.bash
elif [ -f "/usr/local/etc/autojump.bash" ]; then
    . /usr/local/etc/autojump.bash
fi

# set preferred applications
export EDITOR="vim"
export VISUAL=$EDITOR
export MANPAGER="less"
export BROWSER="google-chrome"

# For color in grep
export GREP_OPTIONS="--color=auto"

# For color in ls
export LS_OPTIONS="--color=auto"
export CLICOLOR="Yes"

# For color man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# History settings
export HISTIGNORE="&:ls:ll:l:[bf]g:exit"
export HISTCONTROL="erasedups"
export HISTFILESIZE=50000
shopt -s histappend
shopt -s cmdhist

# For glob expansion
if [ -n "$BASH_VERSINFO" ] && [ ${BASH_VERSINFO[0]} -eq 4 ]; then
    shopt -s globstar
fi

# for Darwin
if [[ "$OSTYPE" == "darwin"* ]]; then
    LS_OPTIONS="-G"
else
    alias open="xdg-open"
fi

# aliases: save typing
alias ..="cd .."
alias ...=" cd ../.."
alias ll="ls -l $LS_OPTIONS"
alias l="ll -h"
alias dir="ls -1"
alias f="find . -name"
alias v="$EDITOR"

# aliases: default options
alias rm="rm -i"
alias ping="ping -c4 -t4"
alias route="route -n"
alias netstat="netstat -n"
alias less="less -R"
alias bc="bc -q -l"
alias du="du -h -s -c *"

# aliases: process management
alias aps="/bin/ps axo user,pid,pcpu,pmem,command"
alias ps="ps xo user,pid,pcpu,pmem,command"
alias jobs="jobs -l"

# aliases: git
alias gg="git status -s"
alias gl="git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph"
alias gd="git diff"
alias gp="echo -n 'pushing..'; git push"
alias gca="git commit -a -m"
alias ga="git add"
alias gc="git commit -m"

bitclone () {
    local TERMS=(${1//// })
    if [ ${#TERMS[@]} -gt 1 ]; then
        local REPO_USER=${TERMS[0]}
        local REPO_NAME=${TERMS[1]}
    else
        local REPO_USER=${USER}
        local REPO_NAME=${1}
    fi
    REPO_NAME=$(basename ${REPO_NAME} .git).git
    git clone git@bitbucket.org:${REPO_USER}/${REPO_NAME}
}

hubclone () {
    local TERMS=(${1//// })
    if [ ${#TERMS[@]} -gt 1 ]; then
        local REPO_USER=${TERMS[0]}
        local REPO_NAME=${TERMS[1]}
    else
        local REPO_USER=${USER}
        local REPO_NAME=${1}
    fi
    REPO_NAME=$(basename ${REPO_NAME} .git).git
    git clone https://github.com/${REPO_USER}/${REPO_NAME}
}
