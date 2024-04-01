#!/bin/bash
cd "${HOME}"
([[ -z "${TMUX}" ]] && { tmux attach || exec tmux new-session;}) || :
