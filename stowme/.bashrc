#!/bin/bash
cd "${HOME}"
source ~/.colors.bash
([[ -z "${TMUX}" ]] && { tmux attach || exec tmux new-session;}) || :
