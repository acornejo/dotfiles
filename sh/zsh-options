# term title
if [ -z "${TERM##*xterm*}" ] || [ -z "${TERM##*screen*}" ]; then
    precmd() { print -Pn "\e]0;$(shortpwd)$(__git_prompt)\a" }
fi

# set history options
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt inc_append_history
setopt histnofunctions

history_reload() {
    fc -RI
}

# set general options
unsetopt flowcontrol     # turn off ^S and ^Q tty suspend/resume commands
unsetopt hashcmds        # prevent unecessary directory listings
unsetopt menu_complete   # do not autoselect the first completion entry
setopt ksh_arrays        # use 0 based arrays like bash
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word  # complete in the middle of the word
setopt always_to_end     # go to end of word after completion
setopt null_glob         # don't complain about empty globs (be bash/sh compat)
setopt prompt_subst      # use functions inside prompt
setopt sh_word_split     # for compatibility with sh/bash loops
setopt glob_subst        # for compatibility with sh/bash var expansion

# choose emacs-like bindings
bindkey -e
# shift-tab to complete backwards
bindkey '^[[Z' reverse-menu-complete

# customize fzf keys
fcd-widget() {
    fcd
    zle reset-prompt
}
zle     -N   fcd-widget
bindkey '^G' fcd-widget

# make alt-backspace useful (i.e. different from ctrl-w)
x-bash-backward-kill-word() {
    WORDCHARS='' zle backward-kill-word
}
zle     -N     x-bash-backward-kill-word
bindkey '\e^?' x-bash-backward-kill-word

# make C-u behave like in bash
bindkey '^U' backward-kill-line

# Make C-x C-e behave like in bash
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# zsh completion
autoload -Uz compinit && compinit
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
