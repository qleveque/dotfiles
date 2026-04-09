#NoTrayIcon
#SingleInstance Off
DetectHiddenWindows, On

from := A_Args[1]
to := A_Args[2]

RunWait, glazewm.exe command wm-toggle-pause,, Hide
WinMinimize, ahk_id %from%
WinRestore, ahk_id %to%
WinActivate, ahk_id %to%
RunWait, glazewm.exe command wm-toggle-pause,, Hide
ExitApp
