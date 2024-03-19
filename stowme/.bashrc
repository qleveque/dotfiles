#!/bin/bash
source ~/.colors

cd "${HOME}"
([[ -z "${TMUX}" ]] && { tmux attach || exec tmux new-session;}) || :
