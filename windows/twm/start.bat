@echo OFF
set "SCRIPT_DIR=%~dp0"
start "" "%PROGRAMFILES%\AutoHotkey\AutoHotkeyU64.exe" "%SCRIPT_DIR%\hotkeys.ahk"
start "" "%PROGRAMFILES%\AutoHotkey\AutoHotkeyU64.exe" "%SCRIPT_DIR%\hide-taskbar.ahk"
start "" "%PROGRAMFILES%\YASB\yasb.exe"
tasklist /FI "IMAGENAME eq Flow.Launcher.exe" | find /I "Flow.Launcher.exe" >nul
if errorlevel 1 (
    start "" "%LOCALAPPDATA%\FlowLauncher\Flow.Launcher.exe"
)
tasklist /FI "IMAGENAME eq glazewm.exe" | find /I "glazewm.exe" >nul
if errorlevel 1 (
    start "" "%PROGRAMFILES%\glzr.io\GlazeWM\glazewm.exe"
)
