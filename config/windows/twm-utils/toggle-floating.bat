@ECHO OFF
for /f "tokens=1" %%A in ('glazewm.exe query focused ^| jq -r ".data.focused.state.type"') do (
    set state=%%A
)
if "%state%"=="tiling" ( set cmd="set-floating" ) else ( set cmd="set-tiling" )
glazewm.exe command %cmd%
