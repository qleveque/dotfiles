taskbarHidden := true

ToggleTaskbar() {
    global taskbarHidden
    if (!taskbarHidden) {
        SetTimer, EnforceHideTaskbar, 200
        EnforceHideTaskbar()
    } else {
        SetTimer, EnforceHideTaskbar, Off
        WinShow, ahk_class Shell_TrayWnd
    }
    taskbarHidden := !taskbarHidden
}

EnforceHideTaskbar() {
    WinHide, ahk_class Shell_TrayWnd
}
