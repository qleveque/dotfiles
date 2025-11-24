#Persistent
#SingleInstance Force

!Backspace::Run, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh switch-minimized",, Hide
!+x::Run, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh unminimize",, Hide

!Enter::Run, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh move-workspace",, Hide
!+Enter::Run, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh switch-workspaces",, Hide

^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
