#!/bin/zsh

cmd=$1 && shift

other_monitor_direction() {
    monitors=$(glazewm.exe query monitors | jq -r '.data.monitors.[]')
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
  glazewm.exe query workspaces | jq -r ' .data.workspaces[] | select(.hasFocus) | .. | objects | select(.type == "window") | {id: .id, state: .state.type, hasFocus: .hasFocus}'
}

case ${cmd} in
  move-workspace)
    glazewm.exe command move-workspace --direction $(other_monitor_direction)
  ;;
  switch-minimized)
    windows=$(workspace_windows)
    minimized=$(echo $windows | jq -r 'select(.state == "minimized") | .id')
    current=$(echo $windows | jq -r 'select(.hasFocus) | .id')
    sorted=$(echo $current# $minimized | tr ' ' '\n' | sort | tr '\n' ' ')
    next=$(echo $sorted | rg -o -m 1 -P '([\w-]+)(?= [\w-]+#)|[\w-]+(?=\W*$)' | head -1)
    count=$(echo $windows | jq -r 'select(.state == "tiling")' | jq -s length)
    if [[ $count == 0 ]]; then
      exit 0
    fi
    glazewm.exe command --id $current toggle-minimized
    glazewm.exe command --id $next toggle-minimized
    glazewm.exe command --id $next focus
  ;;
  unminimize)
    minimized=$(workspace_windows | jq -r 'select(.state == "minimized") | .id')
    first_minimized=$(printf "%s" "$minimized" | grep -m1 -o '^[^[:space:]]\+')
    glazewm.exe command --id $first_minimized toggle-minimized
  ;;
  toggle-float)
    state=$(glazewm.exe query focused | jq -r '.data.focused.state.type')
    [[ $state = 'floating' ]] && f='set-tiling' || f='set-floating'
    glazewm.exe command $f
  ;;
esac
