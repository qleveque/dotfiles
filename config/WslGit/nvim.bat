@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET "command=nvim "
FOR %%p IN (%*) DO (
    SET "a=%%p"
    IF NOT "!a:~0,1!"=="-" (
        SET "a=%%~fp"
        FOR /F "tokens=*" %%g IN ('wsl wslpath "!a:\=/!"') DO (SET a=%%g)
    )
    SET "command=!command! !a!"
)

wsl.exe -e bash --norc -c "source ~/.colors && %command%"
