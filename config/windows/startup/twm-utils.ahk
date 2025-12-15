#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1

ToggleTaskbar() {
    global taskbarHidden
    if (!taskbarHidden) {
        EnforceHideTaskbar()
        SetTimer, EnforceHideTaskbar, 1000
    } else {
        SetTimer, EnforceHideTaskbar, Off
        WinShow, ahk_class Shell_TrayWnd
        WinShow, ahk_class Shell_SecondaryTrayWnd
    }
    taskbarHidden := !taskbarHidden
}
EnforceHideTaskbar() {
    WinGet, style, Style, ahk_class Shell_TrayWnd
    if (style & 0x10000000) {
        WinHide, ahk_class Shell_TrayWnd
    }
    WinGet, style, Style, ahk_class Shell_SecondaryTrayWnd
    if (style & 0x10000000) {
        WinHide, ahk_class Shell_SecondaryTrayWnd
    }
}

taskbarHidden := false
ToggleTaskbar()
^+Space::ToggleTaskbar()

!Enter::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh move-workspace",, Hide
!Backspace::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh switch-minimized",, Hide

!+Space::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh toggle-float",, Hide
!+x::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh unminimize",, Hide
^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"

!i::
    DetectHiddenWindows, On
    if (WeztermPID) {
        if WinExist("ahk_pid " . WeztermPID) {
            if WinActive("ahk_pid " . WeztermPID) {
                WinHide, ahk_pid %WeztermPID%
            } else {
                WinShow, ahk_pid %WeztermPID%
                WinActivate, ahk_pid %WeztermPID%
            }
            return
        }
    }

    EnvSet, WEZTERM_DRAFT, 1
    EnvGet, UserProfile, USERPROFILE
    Run, wezterm-gui.exe start --cwd %USERPROFILE%/.drafts nvim index,,, WeztermPID
    EnvSet, WEZTERM_DRAFT, 0
return
