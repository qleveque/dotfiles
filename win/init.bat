@echo off
echo RUN "usermod -d /mnt/c/Users/qleveque whenti" and EXIT
call cmd.exe /C wsl -u root

cd %USERPROFILE%
bash -e ./dotfiles/init

echo DOWNLOAD InconsolataGo from "https://www.nerdfonts.com/font-downloads"
pause

echo DONE
pause
