DetectHiddenWindows, On

ToggleTaskbar() {
    global taskbarHidden
    if (!taskbarHidden) {
        SetTimer, HideTaskBar, 1000
        HideTaskBar()
    } else {
        SetTimer, HideTaskBar, Off
        ShowTaskBar()
    }
    taskbarHidden := !taskbarHidden
}

HideTaskBar() {
    WinGet, trayList, List, ahk_class Shell_TrayWnd
    Loop, %trayList% {
        hwnd := trayList%A_Index%
        WinHide, ahk_id %hwnd%
    }
}

ShowTaskBar() {
    WinGet, trayList, List, ahk_class Shell_TrayWnd
    Loop, %trayList% {
        hwnd := trayList%A_Index%
        WinShow, ahk_id %hwnd%
    }
}

taskbarHidden := false
ToggleTaskbar()
