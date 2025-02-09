#!/bin/zsh

cmd=$1 && shift


G='/mnt/c/Program Files/glzr.io/GlazeWM/cli/glazewm.exe'

state=$($G query focused | jq -r '.data.focused.state.type')

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
  toggle-fullscreen) toggle_fullscreen;;
  toggle-floating) 
    if [[ "${state}" == "tiling" ]]; then
      $G command set-floating
    elif [[ "${state}" == "fullscreen" ]]; then
      toggle_fullscreen
    else
      $G command set-tiling
    fi
  ;;
  move-workspace)
    read x y < <($G query monitors | jq -r '.data.monitors.[] | select(.hasFocus == true) | "\(.x) \(.y)"')
    read x_ y_ < <($G query monitors | jq -r '.data.monitors.[] | select(.hasFocus == false) | "\(.x) \(.y)"')
    dx=$(( x - x_ ))
    dy=$(( y - y_ ))
    if (( ${dx#-} > ${dy#-} )); then
      if (( x < x_ )); then
        direction=right
      else
        direction=left
      fi
    else
      if (( y < y_ )); then
        direction=up
      else
        direction=down
      fi
    fi
    $G command move-workspace --direction $direction
  ;;
esac
