@echo off

for /f "tokens=1,2" %%A in ('glazewm.exe query monitors ^| jq.exe -r " .data.monitors.[] | select(.hasFocus) | ""\(.x) \(.y)"" "') do (
    set x=%%A
    set y=%%B
)

for /f "tokens=1,2" %%A in ('glazewm.exe query monitors ^| jq.exe -r " .data.monitors.[] | select(.hasFocus == false) | ""\(.x) \(.y)"" "') do (
    set x_=%%A
    set y_=%%B
)

set /a dx=%x% - %x_%
set /a dy=%y% - %y_%

if %dx% lss 0 (set /a absdx = -dx) else (set /a absdx = dx)
if %dy% lss 0 (set /a absdy = -dy) else (set /a absdy = dy)

if %absdx% gtr %absdy% (
    if %x% lss %x_% ( set direction=right ) else ( set direction=left )
) else (
    if %y% lss %y_% ( set direction=down ) else ( set direction=up )
)

glazewm.exe command move-workspace --direction %direction%
