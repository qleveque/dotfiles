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
    "b": "8_back",
    "m": "9_music",
    "p": "10_post",
    "r": "11_rest",
    "o": "12_oracle",
    "d": "13_dashboard"
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
