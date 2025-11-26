#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1

ToggleTaskbar() {
    WinGet, style, Style, ahk_class Shell_TrayWnd
    if (style & 0x10000000) {
        WinHide, ahk_class Shell_TrayWnd
        WinHide, ahk_class Shell_SecondaryTrayWnd
    } else {
        WinShow, ahk_class Shell_TrayWnd
        WinShow, ahk_class Shell_SecondaryTrayWnd
    }
}

ToggleTaskbar()
^+Space::ToggleTaskbar()

!Enter::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh move-workspace",, Hide
!Backspace::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh switch-minimized",, Hide

!+Space::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh toggle-float",, Hide
!+x::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh unminimize",, Hide

^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
