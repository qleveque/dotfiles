@echo off

set WSLENV=USERPROFILE/p:APPDATA/p

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
  start "" /b winget install --id %%~P -h -e
)
:waitloop
timeout /t 1 >nul
tasklist | find /i "winget.exe" >nul
if not errorlevel 1 goto waitloop

wsl zsh -c "cp -rfL ${HOME}/dotfiles/windows/config/. ${USERPROFILE}"
wsl zsh -c "cp -rfL ${HOME}/dotfiles/windows/appdata-config/. ${APPDATA}"
wsl zsh -c "python3 ${HOME}/dotfiles/config/less/lesskey.py wsl > ${USERPROFILE}/.lesskey"

set SCRIPT_PATH="%USERPROFILE%\.twm\start.bat"
cmd.exe /c "%SCRIPT_PATH%"

reg query "HKCU\Environment" /v MYSTARTUP >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    set "WUDO=C:\Program Files\gsudo\Current\sudo.exe"
    %WUDO% schtasks /create /tn "mystartup" /sc onlogon /tr "cmd.exe /C \"%SCRIPT_PATH%\"" /f
    reg add "HKCU\Environment" /v MYSTARTUP /t REG_SZ /d 1 /f
)
