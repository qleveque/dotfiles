#!/bin/bash
cd "${HOME}"
source ~/.colors
([[ -z "${TMUX}" ]] && { tmux attach || exec tmux new-session;}) || :
