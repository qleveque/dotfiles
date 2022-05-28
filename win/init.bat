@echo off
echo RUN "usermod -d /mnt/c/Users/qleveque whenti" and EXIT
call cmd.exe /C wsl -u root

cd %USERPROFILE%
bash -e ./dotfiles/init

start "" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip

echo DONE
pause
