#!/bin/zsh

cmd=$1 && shift

G='/mnt/c/Program Files/glzr.io/GlazeWM/cli/glazewm.exe'

other_monitor_direction() {
    monitors=$($G query monitors | jq -r '.data.monitors.[]')
    read x y < <(printf '%s\n' "$monitors" | jq -r 'select(.hasFocus == true) | "\(.x) \(.y)"')
    read x_ y_ < <(printf '%s\n' "$monitors" | jq -r 'select(.hasFocus == false) | "\(.x) \(.y)"')
    dx=$(( x - x_ )) dy=$(( y - y_ ))
    if (( ${dx#-} > ${dy#-} )); then
      (( x < x_ )) && echo right || echo left
    else
      (( y < y_ )) && echo down || echo up
    fi
}

workspace_windows() {
  "$G" query workspaces | jq -r ' .data.workspaces[] | select(.hasFocus) | .children[] | select(.type == "window") | {handle: .handle, state: .state.type, hasFocus: .hasFocus}'
}

case ${cmd} in
  move-workspace)
    $G command move-workspace --direction $(other_monitor_direction)
  ;;
  switch-minimized)
    windows=$(workspace_windows)
    minimized=$(echo $windows | jq -r 'select(.state == "minimized") | .handle')
    current=$(echo $windows | jq -r 'select(.hasFocus) | .handle')
    sorted=$(echo $current# $minimized | tr ' ' '\n' | sort | tr '\n' ' ')
    next=$(echo $sorted | rg -oP '# ([0-9]*)' --replace '$1')
    [[ -z $next ]] && next=$(echo $sorted | rg -oP '^[0-9]*')
    count=$(echo $windows | jq -r 'select(.state == "tiling")' | jq -s length)
    autohotkey.exe switch-minimized.ahk $current $next $count
  ;;
  unminimize)
    minimized=$(workspace_windows | jq -r 'select(.state == "minimized") | .handle')
    first_minimized=$(printf "%s" "$minimized" | grep -m1 -o '^[^[:space:]]\+')
    autohotkey.exe switch-minimized.ahk $first_minimized 0 0
  ;;
  toggle-float)
    state=$("$G" query focused | jq -r '.data.focused.state.type')
    [[ $state = 'floating' ]] && f='set-tiling' || f='set-floating'
    "$G" command $f
  ;;
esac
