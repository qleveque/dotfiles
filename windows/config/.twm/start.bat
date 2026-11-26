@echo OFF
set "SCRIPT_DIR=%~dp0"
start "" "%PROGRAMFILES%\AutoHotkey\AutoHotkeyU64.exe" "%SCRIPT_DIR%\hotkeys.ahk"
start "" "%PROGRAMFILES%\AutoHotkey\AutoHotkeyU64.exe" "%SCRIPT_DIR%\navigation.ahk"
exit
