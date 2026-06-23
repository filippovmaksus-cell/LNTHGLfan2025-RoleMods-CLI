@echo off
setlocal EnableDelayedExpansion

:: Configure window size
mode con: cols=80 lines=25
title LNTHGLfan2025 RoleMods - CMD Installer

:: Retrieve escape character for ANSI colors
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "CLR_RESET=%ESC%[0m"
set "CLR_GREEN=%ESC%[32m"
set "CLR_RED=%ESC%[31m"
set "CLR_YELLOW=%ESC%[33m"
set "CLR_GRAY=%ESC%[90m"

echo %CLR_YELLOW%===================================================%CLR_RESET%
echo           LNTHGLfan2025 RoleMods CLI Installer         
echo ===================================================%CLR_RESET%
echo.

:: Define Target Path
set "INSTALL_DIR=%LocalAppData%\LNTHGLfan2025\RoleModsCLI"
set "SOURCE_FILE=rolemods.bat"

:: Step 1: Verify source file exists
if not exist "%SOURCE_FILE%" (
    echo %CLR_RED%[Error] Source file '%SOURCE_FILE%' not found in this folder.%CLR_RESET%
    echo Please ensure the CLI script is next to this installer.
    echo.
    pause
    exit /b 1
)

:: Step 2: Create target directory
echo %CLR_GRAY%[1/4] Creating application directory...%CLR_RESET%
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)
ping 127.0.0.1 -n 2 >nul

:: Step 3: Copy main CLI file
echo %CLR_GRAY%[2/4] Copying files to destination...%CLR_RESET%
copy /Y "%SOURCE_FILE%" "%INSTALL_DIR%\" >nul
ping 127.0.0.1 -n 2 >nul

:: Step 4: Register PATH environment variable safely (prevents truncation)
echo %CLR_GRAY%[3/4] Adding command to user PATH...%CLR_RESET%
set "USERPATH="
for /f "tokens=2*" %%A in ('reg query HKCU\Environment /v PATH 2^{delete}nul') do set "USERPATH=%%B"

if not defined USERPATH (
    setx PATH "%INSTALL_DIR%" >nul
) else (
    echo !USERPATH! | findstr /i "LNTHGLfan2025\RoleModsCLI" >nul
    if errorlevel 1 (
        setx PATH "!USERPATH!;%INSTALL_DIR%" >nul
    )
)
ping 127.0.0.1 -n 2 >nul

:: Step 5: Create Desktop Shortcut via temporary VBScript
echo %CLR_GRAY%[4/4] Creating desktop shortcut...%CLR_RESET%
set "VBS_SCRIPT=%TEMP%\%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> "%VBS_SCRIPT%"
echo sLinkFile = "%USERPROFILE%\Desktop\LNTHGLfan2025 RoleMods.lnk" >> "%VBS_SCRIPT%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBS_SCRIPT%"
echo oLink.TargetPath = "%INSTALL_DIR%\%SOURCE_FILE%" >> "%VBS_SCRIPT%"
echo oLink.WorkingDirectory = "%INSTALL_DIR%" >> "%VBS_SCRIPT%"
echo oLink.Save >> "%VBS_SCRIPT%"
cscript /nologo "%VBS_SCRIPT%" >nul
del "%VBS_SCRIPT%"
ping 127.0.0.1 -n 2 >nul

echo.
echo %CLR_GREEN%[Success] Installation completed successfully.%CLR_RESET%
echo.
echo You can now run the tool by double-clicking the desktop shortcut, 
echo or by opening a new Command Prompt / PowerShell window and typing:
echo   %CLR_YELLOW%rolemods%CLR_RESET%
echo.
pause
endlocal
exit /b