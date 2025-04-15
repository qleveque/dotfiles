#!/bin/zsh
stty -ixon
setopt histignorealldups sharehistory nonomatch promptsubst
zstyle ':completion:*' fzf-search-display true
eval "$(starship init zsh)"
cf() { cd "$(dirname $1)" }
h() { eval "$@ --help" | batcat -l help -p }
man() { eval "/usr/bin/man $@" | batcat -l man -p }

# Sources
source ~/.zim/modules/zsh-defer/zsh-defer.plugin.zsh
source ~/.vimode.zsh
zsh-defer source /usr/share/doc/fzf/examples/key-bindings.zsh
zsh-defer source ~/.zim/init.zsh && zsh-defer bindkey '^G' open-git_wrap
zsh-defer source ~/.aliases
[[ -f ~/.init.zsh ]] && zsh-defer source ~/.init.zsh

# On directory changed
_on_dir_changed() { oncd }
autoload -U add-zsh-hook
add-zsh-hook chpwd _on_dir_changed
