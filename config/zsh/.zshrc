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

# Vim corrections
vm c vi-change
vm d vi-delete
nm x vi-cut
vm x vi-cut
nm U redo
vm v visual-line-mode
vm P vi-visual-swap
vm p vi-visual-put
im ^V vi-put-before
im '\e[20~' forward-word # Ctrl + Enter
map ^O dirhistory_zle_dirhistory_back
map '\e[23~' dirhistory_zle_dirhistory_future # Ctrl + I

# Surround
nm s add-surround
vm s add-surround
nm c change-surround
nm d delete-surround
for c in {vm,om}\ {a,i}${(s..)^:-'()[]{}<>'};do ${=c} select-bracketed;done
for c in {vm,om}\ {a,i}${(s..)^:-\''"`_-\/,.;:|&'};do ${=c} select-quoted;done

# Tools
map ^E edit-command-line
map ^N fzf-cd-widget
map ^F open-fm
map ^G open-git-wrap
map ^A open-copy-mode
map ^Q quit
