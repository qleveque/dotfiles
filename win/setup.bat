mklink "%USERPROFILE%\.zshrc_win" "%USERPROFILE%\dotfiles\win\.zshrc_win"
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\config.xlaunch" "%USERPROFILE%\dotfiles\win\config.xlaunch"
mklink "%APPDATA%\ConEmu.xml" "%USERPROFILE%\dotfiles\win\ConEmu.xml"
mklink /D "%APPDATA%\Code" "%USERPROFILE%\dotfiles\vscode\.config\Code"
mklink /D "%APPDATA%\alacritty" "%USERPROFILE%\dotfiles\alacritty\.config\alacritty"

cd %USERPROFILE%
bash -e ./dotfiles/setup

pause