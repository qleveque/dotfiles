#Persistent
SetTimer, CheckWindow, 100
SetTimer, OnWindowChanged, 3000

CheckWindow:
    WinGet, currentWindow, ID, A
    if (currentWindow != lastWindow)
    {
        lastWindow := currentWindow
        OnWindowChanged()
    }
return

OnWindowChanged() {
    WinGet, windowList, List, ahk_exe zebar.exe

    Loop, %windowList%
    {
        thisWindow := windowList%A_Index%
        WinSet, AlwaysOnTop, On, ahk_id %thisWindow%
    }
}
