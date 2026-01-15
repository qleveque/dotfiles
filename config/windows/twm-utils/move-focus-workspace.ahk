workspaces :=
(Join
{
    "a": "1_any",
    "e": "2_else",
    "w": "3_web",
    "t": "4_term",
    "s": "5_send",
    "c": "6_code",
    "g": "7_gui",
    "d": "8_dash",
    "b": "9_back",
    "m": "10_music",
    "p": "11_post",
    "r": "12_rest"
}
)
HotkeyData := {}

for key, ws in workspaces
{
    Hotkey, % "!" key, FocusWS, On
    Hotkey, % "!+" key, MoveWS, On
    HotkeyData["!" key] := ws
    HotkeyData["!+" key] := ws
}
FocusWS:
    ws := HotkeyData[A_ThisHotkey]
    DllCall("SetForegroundWindow", "ptr", WinExist("ahk_class Progman"))
    RunWait, glazewm.exe command focus --workspace %ws%,, Hide
    return

MoveWS:
    ws := HotkeyData[A_ThisHotkey]
    RunWait, glazewm.exe command move --workspace %ws%,, Hide
    RunWait, glazewm.exe command focus --workspace %ws%,, Hide
    return
