#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1
#Include %A_ScriptDir%\toggle-taskbar.ahk
#Include %A_ScriptDir%\toggle-scratchpad.ahk
SetWorkingDir, %A_ScriptDir%

EnforceHideTaskbar()

return

^+Space::ToggleTaskbar()
!Space::ToggleScratchPad()
!+Space::RunWait, yasbc.exe toggle-bar,, Hide
!Enter::RunWait, move-workspace.bat,, Hide
!Backspace::RunWait, switch-minimized.bat,, Hide
!+f::RunWait, toggle-fullscreen.bat,, Hide
!+x::RunWait, unminimize.bat,, Hide
^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"
