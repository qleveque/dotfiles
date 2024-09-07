#!/bin/zsh
bindkey -v
autoload -U select-bracketed select-quoted surround
vm(){bindkey -Mvisual $*};im(){bindkey -Mviins $*};nm(){bindkey -Mvicmd $*};om(){bindkey -Mviopp $*}

# Remapping
nm s add-surround
nm c change-wrap
nm d delete-wrap
nm x vi-cut
nm U redo
vm s add-surround
vm c vi-change
vm d vi-delete
vm x vi-cut
vm v visual-line-mode
vm P visual-swap
vm p visual-put
im '^[[Z' forward-word
im '^V' vi-put-before
im '^I' fzf_completion
im '^?' backward-delete-char
im '^@' g-expansion
im '^N' fzf-cd-widget
im '^R' fzf-history-widget
im '^P' goto-recent
im '^F' open-fm
im '^G' open-giter
im '^Q' quit
im '^A' copy-mode
for m in vm om; do
  for c in {a,i}${(s..)^:-'()[]{}<>'}; do $m $c select-bracketed; done
  for c in {a,i}{\',\",\`,_,-,\\,/,\,,.,\;,:,\|,\&}; do $m $c select-quoted; done
done

# Functions and widgets instantiation
set-cursor(){zvs-zle-keymap-select;local c=2;[[ ${KEYMAP} == main ]]&&c=6;printf $'\e[%d q' $c}
goto-recent(){cd "$(eval ${FZF_P_COMMAND}|fzf --exact)";zle reset-prompt;zle zle-line-init}
open-fm(){cd "$(vifm -c :only --choose-dir - . < /dev/tty)";zle reset-prompt}
open-giter(){local k; read -k1 k; giter $k < /dev/tty; zle reset-prompt}
quit(){exit}
vi-cut(){zle .vi-delete; printf '%s' "${CUTBUFFER}"|c}
vi-yank(){zle .vi-yank;zle set-mark-command -n -1;printf '%s' "${CUTBUFFER}"|c}
vi-put-before(){CUTBUFFER="$(p 2>/dev/null||echo ${CUTBUFFER})";zle .vi-put-before}
vi-put-after(){CUTBUFFER="$(p 2>/dev/null||echo ${CUTBUFFER})";zle .vi-put-after}
opp-wrap(){read -k1 k;case $k in s)zle add-surround;;*)zle -U $k&&zle .vi-${WIDGET%-wrap};;esac}
visual-swap(){zle vi-delete;local b="${CUTBUFFER}";zle vi-put-before;printf '%s' "${b}"|c}
visual-put(){zle vi-delete; zle vi-put-before}
copy-mode(){wez copy}
g-expansion(){zle _mark_expansion && zle autosuggest-clear}
wids=(goto-recent open-{fm,giter} quit select-{bracketed,quoted} visual-{put,swap}
      vi-{cut,yank,put-{before,after}} copy-mode g-expansion add-surround:surround
      {change,delete}-wrap:opp-wrap zle-{keymap-select,line-{init,finish}}:set-cursor)
for wid in "${wids[@]}"; do zle -N ${=wid//:/ }; done
