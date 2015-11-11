PS2="> "
PS4="+ "
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# term title
if [ -z "${TERM##*xterm*}" ]; then
    PS1="\[\033]0;\w\007\]$PS1"
fi

# customize fzf keys
bind '"\C-g": " \C-e\C-u$(fcd)\e\C-e\er\C-m"'

# set history options
HISTIGNORE="&:?:??:???:exit:[ \t]*"
HISTCONTROL="ignorespace:ignoredups:erasedups"
HISTFILESIZE=50000
HISTSIZE=10000
shopt -s histappend   # append to history file
shopt -s cmdhist      # allow multiline history cmds
shopt -s histreedit   # edit history if cmd failed
shopt -s histverify   # allow editing history command before executing
history_reload () {
    local TEMP=$(mktemp -t history.XXXXX)
    awk '! x[$0]++' $HISTFILE > $TEMP
    mv $TEMP $HISTFILE
    history -c
    history -r
}

# customize bash completion
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'
