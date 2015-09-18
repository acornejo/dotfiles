# This file is sourced by all *interactive* bash shells on startup.  This
# file should generate *no output* or it will break the scp and rcp commands.

# Add ~/.local/bin to path
if [[ ":$PATH:" != *":$HOME/.local/bin"* ]]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# Add ~/.bin to path
if [[ ":$PATH:" != *":$HOME/.bin:"* ]]; then
    export PATH=$HOME/.bin:/usr/local/bin:$PATH
fi

for bashrc in ~/.bash.pre.*; do
    test -f "$bashrc" && source "$bashrc"
done

# Check if SSH agent present, if not start one.
if [ -z "$SSH_AUTH_SOCK" ]; then
    SSH_AGENT_FILE=`eval "echo ~$USER"`/.ssh-agent-${HOSTNAME}
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

# set TERM variable
if [ "$TERM" = "xterm" ]; then
    export COLORTERM="xterm-256color"
    export TERM="xterm-256color"
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

# set git completion
if [ -f "$HOME/.git-completion.bash" ]; then
    . "$HOME/.git-completion.bash"
fi

# set up fzf
export FZF_DEFAULT_OPTS='--bind alt-p:page-up,alt-n:page-down'
hash ag 2>/dev/null && export FZF_DEFAULT_COMMAND='ag -l -g ""'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Set bc options
if [ -f "$HOME/.bc" ]; then
    export BC_ENV_ARGS="$HOME/.bc"
fi

# Customize prompt
if [ "$PS1" ]; then
    if [ "$TERM" = "dumb" ]; then
        reset=""
        black=""
        blue=""
        cyan=""
        green=""
        orange=""
        purple=""
        red=""
        violet=""
        white=""
        yellow=""
    elif tput setaf 1 &> /dev/null; then
        reset=$(tput sgr0);
        # Solarized colors, taken from http://git.io/solarized-colors.
        black=$(tput setaf 0);
        blue=$(tput setaf 33);
        cyan=$(tput setaf 37);
        green=$(tput setaf 64);
        orange=$(tput setaf 166);
        purple=$(tput setaf 125);
        red=$(tput setaf 124);
        violet=$(tput setaf 61);
        white=$(tput setaf 15);
        yellow=$(tput setaf 136);
    else
        reset="\e[0m";
        black="\e[1;30m";
        blue="\e[1;34m";
        cyan="\e[1;36m";
        green="\e[1;32m";
        orange="\e[1;33m";
        purple="\e[1;35m";
        red="\e[1;31m";
        violet="\e[1;35m";
        white="\e[1;37m";
        yellow="\e[1;33m";
    fi

    if [[ "$TERM" = *"xterm"* ]]; then
        titleString="\[\033]0;\w\007\]"
    else
        titleString=""
    fi

    if [ "$USER" = "root" ]; then
        userColor="$red"
        promptColor="$red"
        promptString="#"
    else
        userColor="$orange"
        promptColor="$white"
        promptString="$"
    fi

    if [ -n "$SSH_CONNECTION" ] && [ -z "$STY" ]; then
        sshString="\[$white\]ssh@"
    else
        sshString=""
    fi

    if [ -r "$HOME/.git-prompt.sh" ]; then
        . "$HOME/.git-prompt.sh"
        gitString="\$(__git_ps1 \"\[$white\] on \[$yellow\]%s\")"
    else
        gitString=""
    fi

    export PS1="\n${titleString}\[$userColor\]\u\[$white\] at $sshString\[$blue\]\h\[$white\] in \[$green\]\w$gitString\n\[$promptColor\]$promptString\[$reset\] "
    export PS2="> "
    export PS4="+ "

    unset reset black blue cyan green orange purple red violet white yellow titleString userColor promptColor promptString gitString
fi

# for autojump
if [ -f "/usr/share/autojump/autojump.bash" ]; then
    . /usr/share/autojump/autojump.bash
elif [ -f "/usr/local/share/autojump/autojump.bash" ]; then
    . /usr/local/share/autojump/autojump.bash
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
export LESS="-RSX"
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
export HISTSIZE=10000
shopt -s histappend   # append to history file
shopt -s cmdhist      # allow multiline history cmds
shopt -s histreedit   # edit history if cmd failed
shopt -s histverify   # allow editing history command before executing
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
alias history_reload="history -c; history -r"

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
alias v="$EDITOR"
alias vi="$EDITOR"
alias vim="$EDITOR"

# aliases: default options
alias rm="rm -i"
alias ping="ping -c4 -t4"
alias route="route -n"
alias netstat="netstat -n"
alias bc="bc -q -l"
alias du="du -h -s -c *"

# aliases: clipboard
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ccopy="pbcopy"
    alias cpaste="pbpaste"
else
    alias ccopy="xclip -selection c"
    alias cpaste="xclip -selection c -o"
fi

# aliases: process management
alias pa="/bin/ps axo user,pid,pcpu,pmem,command"
alias p="/bin/ps xo user,pid,pcpu,pmem,command"

# aliases: git
alias g="git"
if [ "$(type -t _git)" = "function" ]; then
    complete -o default -o nospace -F _git g
fi

# aliases: ack/ag
if hash ack-grep 2>/dev/null; then
    alias ack="ack-grep"
fi
if hash ag 2>/dev/null; then
    alias a="ag"
else
    alias a="ack"
fi

# aliases: todo.sh
if hash todo.sh 2>/dev/null; then
    alias t="todo.sh"
    complete -F _todo t
fi

if hash fzf 2>/dev/null; then
    fv() {
        local dir=${1:-.}
        local selected=$(ls "$dir" | fzf)
        if [ -n "$selected" ]; then
            if [ -d "$dir/$selected" ]; then
                fv "$dir/$selected"
            else
                ${EDITOR:-vim} "$dir/$selected"
            fi
        fi
    }
fi

# extend command not found to open files
if [ `type -t command_not_found_handle` ]; then
    eval "original_$(declare -f command_not_found_handle)"
    command_not_found_handle () {
        local FILE="$*"
        if [ -f "$FILE" ]; then
            local MIME_TYPE=$(file -L --mime-type --brief "$FILE")
            local MIME_CHARS=[[:alnum:]'!#$&.+-^_']
            # open text files in $EDITOR
            if [[ $MIME_TYPE =~ (text/$MIME_CHARS+|application/($MIME_CHARS+\+)?xml|application/x-empty) ]]; then
                $EDITOR "$FILE"
            else
                open "$FILE"
            fi
        elif [ -d "$FILE" ]; then
            cd "$FILE" && ls -p
        else
            original_command_not_found_handle
        fi
    }
fi

for bashrc in ~/.bash.post.*; do
    test -f "$bashrc" && source "$bashrc"
done
