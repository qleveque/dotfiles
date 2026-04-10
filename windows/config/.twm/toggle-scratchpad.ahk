termID := false
FileCreateDir, %USERPROFILE%/.scratchpad
DetectHiddenWindows, On

ToggleScratchPad() {
    global termID
    if (termID) {
        if WinExist("ahk_id " . termID) {
            if WinActive("ahk_id " . termID) {
                RunWait, glazewm.exe command ignore,,Hide
                WinMinimize, ahk_id %termID%
                WinHide, ahk_id %termID%
            } else {
                WinSetTitle, ahk_id %termID%, ,SCRATCHPAD
                WinRestore, ahk_id %termID%
                WinActivate, ahk_id %termID%
                WinSet, AlwaysOnTop, On, ahk_id %termID%
            }
            return
        }
    }

    Run, "C:\Program Files\Alacritty\alacritty.exe" -e wsl.exe --cd "~/.scratchpad" zsh -c 'nvim index',,, termPID
    WinWaitActive, ahk_pid %termPID%
    WinGet, termID, ID, ahk_pid %termPID%
    RunWait, glazewm.exe command set-floating,,Hide
}

CleanupScratchpad(ExitReason, ExitCode) {
    global termID
    WinGet, termPID, PID, ahk_id %termID%
    Process, Close, %termPID%
}
OnExit("CleanupScratchpad")
