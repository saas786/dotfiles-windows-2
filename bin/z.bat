@echo off
setlocal enabledelayedexpansion

if exist %TEMP%\zbat.txt del /F /Q %TEMP%\zbat.txt

if exist %~dp0\..\github call :zdir %~dp0\..\github %1
if exist %TEMP%\zbat.txt goto found

if exist %~dp0\..\github\vagrant-sandbox call :zdir %~dp0\..\github\vagrant-sandbox %1
if exist %TEMP%\zbat.txt goto found

if exist %~dp0\..\github\plossys call :zdir %~dp0\..\github\plossys\vagrant %1
if exist %TEMP%\zbat.txt goto found

if exist %~dp0\..\github\plossys call :zdir %~dp0\..\github\plossys %1
if exist %TEMP%\zbat.txt goto found

if exist %USERPROFILE%\github call :zdir %USERPROFILE%\github %1
if exist %TEMP%\zbat.txt goto found

if exist %USERPROFILE%\github\vagrant-sandbox call :zdir %USERPROFILE%\github\vagrant-sandbox %1
if exist %TEMP%\zbat.txt goto found

if exist %USERPROFILE%\github\plossys call :zdir %USERPROFILE%\github\plossys %1
if exist %TEMP%\zbat.txt goto found

if exist g:\github call :zdir g:\github %1
if exist %TEMP%\zbat.txt goto found

goto :EOF


:zdir
set dir=%1
set substr=%2
for /F " usebackq delims==" %%i in (`dir /b %dir%`) do (
  set dn=%%i
  set tst=%%i
  set tst=!tst:%substr%=!
  if not "x!dn!" == "x!tst!" (echo %dir%\!dn! >%TEMP%\zbat.txt & exit /b 42)
)
exit /b

:found
endlocal
for /f "delims=" %%i in (%TEMP%\zbat.txt) do (set zcd=%%i)
if exist %TEMP%\zbat.txt del /F /Q %TEMP%\zbat.txt
cd /D %zcd% 
goto :EOF

