#!/bin/bash
export FLAVOR='mocha'
([[ -z "${TMUX}" ]] && { tmux attach || exec tmux new-session;}) || :
