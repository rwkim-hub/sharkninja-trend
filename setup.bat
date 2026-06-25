@echo off
chcp 65001 > nul
echo ===================================
echo  Trend Dashboard GitHub Deploy
echo ===================================

cd /d "%~dp0"

SET "PATH=%PATH%;C:\Users\MADUP\AppData\Local\Microsoft\WinGet\Links"

where gh >nul 2>&1
if errorlevel 1 (
    echo ERROR: gh CLI not found. Please run in PowerShell:
    echo   winget install --id GitHub.cli
    pause
    exit /b 1
)

git init
git add .
git commit -m "feat: weekly social trend dashboard"

gh repo create trend-dashboard --public --source=. --remote=origin --push

echo.
echo Enabling GitHub Pages...

gh api -X PUT repos/rwkim-hub/trend-dashboard/pages -f "source[branch]=main" -f "source[path]=/"

echo.
echo ===========================================
echo  Done!
echo  URL: https://rwkim-hub.github.io/trend-dashboard/
echo  (wait 1-2 min for Pages to activate)
echo ===========================================

pause
