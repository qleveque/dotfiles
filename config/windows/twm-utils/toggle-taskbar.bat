@echo off
REM Check if AutoHotkeyU64.exe with --hide-taskbar is running
tasklist.exe /FI "IMAGENAME eq AutoHotkeyU64.exe" /V | findstr.exe /I "hide-taskbar" >nul

IF %ERRORLEVEL%==0 (
    for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq AutoHotkeyU64.exe" /V ^| findstr /I "hide-taskbar"') do (
        taskkill /PID %%i /F
    )
    start "" "%USERPROFILE%\dotfiles\config\windows\twm-utils\show-taskbar.ahk"
) ELSE (
    start "" "%USERPROFILE%\dotfiles\config\windows\twm-utils\hide-taskbar.ahk" --hide-taskbar
)
