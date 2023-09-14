#!/bin/bash
PALETTE=171127-231b37-2d3457-444e88
IFS='-' read -r -a COLORS <<< "$PALETTE"
for i in {1..4}; do
    eval "export PALETTE_$i=#${COLORS[$i-1]}"
done

cd ~ && ([ -z "$TMUX" ] && { tmux attach || exec tmux new-session;}) || :
