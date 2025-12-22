DetectHiddenWindows, On
WinGet, id, List

Loop, %id%
{
    hwnd := id%A_Index%

    WinGet, state, MinMax, ahk_id %hwnd%
    if (state != -1)
        continue

    WinRestore, ahk_id %hwnd%
}
return
