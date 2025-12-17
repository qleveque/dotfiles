taskbarHidden := true

ToggleTaskbar() {
    global taskbarHidden
    if (!taskbarHidden) {
        SetTimer, EnforceHideTaskbar, 1000
        EnforceHideTaskbar()
    } else {
        SetTimer, EnforceHideTaskbar, Off
        WinShow, ahk_class Shell_TrayWnd
        WinShow, ahk_class Shell_SecondaryTrayWnd
    }
    taskbarHidden := !taskbarHidden
}

EnforceHideTaskbar() {
    WinHide, ahk_class Shell_TrayWnd
    WinHide, ahk_class Shell_SecondaryTrayWnd
}
