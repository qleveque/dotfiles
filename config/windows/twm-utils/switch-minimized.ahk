current := A_Args[1]
next := A_Args[2]
RunWait, glazewm.exe command wm-toggle-pause,, Hide
WinGetPos, X, Y, Width, Height, ahk_id %current%
WinRestore, ahk_id %next%
WinMinimize, ahk_id %current%
RunWait, glazewm.exe command wm-toggle-pause,, Hide
WinActivate, ahk_id %next%
WinGetPos, X, Y, NWidth, NHeight, ahk_id %next%
DWidth := Width - NWidth
DHeight := Height - NHeight
Run, glazewm.exe command resize --width %DWidth% --height %DHeight%,, Hide
