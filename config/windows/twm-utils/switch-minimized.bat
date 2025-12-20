@ECHO OFF
for /f "tokens=1,2" %%A in ('glazewm.exe query workspaces ^| jq.exe -r " [.data.workspaces[] | select(.hasFocus) | .. | objects | select(.type == ""window"" and (.hasFocus or .state.type== ""minimized"") and .className != ""Shell_TrayWnd"" and .className != ""Shell_SecondaryTrayWnd"") | if .hasFocus then ""\(.id),_"" else ""\(.id)"" end] | join("","") | split("","") | . as $arr | ($arr | index(""_"")) as $i | ""\($arr[($i -1)]) \($arr[($i+1) %% length])"" "') do (
    set from=%%A
    set to=%%B
)

if "%to%" NEQ "%from%" (
    glazewm.exe command --id %from% set-minimized
    glazewm.exe command --id %to% toggle-minimized
    glazewm.exe command focus --container-id %from%
    glazewm.exe command focus --container-id %to%
)
