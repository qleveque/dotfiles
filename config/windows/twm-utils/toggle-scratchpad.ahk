DetectHiddenWindows, On

weztermPID := false
FileCreateDir, %USERPROFILE%/.scratchpad

ToggleScratchPad() {
    global weztermPID
    if (weztermPID) {
        if WinExist("ahk_pid " . weztermPID) {
            if WinActive("ahk_pid " . weztermPID) {
                WinSet, Transparent, 0, ahk_pid %weztermPID%
                WinActivate, ahk_pid %weztermPID%
                RunWait, glazewm.exe command ignore,,Hide
                While WinActive("ahk_pid " . weztermPID) {
                    WinMinimize, ahk_pid %weztermPID%
                }
                WinHide, ahk_pid %weztermPID%
            } else {
                WinSetTitle, ahk_pid %weztermPID%, ,SCRATCHPAD
                WinRestore, ahk_pid %weztermPID%
                WinSet, Transparent, 255, ahk_pid %weztermPID%
                WinActivate, ahk_pid %weztermPID%
            }
            return
        }
    }
    Run, wezterm-gui.exe start --cwd %USERPROFILE%/.scratchpad nvim index,,, weztermPID
    WinWaitActive, ahk_pid %weztermPID%
    RunWait, glazewm.exe command set-floating,,Hide
}

Cleanup(ExitReason, ExitCode) {
    global weztermPID
    Process, Close, %weztermPID%
}
OnExit("Cleanup")
