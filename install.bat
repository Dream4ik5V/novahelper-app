@echo off
setlocal
title NOVA RP Admin Wiki - download and install
cd /d "%~dp0"

set "URL=https://github.com/Dream4ik5V/novahelper-app/releases/latest/download/NOVA-RP-Wiki-Setup.exe"
set "OUT=%TEMP%\NOVA-RP-Admin-Wiki-Setup.exe"

echo.
echo  ==========================================
echo   NOVA RP Admin Wiki
echo  ==========================================
echo.
echo  Downloading installer (~133 MB)...
echo  This may take a minute.

if exist "%OUT%" del /f /q "%OUT%" >nul 2>&1

where curl.exe >nul 2>&1
if %errorlevel%==0 (
  curl.exe -L --fail --silent --show-error -o "%OUT%" "%URL%"
) else (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%OUT%' -UseBasicParsing"
)

if not exist "%OUT%" (
  echo.
  echo  ERROR: download failed. Check internet connection and try again.
  pause
  exit /b 1
)

for %%A in ("%OUT%") do set "SIZE=%%~zA"
if %SIZE% LSS 50000000 (
  echo.
  echo  ERROR: file is too small, download looks broken.
  pause
  exit /b 1
)

echo.
echo  Downloaded. Starting installer...
echo.
start "" "%OUT%"
timeout /t 3 >nul
exit /b 0
