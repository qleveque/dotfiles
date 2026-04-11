#!zsh
stty -ixon
setopt histignorealldups sharehistory nonomatch promptsubst chase_links physical
zstyle ':completion:*' fzf-search-display true
eval "$(fzf --zsh)"
cf() { cd "$(dirname $1)" }
h() { "$@" --help | bat -l help --paging=always --style=plain }
man() { /usr/bin/env man "$@" | bat -l man --paging=always --style=plain }
[[ -f "${HOME}/.init.zsh" ]] && source "${HOME}/.init.zsh"
export g="${MARKPATH}"

# Prompt
export PROMPT="
%F{blue}%~%f
❯ "
