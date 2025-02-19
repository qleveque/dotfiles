#!/bin/zsh
stty -ixon
setopt histignorealldups sharehistory nonomatch promptsubst
zstyle ':completion:*' fzf-search-display true
eval "$(starship init zsh)"
cf() { cd "$(dirname $1)" }
h() { eval "$@ --help" | batcat -l help -p }
man() { eval "/usr/bin/man $@" | batcat -l man -p }

# Sources
source /usr/share/doc/fzf/examples/key-bindings.zsh
source ~/.zim/init.zsh
source ~/.vimode.zsh
source ~/.aliases
[[ -f ~/.init.zsh ]] && source ~/.init.zsh

# On directory changed
_on_dir_changed() { oncd }
autoload -U add-zsh-hook
add-zsh-hook chpwd _on_dir_changed
