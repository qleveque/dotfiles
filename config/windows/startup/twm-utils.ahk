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
^!+Space::
    DetectHiddenWindows, On
    IfWinExist, DRAFT
    {
        WinGet, style, Style, DRAFT
        if (style & 0x10000000) {
            WinHide, DRAFT
        } else {
            WinShow, DRAFT
            WinActivate, DRAFT
        }
    }
    Else
        Run, %ComSpec% /C start "DRAFT" /D "%USERPROFILE%" wsl.exe -e nvim .draft.txt,, Hide
return
