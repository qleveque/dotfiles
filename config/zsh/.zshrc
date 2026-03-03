#!zsh
stty -ixon
setopt histignorealldups sharehistory nonomatch promptsubst
zstyle ':completion:*' fzf-search-display true
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
cf() { cd "$(dirname $1)" }
h() { "$@" --help | bat -l help --paging=always --style=plain }
man() { /usr/bin/man "$@" | bat -l man --paging=always --style=plain }
[[ -f "${HOME}/.init.zsh" ]] && source "${HOME}/.init.zsh"

# On directory changed
_on_dir_changed() { oncd "$PWD" }
autoload -U add-zsh-hook
add-zsh-hook chpwd _on_dir_changed
