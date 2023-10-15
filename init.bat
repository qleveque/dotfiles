:: Initialize windows environment
@ECHO OFF

NET session >NUL 2>&1
IF %ERRORlEVEL% NEQ 0 (
  ECHO Requires admin rights
  EXIT
)
ECHO RUN "usermod -d /mnt/c/Users/qleve qleveque" and EXIT
CALL cmd.exe /C wsl -u root

MKDIR "%APPDATA%\Code\User"
MKLINK "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfiles\stowme\.config\Code\User\settings.json"
MKLINK "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfiles\stowme\.config\Code\User\keybindings.json"
MKLINK "%USERPROFILE%\_ideavimrc" "%USERPROFILE%\dotfiles\stowme\.ideavimrc"

PATH|FIND /i "%USERPROFILE%\bin" >NUL || SETX PATH "%PATH%;%USERPROFILE%\bin"
PATH|FIND /i "%USERPROFILE%\dotfiles\bin" >NUL || SETX PATH "%PATH%;%USERPROFILE%\dotfiles\bin"
START "" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip

ECHO Done, now RUN "bash ~/dotfiles/init"
PAUSE
