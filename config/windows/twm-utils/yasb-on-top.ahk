SetTitleMatchMode, 2
RunWait, yasb.exe
WinGet, idList, List, ahk_exe YASB.exe
sorted := ""
Loop, %idList%
    sorted .= idList%A_Index% "|"
Sort, sorted, N D|
Loop, Parse, sorted, |
{
    if (A_LoopField = "")
        continue
    WinSet, AlwaysOnTop, On, ahk_id %A_LoopField%
}
