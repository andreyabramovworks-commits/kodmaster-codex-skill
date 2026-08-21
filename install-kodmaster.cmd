@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-kodmaster.ps1"
if errorlevel 1 (
  echo.
  echo Installation failed. Keep this window open and copy the error message.
  pause
  exit /b 1
)
echo.
pause
