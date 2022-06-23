mklink "%USERPROFILE%\.zshrc_win" "%USERPROFILE%\dotfiles\win\.zshrc_win"
mklink "%USERPROFILE%\_ideavimrc" "%USERPROFILE%\dotfiles\vim\.ideavimrc"
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\config.xlaunch" "%USERPROFILE%\dotfiles\win\config.xlaunch"
mklink "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfiles\vscode\.config\Code\User\settings.json"
mklink "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfiles\vscode\.config\Code\User\keybindings.json"

path|find /i "%USERPROFILE%\bin" > nul || setx path "%path%;%USERPROFILE%\bin"
path|find /i "%USERPROFILE%\.bin" > nul || setx path "%path%;%USERPROFILE%\.bin"

cd %USERPROFILE%
bash -e ./dotfiles/setup

pause
