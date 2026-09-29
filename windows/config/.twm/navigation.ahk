fonction := false

#If !fonction
<^>!Escape::fonction := true
#If fonction
I::fonction := false
Escape::fonction := false
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
+V::Send, {Home}{Shift up}{Shift down}{End}
+X::Send, {Shift up}^x
+D::Send, {Shift up}{Backspace}
+C::
    Send, {Shift up}{Backspace}
    fonction := false
    return
+Y::Send, {Shift up}^c{Right}

U::Send, ^z
+U::Send, ^y
#If
