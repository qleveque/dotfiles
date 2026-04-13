@ECHO OFF

setlocal enabledelayedexpansion
set CMD=wsl.exe zsh -c "wslpath -m `vifm -c :only --choose-dir - . . < /dev/tty`"
for /f "delims=" %%i in ('!CMD!') do set RESULT=%%i
endlocal & set RESULT=%RESULT%

cd %RESULT%
