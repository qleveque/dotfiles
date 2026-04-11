#zsh
bindkey -v
autoload -U select-bracketed select-quoted surround
typeset -A vimodes=( [vm]='visual' [im]='viins' [nm]='vicmd' [om]='viopp' )
for map in ${(k)vimodes}; do eval ${map}'(){bindkey -M'${vimodes[${map}]}' $*;}';done

# Remapping
nm c change-wrap
nm d delete-wrap
nm x vi-cut
vm c vi-change
vm d vi-delete
vm x vi-cut
nm s add-surround
vm s add-surround
nm U redo
vm v visual-line-mode
vm P vi-visual-swap
vm p vi-visual-put
im '\e[20~' forward-word # Ctrl + Enter
im ^V vi-put-before

im ^N fzf-cd-widget
im ^F open-fm
im ^G open-git-wrap
im ^A open-copy-mode
im ^Q quit
im '^[[27;2;32~' insert-space # Shift + Space
im ^? backward-delete-char # Backspace

for c in {v,o}m\ {a,i}${(s..)^:-'()[]{}<>'};do ${=c} select-bracketed;done
for c in {v,o}m\ {a,i}${(s..)^:-\''"`_-\/,.;:|&'};do ${=c} select-quoted;done

# Functions
vi-cut(){zle .vi-delete; printf '%s' "${CUTBUFFER}"|cb copy}
vi-yank(){zle .vi-yank;zle set-mark-command -n -1;printf '%s' "${CUTBUFFER}"|cb copy}
vi-put(){CUTBUFFER="$(cb paste 2>/dev/null||echo ${CUTBUFFER})";zle .${1:-$WIDGET}}
vi-surround-wrapper(){read -k1 k;case $k in s)zle surround;;*)zle -U $k&&zle .vi-${WIDGET%-wrap};;esac}
vi-visual-put(){zle .vi-delete; vi-put vi-put-before}
vi-visual-swap(){zle .vi-delete;local b="${CUTBUFFER}";vi-put vi-put-before;printf '%s' "${b}"|cb copy}
open-fm(){cd "$(vifm -c :only --choose-dir - . . < /dev/tty)";zle reset-prompt; zle zle-line-init}
open-git-wrap(){local k; read -k1 k; git-wrap $k -f"${PWD}" < /dev/tty; zle reset-prompt; zle zle-line-init}
open-copy-mode(){zle autosuggest-clear; zj-wrap copy}
insert-space() { LBUFFER+=" " }
quit(){exit}
set-cursor(){local c=2;[[ ${KEYMAP} == main ]]&&c=6;printf $'\e[%d q' $c}

# Widgets instantiation
my_widgets=(
  vi-{cut,yank}
  vi-put-{before,after}:vi-put
  vi-visual-{put,swap}
  {change,delete}-wrap:vi-surround-wrapper
  {add-,}surround:surround
  select-{bracketed,quoted}
  open-{fm,git-wrap,copy-mode}
  quit
  insert-space
  zle-{keymap-select,line-{init,finish}}:set-cursor
)
for widget in "${my_widgets[@]}"; do zle -N ${=widget//:/ }; done
