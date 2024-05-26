@echo off
echo List of saved Wi-Fi networks and their passwords:
echo -----------------------------------------------
for /F "skip=9 tokens=1,2 delims=:" %%i in ('netsh wlan show profiles') do (
    set "ssid=%%i %%j"
    call :showpass !ssid:~1!
)
pause
goto :eof

:showpass
setlocal
set "ssid=%*"
netsh wlan show profile name="%ssid%" key=clear | findstr "Key Content"
endlocal
goto :eof
