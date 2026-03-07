DetectHiddenWindows, On
WinGet, trayList, List, ahk_class Shell_TrayWnd
Loop, %trayList% {
    hwnd := trayList%A_Index%
    WinShow, ahk_id %hwnd%
}
