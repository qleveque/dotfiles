count := A_Args.MaxIndex()

current := A_Args[1]
if (count == 1) {
  WinActivate, ahk_id %current%
  ExitApp
}

next := A_Args[2]
if (count == 2) {
  WinMinimize, ahk_id %current%
  WinActivate, ahk_id %next%
  ExitApp
}
