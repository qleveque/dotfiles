#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1
#Include %A_ScriptDir%\toggle-taskbar.ahk
#Include %A_ScriptDir%\toggle-scratchpad.ahk
#Include %A_ScriptDir%\move-focus-workspace.ahk
#Include %A_ScriptDir%\flow-launcher.ahk
SetWorkingDir, %A_ScriptDir%

return

^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
!Enter::RunWait, move-workspace.bat,, Hide
!+u::RunWait, glazewm.exe command wm-reload-config,, Hide
!v::RunWait, glazewm.exe command toggle-tiling-direction,, Hide

!Space::ToggleScratchPad()
!+Space::ToggleTaskbar()
!Backspace::RunWait, glazewm.exe command wm-cycle-focus,, Hide
!+Backspace::RunWait, switch-minimized.bat,, Hide
!f::RunWait, toggle-floating.bat,, Hide
!+f::RunWait, glazewm.exe command toggle-fullscreen,, Hide
!x::RunWait, glazewm.exe command set-minimized,, Hide
!+x::RunWait, unminimize.bat,, Hide
!q::RunWait, glazewm.exe command close,, Hide

!h::RunWait, glazewm.exe command focus --direction left,, Hide
!l::RunWait, glazewm.exe command focus --direction right,, Hide
!k::RunWait, glazewm.exe command focus --direction up,, Hide
!j::RunWait, glazewm.exe command focus --direction down,, Hide
!+h::RunWait, glazewm.exe command move --direction left,, Hide
!+l::RunWait, glazewm.exe command move --direction right,, Hide
!+k::RunWait, glazewm.exe command move --direction up,, Hide
!+j::RunWait, glazewm.exe command move --direction down,, Hide

!_::RunWait, glazewm.exe command resize --width -100,, Hide
!=::RunWait, glazewm.exe command resize --width +100,, Hide
!+_::RunWait, glazewm.exe command resize --height -100,, Hide
!+=::RunWait, glazewm.exe command resize --height +100,, Hide

!;::RunWait, glazewm.exe command focus --next-active-workspace-on-monitor,, Hide
!,::RunWait, glazewm.exe command focus --prev-active-workspace-on-monitor,, Hide

!z::RunWait, glazewm.exe command focus --recent-workspace,, Hide
!+z::
    RunWait, glazewm.exe command move --recent-workspace,, Hide
    RunWait, glazewm.exe command focus --recent-workspace,, Hide
    return
