@ECHO OFF
for /f "tokens=1" %%A in ('glazewm.exe query workspaces ^| jq.exe -r " [.data.workspaces[] | select(.hasFocus) | .. | objects | select(.type == ""window"" and .state.type== ""minimized"") | .id] | .[0] "') do (
    set min=%%A
)
glazewm.exe command --id %min% toggle-minimized
