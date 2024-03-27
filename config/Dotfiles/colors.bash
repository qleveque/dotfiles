#!/bin/bash
IFS='-' read -r -a COLORS <<< "171127-231b37-2d3457-444e88"
> ~/.colors.bash > ~/.colors.vim
for (( i=0; i<${#COLORS[@]}; i++ )); do
    color=${COLORS[$i]} palette=PALETTE_$((i+1))
    echo "export ${palette}=#${color}" >> ~/.colors.bash
    echo "let ${palette}=\"#${color}\"" >> ~/.colors.vim
done
