#!/bin/zsh

cmd=$1 && shift

state=$(glazewm.exe query focused | jq -r '.data.focused.state.type')

toggle_fullscreen() {
  if [[ "${state}" == "fullscreen" ]]; then
    prevState=$(glazewm.exe query focused | jq -r '.data.focused.prevState.type')
    if [[ "${prevState}" == "floating" ]]; then
      glazewm.exe command set-floating
    else
      glazewm.exe command set-tiling
      sleep 0.02
      glazewm.exe command wm-redraw
    fi
  else
    glazewm.exe command set-fullscreen
  fi
}

case ${cmd} in
  toggle-fullscreen) toggle_fullscreen;;
  toggle-floating) 
    if [[ "${state}" == "tiling" ]]; then
      glazewm.exe command set-floating
    elif [[ "${state}" == "fullscreen" ]]; then
      toggle_fullscreen
    else
      glazewm.exe command set-tiling
    fi
  ;;
  move-workspace)
    read x y < <(glazewm.exe query monitors | jq -r '.data.monitors.[] | select(.hasFocus == true) | "\(.x) \(.y)"')
    read x_ y_ < <(glazewm.exe query monitors | jq -r '.data.monitors.[] | select(.hasFocus == false) | "\(.x) \(.y)"')
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
    glazewm.exe command move-workspace --direction $direction
  ;;
esac
