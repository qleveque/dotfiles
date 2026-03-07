LWin & AppsKey::Return
LWin Up::
If ProcessExist("Flow.Launcher.exe"){
  SendInput, !+^f
}else{ ; if process doesn't exist, windows key will function like normal
  SendInput, {LWin}
}
return

ProcessExist(Name){
  Process,Exist,%Name%
  return Errorlevel
}
