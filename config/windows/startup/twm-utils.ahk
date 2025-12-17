#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1
#Include %A_ScriptDir%\..\twm-utils\toggle-taskbar.ahk
#Include %A_ScriptDir%\..\twm-utils\toggle-scratchpad.ahk

EnforceHideTaskbar()
EnvGet, UserProfile, USERPROFILE
TWM_UTILS := USERPROFILE "\dotfiles\config\windows\twm-utils"

^+Space::ToggleTaskbar()
!Space::ToggleScratchPad()
!Enter::RunWait, %TWM_UTILS%\move-workspace.bat,, Hide
!Backspace::RunWait, %TWM_UTILS%\switch-minimized.bat,, Hide
!+f::RunWait, %TWM_UTILS%\toggle-float.bat,, Hide
!+x::RunWait, %TWM_UTILS%\unminimize.bat,, Hide
!i::RunWait, %TWM_UTILS%\move-workspace.bat,, Hide
^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
