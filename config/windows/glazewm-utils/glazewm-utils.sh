#!/bin/zsh

cmd=$1 && shift

G='/mnt/c/Program Files/glzr.io/GlazeWM/cli/glazewm.exe'

toggle_fullscreen() {
  if [[ "${state}" == "fullscreen" ]]; then
    prevState=$($G query focused | jq -r '.data.focused.prevState.type')
    if [[ "${prevState}" == "floating" ]]; then
      $G command set-floating
    else
      $G command set-tiling
      sleep 0.02
      $G command wm-redraw
    fi
  else
    $G command set-fullscreen
  fi
}

case ${cmd} in
  toggle-fullscreen)
    state=$($G query focused | jq -r '.data.focused.state.type')
    toggle_fullscreen
  ;;
  toggle-floating) 
    state=$($G query focused | jq -r '.data.focused.state.type')
    if [[ "${state}" == "tiling" ]]; then
      $G command set-floating
    elif [[ "${state}" == "fullscreen" ]]; then
      toggle_fullscreen
    else
      $G command set-tiling
    fi
  ;;
  move-workspace)
    monitors=$($G query monitors | jq -r '.data.monitors.[]')
    read x y < <(printf '%s\n' "$monitors" | jq -r 'select(.hasFocus == true) | "\(.x) \(.y)"')
    read x_ y_ < <(printf '%s\n' "$monitors" | jq -r 'select(.hasFocus == false) | "\(.x) \(.y)"')
    dx=$(( x - x_ )) dy=$(( y - y_ ))
    if (( ${dx#-} > ${dy#-} )); then
      (( x < x_ )) && direction=right || direction=left
    else
      (( y < y_ )) && direction=down || direction=up
    fi
    $G command move-workspace --direction $direction
  ;;
  switch-workspace)
    workspace=$($G query monitors | jq -r '.data.monitors.[] | select(.hasFocus == false) | .children.[] | select(.isDisplayed == true) | .name')
    $G command move --workspace ${workspace}
    $G command focus --workspace ${workspace}
  ;;
esac
