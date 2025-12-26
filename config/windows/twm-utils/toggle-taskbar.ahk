ToggleTaskbar() {
    global taskbarHidden
    if (!taskbarHidden) {
        SetTimer, EnforceHideTaskbar, 200
        EnforceHideTaskbar()
    } else {
        SetTimer, EnforceHideTaskbar, Off
        RunWait, taskkill /f /im explorer.exe,, Hide
        Run, explorer.exe
    }
    taskbarHidden := !taskbarHidden
}

EnforceHideTaskbar() {
    DetectHiddenWindows, Off
    WinHide, ahk_class Shell_TrayWnd
}

taskbarHidden := false
ToggleTaskbar()
