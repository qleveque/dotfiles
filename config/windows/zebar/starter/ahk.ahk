
WinGet, windowList, List, ahk_exe zebar.exe

WinGetPos, X, Y, Width, Height, A
SysGet, MonitorWidth, 78
SysGet, MonitorHeight, 79
if (Width > MonitorWidth - 10 and Height > MonitorHeight - 10)
{
    return
}

Loop, %windowList%
{
    thisWindow := windowList%A_Index%
    WinSet, AlwaysOnTop, On, ahk_id %thisWindow%
}
