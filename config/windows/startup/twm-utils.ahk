#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1

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
taskbarHidden := false
ToggleTaskbar()

weztermPID := false
ToggleScratchPad() {
    global weztermPID
    if (weztermPID) {
        if WinExist("ahk_pid " . weztermPID) {
            if WinActive("ahk_pid " . weztermPID) {
                WinMinimize, ahk_pid %weztermPID%
            } else {
                WinRestore, ahk_pid %weztermPID%
                WinActivate, ahk_pid %weztermPID%
            }
            return
        }
    }
    EnvGet, UserProfile, USERPROFILE
    Run, wezterm-gui.exe start --cwd %USERPROFILE%/.scratchpad nvim index,,, weztermPID
    WinWait, ahk_pid %weztermPID%
    WinActivate, ahk_pid %weztermPID%
    RunWait, glazewm.exe command set-floating,,Hide
    RunWait, glazewm.exe command ignore,,Hide
    WinSet, AlwaysOnTop, On, ahk_pid %weztermPID%
}

return
^+Space::ToggleTaskbar()
!Space::ToggleScratchPad()

!Enter::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh move-workspace",, Hide
!Backspace::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh switch-minimized",, Hide

!+f::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh toggle-float",, Hide
!+x::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh unminimize",, Hide
^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
