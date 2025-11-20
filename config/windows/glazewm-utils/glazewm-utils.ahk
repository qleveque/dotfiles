#Persistent
#SingleInstance Force

!f::Run, bash -c "~/dotfiles/config/windows/glazewm-utils/glazewm-utils.sh toggle-fullscreen",, Hide
!+f::Send {F11}
!+Space::Run, bash -c "~/dotfiles/config/windows/glazewm-utils/glazewm-utils.sh toggle-floating",, Hide

!Enter::Run, bash -c "~/dotfiles/config/windows/glazewm-utils/glazewm-utils.sh move-workspace",, Hide
!+Enter::Run, bash -c "~/dotfiles/config/windows/glazewm-utils/glazewm-utils.sh switch-workspaces",, Hide

^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"

!u::
    Process, Close, zebar.exe
    Run, zebar.exe
    ExitApp
