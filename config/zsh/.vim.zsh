#zsh
bindkey -v
autoload -U select-bracketed select-quoted surround
typeset -A vimodes=( [vm]='visual' [im]='viins' [nm]='vicmd' [om]='viopp' )
for map in ${(k)vimodes}; do eval ${map}'(){bindkey -M'${vimodes[${map}]}' $*;}';done

# Remapping
nm s vi-surround
nm c vi-change-wrap
nm d vi-delete-wrap
nm x vi-cut
vm s vi-surround
vm c vi-change
vm d vi-delete
vm x vi-cut
nm U redo
vm v visual-line-mode
vm P vi-visual-swap
vm p vi-visual-put
im '^[[13;5u' forward-word # Alt + Enter
im ^V vi-put-before

im ^N fzf-cd-widget
im ^R fzf-history-widget
im ^P fzf-recent-widget
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
vi-put-before(){CUTBUFFER="$(cb paste 2>/dev/null||echo ${CUTBUFFER})";zle .vi-put-before}
vi-put-after(){CUTBUFFER="$(cb paste 2>/dev/null||echo ${CUTBUFFER})";zle .vi-put-after}
vi-wrapper(){read -k1 k;case $k in s)zle vi-surround;;*)zle -U $k&&zle .${WIDGET%-wrap};;esac}
vi-visual-swap(){zle vi-delete;local b="${CUTBUFFER}";zle vi-put-before;printf '%s' "${b}"|cb copy}
vi-visual-put(){zle vi-delete; zle vi-put-before}
set-cursor(){local c=2;[[ ${KEYMAP} == main ]]&&c=6;printf $'\e[%d q' $c}
open-fm(){cd "$(vifm -c :only --choose-dir - . < /dev/tty)";zle reset-prompt; zle zle-line-init}
open-git-wrap(){local k; read -k1 k; git-wrap $k -f"${PWD}" < /dev/tty; zle reset-prompt; zle zle-line-init}
open-copy-mode(){zle autosuggest-clear; wez-wrap copy}
fzf-recent-widget(){cd "$(eval ${FZF_CTRL_P_COMMAND}|fzf ${=FZF_CTRL_P_OPTS})";zle reset-prompt;zle zle-line-init}
insert-space() { LBUFFER+=" " }
quit(){exit}

# Widgets instantiation
wids=(
  vi-{cut,yank}
  vi-put-{before,after}
  vi-surround:surround
  vi-visual-{put,swap}
  vi-{change,delete}-wrap:vi-wrapper
  open-{fm,git-wrap,copy-mode}
  fzf-recent-widget
  select-{bracketed,quoted}
  quit
  insert-space
  zle-{keymap-select,line-{init,finish}}:set-cursor
)
for wid in "${wids[@]}"; do zle -N ${=wid//:/ }; done
