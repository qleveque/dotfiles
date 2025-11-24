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

case ${cmd} in
  move-workspace)
    $G command move-workspace --direction $(other_monitor_direction)
  ;;
  switch-workspaces)
    current=$($G query monitors | jq -r '.data.monitors.[] | select(.hasFocus == true) | .children.[] | select(.isDisplayed == true) | .name')
    other=$($G query monitors | jq -r '.data.monitors.[] | select(.hasFocus == false) | .children.[] | select(.isDisplayed == true) | .name')
    $G command move-workspace --direction $(other_monitor_direction)
    $G command focus --workspace ${other}
    $G command move-workspace --direction $(other_monitor_direction)
    $G command focus --workspace ${current}
  ;;
  switch-minimized)
    current=$("$G" query focused | jq -r '.data.focused.id')
    minimized=$("$G" query workspaces | jq -r '
      .data.workspaces[]
      | select(.hasFocus == true)
      | .children[]
      | select(.type == "window")
      | select(.state.type == "minimized")
      | .id
      ')
    sorted=$(echo $current# $minimized | tr ' ' '\n' | sort | tr '\n' ' ')
    next=$(echo $sorted | rg -oP '# ([a-z0-9-]*)' --replace '$1')
    [[ -z $next ]] && next=$(echo $sorted | rg -oP '^[a-z0-9-]*')
    "$G" command set-minimized
    "$G" command focus --container-id $next
    "$G" command toggle-minimized
  ;;
  unminimize)
    first_minimized=$("$G" query workspaces | jq -r '
      [.data.workspaces[]
      | select(.hasFocus == true)
      | .children[]
      | select(.type == "window")
      | select(.state.type == "minimized")
      | .id][0]')
    [[ $first_minimized == null ]] && exit 0
    "$G" command focus --container-id $first_minimized
    "$G" command toggle-minimized
    echo $minimized
  ;;
esac
