weztermID := false
FileCreateDir, %USERPROFILE%/.scratchpad
DetectHiddenWindows, On

ToggleScratchPad() {
    global weztermID
    if (weztermID) {
        if WinExist("ahk_id " . weztermID) {
            if WinActive("ahk_id " . weztermID) {
                RunWait, glazewm.exe command ignore,,Hide
                WinMinimize, ahk_id %weztermID%
                WinHide, ahk_id %weztermID%
            } else {
                WinSetTitle, ahk_id %weztermID%, ,SCRATCHPAD
                WinRestore, ahk_id %weztermID%
                WinActivate, ahk_id %weztermID%
                WinSet, AlwaysOnTop, On, ahk_id %weztermID%
            }
            return
        }
    }
    Run, wezterm-gui.exe start --cwd %USERPROFILE%/.scratchpad nvim index,,, weztermPID
    WinWaitActive, ahk_pid %weztermPID%
    WinGet, weztermID, ID, ahk_pid %weztermPID%
    RunWait, glazewm.exe command set-floating,,Hide
}

CleanupScratchpad(ExitReason, ExitCode) {
    global weztermID
    WinGet, weztermPID, PID, ahk_id %weztermID%
    Process, Close, %weztermPID%
}
OnExit("CleanupScratchpad")
