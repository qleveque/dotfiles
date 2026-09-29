capsDownTime := 0

CapsLock::
    if (capsDownTime > 0)
        return
    SetCapsLockState, % !GetKeyState("CapsLock", "T")
    capsDownTime := A_TickCount
return

CapsLock Up::
    if ((A_TickCount - capsDownTime) > 200)
        SetCapsLockState, % !GetKeyState("CapsLock", "T")
    capsDownTime := 0
return

#If GetKeyState("CapsLock","P") && (A_TickCount - capsDownTime > 50)
H::Send, {Left}
J::Send, {Down}
K::Send, {Up}
L::Send, {Right}
+H::Send, +{Left}
+J::Send, +{Down}
+K::Send, +{Up}
+L::Send, +{Right}
,::Send, ^{Left}
`;::Send, ^{Right}
+,::Send, +^{Left}
+`;::Send, +^{Right}
SC01B::Send, {End}
^!SC00A::Send, {Home}
+SC01B::Send, +{End}
+^!SC00A::Send, +{Home}
P::Send, #{PrintScreen}
Down::Send, {Media_Play_Pause}
Right::Send, {Media_Next}
Left::Send, {Media_Prev}
#If
