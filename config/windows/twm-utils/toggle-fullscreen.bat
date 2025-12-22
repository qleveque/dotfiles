@ECHO OFF
for /f "tokens=1" %%A in ('glazewm.exe query focused ^| jq -r ".data.focused.state.type"') do (
    set state=%%A
)
if "%state%"=="fullscreen" ( set cmd="set-tiling" ) else ( set cmd="set-fullscreen" )
glazewm.exe command %cmd%
