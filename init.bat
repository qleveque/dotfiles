@echo off
echo RUN "usermod -d /mnt/c/Users/qleveque qleveque" and EXIT
call cmd.exe /C wsl -u root

set "xconfig=^<?xml version="1.0" encoding="UTF-8"?^>^<XLaunch WindowMode="MultiWindow" ClientMode="NoClient" LocalClient="False" Display="0" LocalProgram="xcalc" RemoteProgram="xterm" RemotePassword="" PrivateKey="" RemoteHost="" RemoteUser="" XDMCPHost="" XDMCPBroadcast="False" XDMCPIndirect="False" Clipboard="True" ClipboardPrimary="True" ExtraParams="-dpi 144" Wgl="True" DisableAC="True" XDMCPTerminate="False"/^>"
echo %xconfig%>"%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\config.xlaunch"

mklink "%USERPROFILE%\_ideavimrc" "%USERPROFILE%\dotfiles\stowme\.ideavimrc"

mkdir "%APPDATA%\Code"
mkdir "%APPDATA%\Code\User"
mklink "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfiles\stowme\.config\Code\User\settings.json"
mklink "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfiles\stowme\.config\Code\User\keybindings.json"

path|find /i "%USERPROFILE%\bin" > nul || setx path "%path%;%USERPROFILE%\bin"
path|find /i "%USERPROFILE%\dotfiles\bin" > nul || setx path "%path%;%USERPROFILE%\dotfiles\bin"

start "" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip

echo DONE, now RUN "bash ~/dotfiles/init"
pause
