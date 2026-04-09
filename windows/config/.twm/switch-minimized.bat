@ECHO OFF

for /f "tokens=1,2" %%A in ('glazewm.exe query workspaces ^| jq.exe -r " [.data.workspaces[] | select(.hasFocus) | .. | objects | select(.type == ""window"" and ((.hasFocus and .state.type==""tiling"") or .state.type== ""minimized"")) | if .hasFocus then ""\(.nativeWindowHandle // .handle),_"" else ""\(.nativeWindowHandle // .handle)"" end] | join("","") | split("","") | . as $arr | ($arr | index(""_"")) as $i | ""\($arr[($i -1)]) \($arr[($i+1) %% length])"" "') do (
    set from=%%A
    set to=%%B
)

if not "%from%"=="" if not "%to%"=="" if not "%to%"=="%from%" (
    call "%USERPROFILE%\.twm\switch-minimized.ahk" %from% %to%
)


exit /b
