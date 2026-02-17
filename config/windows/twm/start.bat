@echo OFF
set "SCRIPT_DIR=%~dp0"
start "" %SCRIPT_DIR%\hotkeys.ahk
start "" %SCRIPT_DIR%\hide-taskbar.ahk
start "" "%USERPROFILE%\AppData\Roaming\Programs\Zero Install\0install-win.exe" run https://appdownload.deepl.com/windows/0install/deepl.xml
start "" "%PROGRAMFILES%/YASB/yasb.exe"
tasklist /FI "IMAGENAME eq glazewm.exe" | find /I "glazewm.exe" >nul
if errorlevel 1 (
    start "" "%PROGRAMFILES%/glzr.io/GlazeWM/glazewm.exe"
)
