#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1

ToggleTaskbar() {
    WinGet, style, Style, ahk_class Shell_TrayWnd
    if (style & 0x10000000) {
        WinHide, ahk_class Shell_TrayWnd
        WinHide, ahk_class Button
        WinHide, ahk_class Shell_SecondaryTrayWnd
    } else {
        WinShow, ahk_class Shell_TrayWnd
        WinShow, ahk_class Button
        WinShow, ahk_class Shell_SecondaryTrayWnd
    }
}
ToggleTaskbar()

!+x::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh unminimize",, Hide
!Enter::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh switch-minimized",, Hide
!+Enter::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh move-workspace",, Hide

!+Space::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh toggle-float",, Hide
!Backspace::ToggleTaskbar()

^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
LWin::Send, ^+!a
