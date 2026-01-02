@ECHO OFF
for /f "tokens=1,2" %%A in ('glazewm.exe query focused ^| jq -r ".data.focused | ""\(.id) \(.state.type)"" "') do (
    set id=%%A
    set state=%%B
)
if "%state%"=="tiling" ( set cmd="set-floating" ) else ( set cmd="set-tiling" )
glazewm.exe command --id %id% %cmd%
