SetCapsLockState, AlwaysOff

capsUsed := false

*CapsLock::
    if (GetKeyState("CapsLock", "P") && A_PriorHotkey = "*CapsLock" && A_TimeSincePriorHotkey < 400)
        return
    capsUsed := false
    KeyWait, CapsLock
    if (!capsUsed) {
        ; Plain tap: toggle real CapsLock state
        SetCapsLockState, % GetKeyState("CapsLock", "T") ? "AlwaysOff" : "AlwaysOn"
    }
return

CapsLock & h::
    capsUsed := true
    Send {Blind}{Left}
    return
CapsLock & j::
    capsUsed := true
    Send {Blind}{Down}
    return
CapsLock & k::
    capsUsed := true
    Send {Blind}{Up}
    return
CapsLock & l::
    capsUsed := true
    Send {Blind}{Right}
    return
CapsLock & ,::
    capsUsed := true
    Send {Blind}{Ctrl down}{Left}{Ctrl up}
    return
CapsLock & `;::
    capsUsed := true
    Send {Blind}{Ctrl down}{Right}{Ctrl up}
    return
CapsLock & SC01B::
    capsUsed := true
    Send {Blind}{End}
    return
CapsLock & SC00A::
    capsUsed := true
    Send {Blind}{Home}
    return
CapsLock & P::
    capsUsed := true
    Send, #{PrintScreen}
    return
CapsLock & Down::
    capsUsed := true
    Send, {Media_Play_Pause}
    return
CapsLock & Right::
    capsUsed := true
    Send, {Media_Next}
    return
CapsLock & Left::
    capsUsed := true
    Send, {Media_Prev}
    return
