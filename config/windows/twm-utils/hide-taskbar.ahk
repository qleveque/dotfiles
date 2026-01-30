#Persistent
DetectHiddenWindows, On

HideTaskBar() {
    WinGet, trayList, List, ahk_class Shell_TrayWnd
    Loop, %trayList% {
        hwnd := trayList%A_Index%
        WinHide, ahk_id %hwnd%
    }
}

HideTaskBar()
SetTimer, HideTaskBar, 1000
