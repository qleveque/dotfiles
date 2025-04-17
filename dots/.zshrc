#!/bin/zsh
stty -ixon
setopt histignorealldups sharehistory nonomatch promptsubst
zstyle ':completion:*' fzf-search-display true
eval "$(starship init zsh)"
cf() { cd "$(dirname $1)" }
h() { "$@" --help | batcat -l help --paging=always --style=plain }
man() { /usr/bin/man "$@" | batcat -l man --paging=always --style=plain }

# Sources
source ${ZIM_HOME}/init.zsh
source ~/.vim.zsh
source ~/.aliases
source ~/.init.zsh || :

# On directory changed
_on_dir_changed() { oncd }
autoload -U add-zsh-hook
add-zsh-hook chpwd _on_dir_changed
