# common shell settings
[ -f ~/.sh.env ] && source ~/.sh.env

# skip rest if non-interactive
[ -n "${-##*i*}" ] && return

# bash options
[ -f ~/.sh.bash ] && source ~/.sh.bash

# aliases
[ -f ~/.sh.alias ] && source ~/.sh.alias

# git prompt function
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh

# autojump
[ -f /usr/share/autojump/autojump.bash ] && source /usr/share/autojump/autojump.bash
[ -f /usr/local/share/autojump/autojump.bash ] && source /usr/local/share/autojump/autojump.bash

# bash completion
[ -f ~/.bash_completion ] && source ~/.bash_completion

# git completion
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# pretty prompt
[ -f ~/.sh.prompt ] && source ~/.sh.prompt
PS1="$(sh_prompt)"

# local settings
for rc in ~/.sh.local.*; do
    [ -f "$rc" ] && source "$rc"
done
