#!/bin/zsh
export FZF_ALT_C_COMMAND='fdfind --type d'
export FZF_CTRL_P_COMMAND='eval "tac ~/.dirhist | grep -v \"^${PWD}\$\""'
export FZF_CTRL_P_OPTS='--no-sort'
export FZF_CTRL_R_OPTS='--no-sort'
export FZF_CTRL_T_COMMAND='fdfind'
export FZF_DEFAULT_OPTS='--ansi --border --bind=tab:down,shift-tab:up --reverse --exact'
export PATH="${HOME}/dotfiles/bin:${HOME}/bin:${HOME}/.local/bin:${PATH}"
export STARSHIP_LOG='error'
KEYTIMEOUT=1
HISTFILE=~/.zsh_history HISTSIZE=1000 SAVEHIST=1000
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(vi-cmd-mode accept-line push-line-or-edit recursive-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c80,)|*
*"
