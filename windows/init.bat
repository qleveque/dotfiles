@echo off

setlocal enabledelayedexpansion

REM Install dependencies
for %%P in (
  glzr-io.glazewm
  AmN.yasb
  Git.Git
  "AutoHotkey.AutoHotkey -v 1.1.37.02"
  equalsraf.win32yank
  jqlang.jq
  wez.wezterm
  Flow-Launcher.Flow-Launcher
  DeepL.DeepL
  gerardog.gsudo
) do (
  winget install --id %%~P -h -e
)

REM Setup
set WSLENV=USERPROFILE/p:APPDATA/p
wsl zsh "${HOME}/dotfiles/windows/setup"

REM Startup script
set "SCRIPT_PATH=%USERPROFILE%\.twm\start.bat"
set "WUDO=%PROGRAMFILES%\gsudo\Current\sudo.exe"
cmd.exe /c "%SCRIPT_PATH%"
%WUDO% schtasks /create /tn "mystartup" /sc onlogon /tr "cmd.exe /C \"%SCRIPT_PATH%\"" /f

REM Restart console
setx WSLENV %WSLENV%
taskkill /f /im WindowsTerminal.exe
taskkill /f /im cmd.exe
start "" wsl.exe
exit
