#SingleInstance Force

MONITOR_DEFAULTTONEAREST := 0x00000002

GetMonitor(hwnd){
  NumPut("uint", 40, monInfo := Buffer(40))
  return DllCall("MonitorFromWindow", "uint", hwnd, "uint", MONITOR_DEFAULTTONEAREST)
}

MinimizedWindows(activeWin) {
    monitor := GetMonitor(activeWin)
    windows := Map(activeWin, 0)
    for id in WinGetList() {
        minMax := WinGetMinMax("ahk_id " id)
        title := WinGetTitle("ahk_id " id)
        if (GetMonitor(id) = monitor && minMax = -1 && StrLen(title) > 0)
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
    if !WinExist("A") {
        return
    }
    activeWin := WinGetID("A")
    mins := MinimizedWindows(activeWin)
    if (mins.length = 1)
        return
    idx := IndexOf(mins, activeWin)
    newIdx := Mod(idx - 1 + dir + mins.length, mins.length)
    WinMinimize("ahk_id " activeWin)
    WinRestore("ahk_id " mins[newIdx + 1])
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

!f::Activate(1)
!d::Activate(-1)
!q::Close()
!+q::WinClose("A")
