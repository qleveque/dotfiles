export DISPLAY=:0.0
cd ~
[ -z "$TMUX" ] && { tmux attach || exec tmux new-session;}
. "$HOME/.cargo/env"
