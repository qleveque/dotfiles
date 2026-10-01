#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1
#NoTrayIcon

normalMode := false
downTime := 0
action := false

Gui, +AlwaysOnTop -Caption +ToolWindow +E0x20 +HwndModeGuiHwnd
Gui, Color, 005F00
Gui, Margin, 30, 4
Gui, Font, cWhite s20 Bold, Consolas
Gui, Add, Text, vModeText, NORMAL
Gui, +LastFound
WinSet, Transparent, 200
Gui, Show, Hide NA
SetTimer, UpdateModeIndicator, 200
return

~LControl Up::
    if (A_PriorKey = "LControl") {
        if (normalMode) {
            normalMode := false
            Send, {Shift up}
        } else {
            normalMode := true
        }
    }
    return
#If normalMode
I::
A::
Escape::
    normalMode := false
    return
Enter::
    normalMode := false
    Send, {Enter}
    return
p::Send, ^v
*H::Send, {Left}
*J::Send, {Down}
*K::Send, {Up}
*L::Send, {Right}
*W::Send, ^{Right}
*E::Send, {Right}^{Right}{Left}
*B::Send, ^{Left}
*SC01B::Send, {End}
*^!SC00A::Send, {Home}

V::Send, {Shift down}
+Escape::Send, {Shift up}{Right}
+V::Send, {Shift up}^{Home}{Shift down}^{End}
+X::Send, {Shift up}^x
+D::Send, {Shift up}{Backspace}
+C::
    normalMode := false
    Send, {Shift up}{Backspace}
    return
+Y::Send, {Shift up}^c{Right}

U::Send, ^z
+U::Send, ^y

+G::Send, ^{End}

c::
d::
y::
g::
    normalMode := false
    action := A_ThisHotkey
    return

#If action != false
h::
j::
k::
l::
b::
w::
e::
    actionBk := action
    action := false
    normalMode := true
    Send, {Shift down}
    SendLevel, 1
    Send, % A_ThisHotkey
    Send, % actionBk
    SendLevel, 0
    return
i::
a::
    textObject := A_ThisHotkey
    actionBk := action
    action := false
    Input, key, L1
    if (key != "w")
        return
    normalMode := true

    SendLevel, 1
    if (textObject = "i") {
        Send, ^{Right}{Left}{Shift down}^{Left}
    } else if (textObject = "a") {
        Send, ^{Right}{Shift down}^{Left}
    }
    Send, % actionBk
    Send, {Shift up}
    SendLevel, 0
    action := false
    return
c::
d::
y::
    actionBk := action
    action := false
    normalMode := true
    if (actionBk = A_ThisHotkey) {
        SendLevel, 1
        Send, {Home}{Shift down}{End}
        Send, % actionBk
        Send, {Shift up}
        SendLevel, 0
    }
    return
g::
    if (action = A_ThisHotkey) {
        Send, ^{Home}
        action := false
        normalMode := true
    }
    return
#If

UpdateModeIndicator:
    if (!normalMode && !action) {
        Gui, Hide
        return
    }

    WinGetPos, winX, winY,,, A
    if (winX = "" || winY = "")
        return

    if (GetKeyState("Shift")) {
        Gui, Color, 875FD7
        GuiControl,, ModeText, VISUAL
    } else {
        Gui, Color, 7CFC90
        GuiControl,, ModeText, NORMAL
    }

    Gui, Show, x%winX% y%winY% NA
    return
