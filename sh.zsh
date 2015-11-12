# term title
if [ -z "${TERM##*xterm*}" ]; then
    precmd() { print -Pn "\e]0;%n@%m: %~\a" }
fi

# set history options
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups

# set general options
unsetopt flowcontrol     # turn off ^S and ^Q tty suspend/resume commands
unsetopt hashcmds        # prevent unecessary directory listings
unsetopt menu_complete   # do not autoselect the first completion entry
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word  # complete in the middle of the word
setopt always_to_end     # go to end of word after completion
setopt null_glob         # don't complain about empty globs (be bash/sh compat)
setopt prompt_subst      # use functions inside prompt

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

# zsh completion
autoload -Uz compinit && compinit
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
