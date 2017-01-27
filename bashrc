# common shell settings
[ -f ~/.sh/environ ] && source ~/.sh/environ

# skip rest if non-interactive
[ -n "${-##*i*}" ] && return

# pretty prompt
[ -f ~/.sh/prompt ] && source ~/.sh/prompt
PS1="$(sh_prompt)"

# bash options
[ -f ~/.sh/bash-options ] && source ~/.sh/bash-options

# aliases
[ -f ~/.sh/aliases ] && source ~/.sh/aliases

# git prompt function
[ -f ~/.sh/git-prompt.sh ] && source ~/.sh/git-prompt.sh

# z
[ -f ~/.bin/z.sh ] && source ~/.bin/z.sh

# bash completion
[ -f ~/.bash_completion ] && source ~/.bash_completion

# git completion
[ -f ~/.sh/git-completion.bash ] && source ~/.sh/git-completion.bash

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# local settings
for rc in ~/.sh.local.*; do
    [ -f "$rc" ] && source "$rc"
done
