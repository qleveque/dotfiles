if grep -q Microsoft /proc/version; then
    export DISPLAY=:0.0
fi
source ~/.colors

cd ~
([ -z "$TMUX" ] && { tmux attach || exec tmux new-session;}) || :
