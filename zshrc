# environment variables
[ -f ~/.sh.env ] && source ~/.sh.env

# skip rest if non-interactive
[ -n "${-##*i*}" ] && return

# zsh options
[ -f ~/.sh.zsh ] && source ~/.sh.zsh

# aliases
[ -f ~/.sh.alias ] && source ~/.sh.alias

# git prompt function
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh

# autojump
[ -f /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh
[ -f /usr/local/share/autojump/autojump.zsh ] && source /usr/local/share/autojump/autojump.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pretty prompt
[ -f ~/.sh.prompt ] && source ~/.sh.prompt
PROMPT="$(sh_prompt)"

# local settings
for rc in ~/.sh.local.*; do
    [ -f "$rc" ] && source "$rc"
done
