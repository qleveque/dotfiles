@ECHO OFF

for /f "tokens=1,2" %%A in ('glazewm.exe query workspaces ^| jq.exe -r " [.data.workspaces[] | select(.hasFocus) | .. | objects | select(.type == ""window"" and ((.hasFocus and .state.type==""tiling"") or .state.type== ""minimized"")) | if .hasFocus then ""\(.id),_"" else ""\(.id)"" end] | join("","") | split("","") | . as $arr | ($arr | index(""_"")) as $i | ""\($arr[($i -1)]) \($arr[($i+1) %% length])"" "') do (
    set from=%%A
    set to=%%B
)

if not "%from%"=="" if not "%to%"=="" if not "%to%"=="%from%" (
    glazewm.exe command --id %from% set-minimized
    call :sleep
    glazewm.exe command --id %to% set-tiling
    call :sleep
    glazewm.exe command focus --container-id %from%
    call :sleep
    glazewm.exe command focus --container-id %to%
    call :sleep
    glazewm.exe command focus --container-id %to%
)


exit /b

:sleep
glazewm.exe query focused >nul
exit /b
