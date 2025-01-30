#Persistent
#SingleInstance Force

SetTimer, MoveTaskbarToBottom, 1000
SetTimer, CheckActiveWindow, 100
MoveTaskbarToBottom()
return

CheckActiveWindow:
    WinGet, currentWindow, ID, A
    if (currentWindow != lastWindow) {
        lastWindow := currentWindow
        MoveTaskbarToBottom()
    }
return

MoveTaskbarToBottom() {
    WinGet, windowList, List, ahk_class Shell_TrayWnd
    Loop, %windowList%
    {
        thisWindow := windowList%A_Index%
        WinSet, Bottom, , ahk_id %thisWindow%
    }
}
