start "" %USERPROFILE%\dotfiles\config\windows\twm-utils\twm-utils.ahk
start "" %USERPROFILE%\dotfiles\config\windows\twm-utils\hide-taskbar.ahk
start "" glazewm.exe
start "" yasb.exe

REM DEEPL
set "ZEROINSTALL="
if exist "C:\Progra"" "%ZEROINSTALL%" run https://appdownload.deepl.com/windows/0install/deepl.xml

exit
