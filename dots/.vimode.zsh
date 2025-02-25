#!/bin/zsh
bindkey -v
autoload -U select-bracketed select-quoted surround
typeset -A vimodes=( [vm]='visual' [im]='viins' [nm]='vicmd' [om]='viopp' )
for map in ${(k)vimodes}; do eval ${map}'(){bindkey -M'${vimodes[${map}]}' $*;}';done

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
im '^[[27;2;32~' insert-space
im '^V' vi-put-before
im '^I' fzf_completion
im '^?' backward-delete-char
im '^N' fzf-cd-widget
im '^R' fzf-history-widget
im '^P' goto-recent
im '^F' open-fm
im '^G' open-gitw
im '^Q' quit
im '^A' copy-mode
for c in {v,o}m\ {a,i}${(s..)^:-'()[]{}<>'};do ${=c} select-bracketed;done
for c in {v,o}m\ {a,i}${(s..)^:-\''"`_-\/,.;:|&'};do ${=c} select-quoted;done

# Functions and widgets instantiation
set-cursor(){zvs-zle-keymap-select;local c=2;[[ ${KEYMAP} == main ]]&&c=6;printf $'\e[%d q' $c}
goto-recent(){cd "$(eval ${FZF_CTRL_P_COMMAND}|fzf ${=FZF_CTRL_P_OPTS})";zle reset-prompt;zle zle-line-init}
open-fm(){cd "$(vifm -c :only --choose-dir - . < /dev/tty)";zle reset-prompt; zle zle-line-init}
open-gitw(){local k; read -k1 k; gitw $k -n -f"${PWD}" < /dev/tty; zle reset-prompt; zle zle-line-init}
insert-space() { LBUFFER+=" " }
quit(){exit}
vi-cut(){zle .vi-delete; printf '%s' "${CUTBUFFER}"|cb copy}
vi-yank(){zle .vi-yank;zle set-mark-command -n -1;printf '%s' "${CUTBUFFER}"|cb copy}
vi-put-before(){CUTBUFFER="$(cb paste 2>/dev/null||echo ${CUTBUFFER})";zle .vi-put-before}
vi-put-after(){CUTBUFFER="$(cb paste 2>/dev/null||echo ${CUTBUFFER})";zle .vi-put-after}
opp-wrap(){read -k1 k;case $k in s)zle add-surround;;*)zle -U $k&&zle .vi-${WIDGET%-wrap};;esac}
visual-swap(){zle vi-delete;local b="${CUTBUFFER}";zle vi-put-before;printf '%s' "${b}"|cb copy}
visual-put(){zle vi-delete; zle vi-put-before}
copy-mode(){wez copy}
wids=(goto-recent open-{fm,gitw} quit select-{bracketed,quoted} visual-{put,swap}
      vi-{cut,yank,put-{before,after}} copy-mode insert-space add-surround:surround
      {change,delete}-wrap:opp-wrap zle-{keymap-select,line-{init,finish}}:set-cursor)
for wid in "${wids[@]}"; do zle -N ${=wid//:/ }; done
