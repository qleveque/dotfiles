LWin::
    If ProcessExist ("Flow.Launcher.exe"){
        KeyWait, LWin, T0.17
        If !ErrorLevel
            Send, ^!+f
        Else
            Send, {LWin Down}
        KeyWait, LWin
    } else {
        Send, {LWin Down}
        KeyWait, LWin
    }
    Send, {LWin Up}
    return
