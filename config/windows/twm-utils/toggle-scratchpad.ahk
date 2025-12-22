weztermPID := false
FileCreateDir, %USERPROFILE%/.scratchpad
ToggleScratchPad() {
    global weztermPID
    if (weztermPID) {
        if WinExist("ahk_pid " . weztermPID) {
            if WinActive("ahk_pid " . weztermPID) {
                WinActivate, ahk_pid %weztermPID%
                WinMinimize, ahk_pid %weztermPID%
                WinMinimize, ahk_pid %weztermPID%
            } else {
                WinRestore, ahk_pid %weztermPID%
                WinActivate, ahk_pid %weztermPID%
            }
            return
        }
    }
    Run, wezterm-gui.exe start --cwd %USERPROFILE%/.scratchpad nvim index,,, weztermPID
    WinWait, ahk_pid %weztermPID%
    WinActivate, ahk_pid %weztermPID%
    RunWait, glazewm.exe command set-floating,,Hide
    RunWait, glazewm.exe command ignore,,Hide
    WinSet, AlwaysOnTop, On, ahk_pid %weztermPID%
}
