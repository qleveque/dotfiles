#zsh
bindkey -v
autoload -U select-bracketed select-quoted surround edit-command-line
vm() { bindkey -Mvisual $1 $2 }
im() { bindkey -Mviins $1 $2 }
nm() { bindkey -Mvicmd $1 $2 }
om() { bindkey -Mviopp $1 $2 }
map() {for m in vm im nm om; do $m $1 $2; done}

# Functions
vi-cut(){zle .vi-delete; printf '%s' "${CUTBUFFER}"|cb copy}
vi-yank(){zle .vi-yank;zle set-mark-command -n -1;printf '%s' "${CUTBUFFER}"|cb copy}
vi-put(){CUTBUFFER="$(cb paste 2>/dev/null||echo ${CUTBUFFER})";zle .${1:-$WIDGET}}
vi-surround(){read -k1 k;case $k in s)zle surround;;*)zle -U $k&&zle .vi-${WIDGET%-surround};;esac}
vi-visual-put(){zle .vi-delete; vi-put vi-put-before}
vi-visual-swap(){zle .vi-delete;local b="${CUTBUFFER}";vi-put vi-put-before;printf '%s' "${b}"|cb copy}
vi-backward-delete-char(){zle .backward-delete-char}
open-fm(){cd "$(vifm -c :only --choose-dir - . . < /dev/tty)";zle reset-prompt; zle zle-line-init}
open-git-wrap(){local k; read -k1 k; git-wrap $k -f"${PWD}" < /dev/tty; zle reset-prompt; zle zle-line-init}
open-copy-mode(){zle autosuggest-clear; zj-wrap copy}
insert-space() { LBUFFER+=" " }
quit(){exit}
set-cursor(){local c=2;[[ ${KEYMAP} == main ]]&&c=6;printf $'\e[%d q' $c}

# Widgets instantiation
my_widgets=(
  vi-cut vi-yank vi-put-before:vi-put vi-put-after:vi-put vi-visual-put
  vi-visual-swap vi-backward-delete-char change-surround:vi-surround
  delete-surround:vi-surround add-surround:surround surround select-bracketed
  select-quoted open-fm open-git-wrap open-copy-mode quit insert-space
  edit-command-line zle-keymap-select:set-cursor zle-line-init:set-cursor
  zle-line-finish:set-cursor
)
for widget in "${my_widgets[@]}"; do zle -N ${=widget//:/ }; done
