#Persistent
#SingleInstance Force
#MaxThreadsPerHotkey 1
#NoTrayIcon

normalMode := false
downTime := 0
action := false
optionTextObject := false

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

#If !normalMode && !action
SC029::
    if (downTime > 0)
        return
    downTime := A_TickCount
    normalMode := true
    return
#If normalMode
SC029 Up::
    if ((A_TickCount - downTime) > 200)
        normalMode := false
    downTime := 0
    return
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
+V::Send, {Shift up}{Home}{Shift down}{End}
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

#If action != false && optionTextObject = false
h::
j::
k::
l::
b::
w::
e::
    optionBack := action
    action := false
    normalMode := true
    Send, {Shift down}
    SendLevel, 1
    Send, % A_ThisHotkey
    Send, % optionBack
    SendLevel, 0
    return
i::
a::
    optionTextObject := A_ThisHotkey
    return
c::
d::
y::
    optionBack := action
    action := false
    normalMode := true
    if (optionBack = A_ThisHotkey) {
        SendLevel, 1
        Send, {Home}{Shift down}{End}
        Send, % optionBack
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
#If action != false && optionTextObject != false
w::
    optionBack := action
    action := false
    normalMode := true
    optionTextObjectBack := optionTextObject
    optionTextObject := false

        SendLevel, 1
    if (optionTextObjectBack = "i") {
        Send, ^{Right}{Left}{Shift down}^{Left}
    } else if (optionTextObjectBack = "a") {
        Send, ^{Right}{Shift down}^{Left}
    }
        Send, % optionBack
        Send, {Shift up}
        SendLevel, 0
        return
    return
#If
