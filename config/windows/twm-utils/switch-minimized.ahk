count := A_Args.MaxIndex()

current := A_Args[1]
if (count == 1) {
  WinActivate, ahk_id %current%
  ExitApp
}

next := A_Args[2]
if (count == 2) {
  WinMinimize, ahk_id %current%
  WinActivate, ahk_id %next%
  ExitApp
}

X := A_Args[3]
Y := A_Args[4]
Width := A_Args[5]
Height := A_Args[6]
RunWait, glazewm.exe command wm-toggle-pause,, Hide
WinActivate, ahk_id %next%
WinMinimize, ahk_id %current%
RunWait, glazewm.exe command wm-toggle-pause,, Hide
RunWait, glazewm.exe command position --x-pos %X% --y-pos %Y%,, Hide
RunWait, glazewm.exe command size --width %Width% --height %Height%,, Hide
