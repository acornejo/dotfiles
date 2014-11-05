# This file is sourced by all *interactive* bash shells on startup.  This
# file should generate *no output* or it will break the scp and rcp commands.

# Set path
if [[ ":$PATH:" != *":$HOME/.bin:"* ]]; then
    export PATH=$HOME/.bin:/usr/local/bin:$PATH
fi

# Check if SSH agent present, if not start one.
if [ -z "$SSH_AUTH_SOCK" ]; then
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

# Disable suspend resume keys
if tty >/dev/null && hash stty 2>/dev/null; then
    stty stop ''
    stty start ''
    stty -ixon
    stty -ixoff
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

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe  ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# Load color palette for dir listing
if [ -f "$HOME/.dircolors" ] && hash dircolors 2>/dev/null; then
    eval $(dircolors -b $HOME/.dircolors)
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
            export COLORTERM="xterm-256color"
            export TERM="xterm-256color"
        #     export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} echo -ne "\033]0;${PSTRING}${PWD/${HOME}/~}""
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

# Color in ack
export ACK_MATCH_COLOR="bold red"

# For color in ls
export LS_OPTIONS="--color=auto"
export CLICOLOR="Yes"
# for Darwin
if [[ "$OSTYPE" == "darwin"* ]]; then
    LS_OPTIONS="-G"
fi

# For color man pages
export LESS="-FRSX"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# History settings
export HISTIGNORE="&:ls:ll:l:[bf]g:exit"
export HISTCONTROL="ignoredups:erasedups"
export HISTFILESIZE=50000
shopt -s histappend   # append to history file
shopt -s cmdhist      # allow multiline history cmds
shopt -s histreedit   # edit history if cmd failed
shopt -s histverify   # allow editing history command before executing
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Use newer bash features
if [ -n "$BASH_VERSINFO" ] && [ ${BASH_VERSINFO[0]} -eq 4 ]; then
    # For glob expansion
    shopt -s globstar
    # For autocd
    shopt -s autocd
else
    alias ..="cd .."
    alias ...=" cd ../.."
fi

# aliases: save typing
alias ll="ls -l $LS_OPTIONS"
alias l="ll -h"
alias dir="ls -1"
alias a="ack"
alias v="$EDITOR"
alias vi="$EDITOR"

# aliases: default options
alias rm="rm -i"
alias ping="ping -c4 -t4"
alias route="route -n"
alias netstat="netstat -n"
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
alias gu="echo -n 'pulling..'; git pull"
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

bitpublish () {
    local TERMS=(${1//// })
    if [ ${#TERMS[@]} -gt 1 ]; then
        local REPO_USER=${TERMS[0]}
        local REPO_NAME=${TERMS[1]}
    else
        local REPO_USER=${USER}
        local DEFAULT_REPO=$(basename $PWD)
        local REPO_NAME=${1:-$DEFAULT_REPO}
    fi
    REPO_NAME=$(basename ${REPO_NAME} .git)
    curl --user $REPO_USER https://api.bitbucket.org/1.0/repositories/ --data name=$REPO_NAME 2>/dev/null
    if ! git rev-parse 2>/dev/null; then
        git init .
    fi
    git remote add origin git@bitbucket.org:$REPO_USER/${REPO_NAME}.git
    echo "repo ready: commit some work and do 'git push origin master'"
}

hubpublish () {
    local TERMS=(${1//// })
    if [ ${#TERMS[@]} -gt 1 ]; then
        local REPO_USER=${TERMS[0]}
        local REPO_NAME=${TERMS[1]}
    else
        local REPO_USER=${USER}
        local DEFAULT_REPO=$(basename $PWD)
        local REPO_NAME=${1:-$DEFAULT_REPO}
    fi
    REPO_NAME=$(basename ${REPO_NAME} .git)
    curl --user $REPO_USER https://api.github.com/user/repos --data '{"name":"$REPO_NAME"}' 2>/dev/null
    if ! git rev-parse 2>/dev/null; then
        git init .
    fi
    git remote add origin git@github.com:$REPO_USER/${REPO_NAME}.git
    echo "repo ready: commit some work and do 'git push origin master'"
}

# extend command not found to open files
if [ `type -t command_not_found_handle` ]; then
    eval "original_$(declare -f command_not_found_handle)"
    command_not_found_handle () {
        local FILE="$*"
        if [ -f "$FILE" ]; then
            local MIME_TYPE=$(file --mime-type --brief "$FILE")
            local MIME_CHARS=[[:alnum:]'!#$&.+-^_']
            # open text files in $EDITOR
            if [[ $MIME_TYPE =~ (text/$MIME_CHARS+|application/($MIME_CHARS+\+)?xml|application/x-empty) ]]; then
                $EDITOR "$FILE"
            else
                open "$FILE"
            fi
        else
            original_command_not_found_handle
        fi
    }
fi

for local_bash in ~/.bash.local.*; do
    if [ -f "$local_bash" ]; then
        source "$local_bash"
    fi
done
