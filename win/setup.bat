mklink "%USERPROFILE%\.zshrc_win" "%USERPROFILE%\dotfiles\win\.zshrc_win"
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\config.xlaunch" "%USERPROFILE%\dotfiles\win\config.xlaunch"
mklink "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfiles\vscode\.config\Code\User\settings.json"
mklink "%APPDATA%\ConEmu.xml" "%USERPROFILE%\dotfiles\win\ConEmu.xml"
mklink /D "%APPDATA%\alacritty" "%USERPROFILE%\dotfiles\alacritty\.config\alacritty"

cd %USERPROFILE%
bash -e ./dotfiles/setup

pause
