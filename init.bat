:: Install dependencies on a windows environment
@ECHO OFF

NET session >NUL 2>&1
IF %ERRORlEVEL% NEQ 0 (
  ECHO Requires admin rights
  EXIT
)

ECHO RUN "usermod -d /mnt/c/Users/qleveque qleveque" and EXIT
CALL cmd.exe /C wsl -u root

SET "xconfig=^<?xml version="1.0" encoding="UTF-8"?^>^<XLaunch WindowMode="MultiWindow" ClientMode="NoClient" LocalClient="False" Display="0" LocalProgram="xcalc" RemoteProgram="xterm" RemotePassword="" PrivateKey="" RemoteHost="" RemoteUser="" XDMCPHost="" XDMCPBroadcast="False" XDMCPIndirect="False" Clipboard="True" ClipboardPrimary="True" ExtraParams="-dpi 144" Wgl="True" DisableAC="True" XDMCPTerminate="False"/^>"
ECHO %xconfig%>"%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\config.xlaunch"

MKLINK "%USERPROFILE%\_ideavimrc" "%USERPROFILE%\dotfiles\stowme\.ideavimrc"

MKDIR "%APPDATA%\Code\User"
MKLINK "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfiles\stowme\.config\Code\User\settings.json"
MKLINK "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfiles\stowme\.config\Code\User\keybindings.json"

PATH|FIND /i "%USERPROFILE%\bin" >NUL || SETX PATH "%PATH%;%USERPROFILE%\bin"
PATH|FIND /i "%USERPROFILE%\dotfiles\bin" >NUL || SETX PATH "%PATH%;%USERPROFILE%\dotfiles\bin"

START "" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip

ECHO Done, now RUN "bash ~/dotfiles/init"
PAUSE
