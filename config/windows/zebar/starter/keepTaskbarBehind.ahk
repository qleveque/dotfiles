#Persistent
#SingleInstance Force

SetTimer, MoveTaskbarToBottom, 3000
SetTimer, CheckActiveWindow, 100
MoveTaskbarToBottom()
return

!u::
    Process, Close, zebar.exe
    Run, zebar.exe
    ExitApp

CheckActiveWindow:
    WinGet, currentWindow, ID, A
    if (currentWindow != lastWindow) {
        lastWindow := currentWindow
        MoveTaskbarToBottom()
    }
return

MoveTaskbarToBottom() {
    WinGet, windowsTaskBar, ID, ahk_class Shell_TrayWnd
    if (windowsTaskBar) {
        WinSet, Bottom, , ahk_id %windowsTaskBar%
    }
    WinGet, windowsSecondaryTaskBar, ID, ahk_class Shell_SecondaryTrayWnd
    if (windowsSecondaryTaskBar) {
        WinSet, Bottom, , ahk_id %windowsSecondaryTaskBar%
    }
}
