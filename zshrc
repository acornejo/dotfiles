# environment variables
[ -f ~/.sh/environ ] && source ~/.sh/environ

# skip rest if non-interactive
[ -n "${-##*i*}" ] && return

# zsh options
[ -f ~/.sh/zsh-options ] && source ~/.sh/zsh-options

# aliases
[ -f ~/.sh/aliases ] && source ~/.sh/aliases

# git prompt function
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh

# z
[ -f ~/.bin/z.sh ] && source ~/.bin/z.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pretty prompt
[ -f ~/.sh/prompt ] && source ~/.sh/prompt
PROMPT="$(sh_prompt)"

# local settings
for rc in ~/.sh.local.*; do
    [ -f "$rc" ] && source "$rc"
done
