#!/bin/bash
cd "${HOME}"
source .theme.bash
([[ -z "${TMUX}" ]] && { tmux attach || exec tmux new-session;}) || :
