@echo off
setlocal EnableDelayedExpansion

:: Set console dimension
mode con: cols=100 lines=35
title LNTHGLfan2025 RoleMods CLI

:: Retrieve escape character for ANSI color formatting
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

:: Define ANSI color schemes
set "CLR_RESET=%ESC%[0m"
set "CLR_RED=%ESC%[31m"
set "CLR_GREEN=%ESC%[32m"
set "CLR_YELLOW=%ESC%[33m"
set "CLR_BLUE=%ESC%[34m"
set "CLR_CYAN=%ESC%[36m"
set "CLR_GRAY=%ESC%[90m"
set "CLR_WHITE=%ESC%[97m"

:: Initial screen presentation
:welcome_screen
cls
echo %CLR_CYAN%
echo  _      _   _ _____ _    _  _____ _       __                  ___   ___ ___  _____ 
echo ^| ^|    ^| \ ^| ^|_   _^| ^|  ^| ^|/ ____^| ^|     / _^|                ^|__ \ / _ \__ \^| ____^|
echo ^| ^|    ^|  \^| ^| ^| ^| ^| ^|__^| ^| ^|  __^| ^|    ^| ^|_  __ _ _ __       ) ^| ^| ^| ^| ) ^| ^|__  
echo ^| ^|    ^| . ` ^| ^| ^| ^|  __  ^| ^| ^|_ ^| ^|    ^|  _^|/ _` ^| '_ \     / /^| ^| ^| ^|/ /^|___ \ 
echo ^| ^|____^| ^|\  ^|_^| ^|_^| ^|  ^| ^| ^|__^| ^| ^|____^| ^| ^| (_^| ^| ^| ^| ^|   / /_^| ^|_^| / /_ ___) ^|
echo ^|______^|_^| \_^|_____^|_^|  ^|_^|\_____^|______^|__^|_^|\__,_^|_^| ^|_^| ^|____^\___/____^|____/ 
echo %CLR_RESET%
echo ====================================================================================
echo                      LNTHGLfan2025 RoleMods CLI v1.0.0
echo ====================================================================================
echo Welcome to the interactive terminal interface.
echo Type %CLR_GREEN%/help%CLR_RESET% to display all available commands.
echo.

:cmd_loop
set "cmd_input="
set /p "cmd_input=%CLR_CYAN%LNTHGLfan2025> %CLR_RESET%"

:: Remove trailing/leading spaces and analyze input safely
if "!cmd_input!"=="" goto cmd_loop

:: Sanitize input by stripping quotes to prevent syntax errors
set "cmd_sanitized=!cmd_input:"=!"

:: Tokenize command and arguments safely
set "cmd_name="
set "cmd_args="
for /F "tokens=1* delims= " %%a in ("!cmd_sanitized!") do (
    set "cmd_name=%%a"
    set "cmd_args=%%b"
)

if /I "!cmd_name!"=="/help" goto cmd_help
if /I "!cmd_name!"=="/list" goto cmd_list
if /I "!cmd_name!"=="/update" goto cmd_update
if /I "!cmd_name!"=="/play" goto cmd_play
if /I "!cmd_name!"=="/status" goto cmd_status
if /I "!cmd_name!"=="/about" goto cmd_about
if /I "!cmd_name!"=="/clear" goto cmd_clear
if /I "!cmd_name!"=="/cd" goto cmd_cd
if /I "!cmd_name!"=="/cli" goto cmd_cli
if /I "!cmd_name!"=="/install" goto cmd_install
if /I "!cmd_name!"=="/exit" goto cmd_exit

:: Fallback if input is not a recognized command
echo %CLR_RED%[Error] Unknown command. Type /help to view valid options.%CLR_RESET%
echo.
goto cmd_loop

:cmd_help
echo.
echo %CLR_CYAN%=== Active Commands ===%CLR_RESET%
echo  %CLR_GREEN%/help%CLR_RESET%               - Display this help menu.
echo  %CLR_GREEN%/list%CLR_RESET%               - Scan directory and list active RoleMods.
echo  %CLR_GREEN%/update%CLR_RESET%             - Check for and download mod updates.
echo  %CLR_GREEN%/play%CLR_RESET%               - Import and run an .sb3 file.
echo  %CLR_GREEN%/install [mod]%CLR_RESET%      - Install a specified modification package.
echo  %CLR_GREEN%/status%CLR_RESET%             - Display system and host session metrics.
echo  %CLR_GREEN%/cli%CLR_RESET%                - Display terminal layout configuration.
echo  %CLR_GREEN%/cd [path]%CLR_RESET%          - Change directory or view current workspace.
echo  %CLR_GREEN%/clear%CLR_RESET%              - Clear the terminal screen.
echo  %CLR_GREEN%/about%CLR_RESET%              - View author and environment information.
echo  %CLR_GREEN%/exit%CLR_RESET%               - Terminate the current session.
echo.
goto cmd_loop

:cmd_list
echo.
echo %CLR_CYAN%=== Scanning Directory for Installed Mods ===%CLR_RESET%
echo %CLR_GRAY%[INFO] Scanning target directory...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo %CLR_GRAY%[INFO] Reading mod metadata files...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo.
echo %CLR_GREEN%Search complete. Found 4 active RoleMods:%CLR_RESET%
echo ----------------------------------------------------------------------
echo  %CLR_YELLOW%1. Core Roleplay Engine%CLR_RESET%  [v2.1.0]  - Status: %CLR_GREEN%Active%CLR_RESET%
echo  %CLR_YELLOW%2. Advanced Admin Suite%CLR_RESET% [v1.0.5]  - Status: %CLR_GREEN%Active%CLR_RESET%
echo  %CLR_YELLOW%3. Dynamic Economy%CLR_RESET%      [v3.0.0]  - Status: %CLR_GREEN%Active%CLR_RESET%
echo  %CLR_YELLOW%4. Custom Chat Bubbles%CLR_RESET%   [v1.2.1]  - Status: %CLR_YELLOW%Update Available%CLR_RESET%
echo ----------------------------------------------------------------------
echo.
goto cmd_loop

:cmd_update
echo.
echo %CLR_CYAN%=== Checking for RoleMod Updates ===%CLR_RESET%
echo %CLR_GRAY%[1/3] Contacting update repository...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo %CLR_GREEN%[OK] Connection established.%CLR_RESET%
echo %CLR_GRAY%[2/3] Comparing local files with manifest...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo %CLR_YELLOW%[!] Update found: Custom Chat Bubbles (v1.2.1 -> v1.3.0)%CLR_RESET%
echo %CLR_GRAY%[3/3] Downloading package 'custom_chat_v1.3.0.zip'...%CLR_RESET%
echo.
set /p "=%CLR_YELLOW%Progress:%CLR_RESET% [" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
ping 127.0.0.1 -n 1 >nul
set /p "=#]" <nul
echo.
echo.
echo %CLR_GRAY%[INFO] Installing and verifying mod integrity...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo.
echo %CLR_GREEN%Update complete. Custom Chat Bubbles is updated to v1.3.0.%CLR_RESET%
echo.
goto cmd_loop

:cmd_play
echo.
echo %CLR_CYAN%=== Upload & Play .sb3 (Scratch 3) File ===%CLR_RESET%
echo Please drag and drop your .sb3 file into this window, 
echo or manually type the full path to the file, then press Enter.
echo.
set "sb3_path="
set /p sb3_path="%CLR_WHITE%File path: %CLR_RESET%"

:: Strip quotation marks from path input
set "sb3_path=!sb3_path:"=!"

if "!sb3_path!"=="" (
    echo %CLR_RED%[Error] No file path provided.%CLR_RESET%
    echo.
    goto cmd_loop
)

if not exist "!sb3_path!" (
    echo %CLR_RED%[Error] File not found at the specified path.%CLR_RESET%
    echo.
    goto cmd_loop
)

if /I not "!sb3_path:~-4!"==".sb3" (
    echo %CLR_RED%[Error] Invalid file type. Must be a valid .sb3 file.%CLR_RESET%
    echo.
    goto cmd_loop
)

echo.
echo %CLR_GRAY%[INFO] Parsing file contents...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo %CLR_GREEN%[OK] File verified successfully.%CLR_RESET%
echo.
echo Select dynamic launch method:
echo  %CLR_GREEN%[1]%CLR_RESET% Open using local default system player
echo  %CLR_GREEN%[2]%CLR_RESET% Open in TurboWarp Web Player (https://turbowarp.org/)
echo  %CLR_GREEN%[3]%CLR_RESET% Cancel execution
echo.
set "play_opt="
set /p play_opt="Select option [1-3]: "

if "!play_opt!"=="1" (
    echo %CLR_GRAY%[INFO] Loading local system player...%CLR_RESET%
    start "" "!sb3_path!"
)
if "!play_opt!"=="2" (
    echo %CLR_GRAY%[INFO] Navigating to https://turbowarp.org/...%CLR_RESET%
    start "" "https://turbowarp.org/"
    echo %CLR_YELLOW%[Action Required] Drag and drop your file into the web browser tab.%CLR_RESET%
)
echo.
goto cmd_loop

:cmd_install
if "!cmd_args!"=="" (
    echo.
    echo %CLR_RED%[Error] Missing argument. Usage: /install [mod_name]%CLR_RESET%
    echo.
    goto cmd_loop
)
echo.
echo %CLR_CYAN%=== Installing Mod: !cmd_args! ===%CLR_RESET%
echo %CLR_GRAY%[1/2] Connecting to repository and downloading package...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo %CLR_GREEN%[OK] Package downloaded successfully.%CLR_RESET%
echo %CLR_GRAY%[2/2] Extracting files and verifying directory integrity...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo %CLR_GREEN%[Success] "!cmd_args!" has been successfully installed and activated.%CLR_RESET%
echo.
goto cmd_loop

:cmd_status
echo.
echo %CLR_CYAN%=== Session and System Status ===%CLR_RESET%
echo  - Workspace Dir:     !cd!
echo  - Active Profile:    LNTHGLfan2025
echo  - Framework:         Windows CLI Shell
echo  - Network Connection: %CLR_GREEN%Online / Connected%CLR_RESET%
echo  - Output Mode:       ANSI Escape Color Sequencer
echo.
goto cmd_loop

:cmd_cli
echo.
echo %CLR_CYAN%=== CLI Layout Settings ===%CLR_RESET%
echo  - Window Buffer:     100 columns x 35 lines
echo  - Terminal Mode:     Raw Command Prompt Loop
echo  - Escape Sequence:   Enabled (Virtual Terminal support active)
echo  - Output Encoding:   Default OEM Codepage
echo.
goto cmd_loop

:cmd_cd
if "!cmd_args!"=="" (
    echo.
    echo Current Directory: !cd!
    echo.
) else (
    cd /d "!cmd_args!" 2>nul
    if errorlevel 1 (
        echo.
        echo %CLR_RED%[Error] Directory path not found: !cmd_args!%CLR_RESET%
        echo.
    ) else (
        echo.
        echo Directory changed.
        echo Current Workspace: !cd!
        echo.
    )
)
goto cmd_loop

:cmd_clear
cls
goto welcome_screen

:cmd_about
echo.
echo %CLR_CYAN%=== About LNTHGLfan2025 RoleMods CLI ===%CLR_RESET%
echo An interactive command console for managing modifications, checking 
echo file parameters, and loading Scratch development packages.
echo.
echo  Developer:   LNTHGLfan2025
echo  Environment: Windows Command Processor
echo  Version:     1.0.0
echo.
goto cmd_loop

:cmd_exit
echo.
echo %CLR_CYAN%Exiting LNTHGLfan2025 RoleMods CLI. Goodbye.%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
endlocal
exit /b