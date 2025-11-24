#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1

!+x::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh unminimize",, Hide
!Enter::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh switch-minimized",, Hide
!+Enter::RunWait, bash -c "~/dotfiles/config/windows/twm-utils/twm-utils.sh move-workspace",, Hide

^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
