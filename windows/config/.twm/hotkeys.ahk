#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1
#NoTrayIcon
#Include %A_ScriptDir%\toggle-scratchpad.ahk
#Include %A_ScriptDir%\toggle-deepl.ahk
#Include %A_ScriptDir%\move-focus-workspace.ahk
#Include %A_ScriptDir%\flow-launcher.ahk

return

Insert::Send, #{PrintScreen}
#Up::Send, {Volume_Up}
#Down::Send, {Volume_Down}
#Right::Send, {Media_Next}
#Left::Send, {Media_Prev}

^!+t::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"
^!+w::Run, "C:\Program Files\Zen Browser\zen.exe"

!Space::ToggleScratchPad()
!+Space::ToggleDeepL()
!Enter::RunWait, %A_ScriptDir%\move-workspace.bat,, Hide
!Backspace::RunWait, glazewm.exe command wm-cycle-focus,, Hide
!+Backspace::RunWait, %A_ScriptDir%\switch-minimized.bat,, Hide
!f::RunWait, %A_ScriptDir%\toggle-floating.bat,, Hide
!+f::RunWait, glazewm.exe command toggle-fullscreen,, Hide
!x::RunWait, glazewm.exe command set-minimized,, Hide
!+x::RunWait, %A_ScriptDir%\unminimize.bat,, Hide
!v::RunWait, glazewm.exe command toggle-tiling-direction,, Hide
!q::WinClose, A

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
