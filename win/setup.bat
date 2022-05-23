mklink "%USERPROFILE%\.zshrc_win" "%USERPROFILE%\dotfiles\win\.zshrc_win"
mklink "%USERPROFILE%\_ideavimrc" "%USERPROFILE%\dotfiles\vim\.ideavimrc"
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\config.xlaunch" "%USERPROFILE%\dotfiles\win\config.xlaunch"
mklink "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfiles\vscode\.config\Code\User\settings.json"
mklink "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfiles\vscode\.config\Code\User\keybindings.json"
mklink "%APPDATA%\ConEmu.xml" "%USERPROFILE%\dotfiles\win\ConEmu.xml"
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\conemu.bat" "%USERPROFILE%\dotfiles\win\conemu.bat"

cd %USERPROFILE%
bash -e ./dotfiles/setup

pause
