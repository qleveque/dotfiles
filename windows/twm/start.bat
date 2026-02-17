@echo OFF
set "SCRIPT_DIR=%~dp0"
start "" %SCRIPT_DIR%\hotkeys.ahk
start "" %SCRIPT_DIR%\hide-taskbar.ahk
start "" "%PROGRAMFILES%/YASB/yasb.exe"
tasklist /FI "IMAGENAME eq glazewm.exe" | find /I "glazewm.exe" >nul
if errorlevel 1 (
    start "" "%PROGRAMFILES%/glzr.io/GlazeWM/glazewm.exe"
)
