#SingleInstance Force

MinimizedWindows(activeWin) {
    windows := Map(activeWin, 0)
    for id in WinGetList() {
        minMax := WinGetMinMax("ahk_id " id)
        title := WinGetTitle("ahk_id " id)
        if ( minMax = -1 && StrLen(title) > 0)
            windows[id] := 0
    }
    ret := Array()
    for k, _ in windows
        ret.Push(k)
    return ret
}

IndexOf(obj, item) {
    for i, val in obj
        if (val = item)
            return i
    return -1
}

Activate(dir) {
    activeWin := WinGetID("A")
    mins := MinimizedWindows(activeWin)
    if (mins.length = 1)
        return
    idx := IndexOf(mins, activeWin)
    newIdx := Mod(idx - 1 + dir + mins.length, mins.length)
    WinRestore("ahk_id " mins[newIdx + 1])
    WinMinimize("ahk_id " activeWin)
}

Close() {
    activeWin := WinGetID("A")
    mins := MinimizedWindows(activeWin)
    if (mins.length > 1) {
        idx := IndexOf(mins, activeWin)
        newIdx := Mod(idx + mins.length, mins.length)
        WinRestore("ahk_id " mins[newIdx + 1])
    }
    WinClose("ahk_id " activeWin)
}

!p::Activate(1)
!n::Activate(-1)
!q::Close()
