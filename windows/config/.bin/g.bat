@ECHO OFF

setlocal enabledelayedexpansion
set CMD=wsl.exe zsh -c "wslpath -m `realpath ${HOME}/.marks/%1`"
for /f "delims=" %%i in ('!CMD!') do set RESULT=%%i
endlocal & set RESULT=%RESULT%

cd %RESULT%
