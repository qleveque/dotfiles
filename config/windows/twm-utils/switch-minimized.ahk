current := A_Args[1]
next := A_Args[2]
count := A_Args[3]
if (count = 0) {
  WinActivate, ahk_id %current%
} else if (count = 1) {
  WinMinimize, ahk_id %current%
  WinActivate, ahk_id %next%
} else {
  RunWait, glazewm.exe command wm-toggle-pause,, Hide
  WinMinimize, ahk_id %current%
  WinActivate, ahk_id %next%
  RunWait, glazewm.exe command wm-toggle-pause,, Hide
}
