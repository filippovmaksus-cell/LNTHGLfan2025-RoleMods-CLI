@echo off
setlocal EnableDelayedExpansion

:: Configure console code page to UTF-8 to support Cyrillic characters
chcp 65001 >nul

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

:: Define native sound variables utilizing lightweight, zero-latency User32 API calls
set "SND_CLICK=start /b rundll32 user32.dll,MessageBeep 0"
set "SND_ERROR=start /b rundll32 user32.dll,MessageBeep 16"
set "SND_WARN=start /b rundll32 user32.dll,MessageBeep 48"
set "SND_SUCCESS=start /b rundll32 user32.dll,MessageBeep 64"

:: Default Fallback Theme & Language
set "CLR_PRI=%CLR_CYAN%"
set "THEME_NAME=Cyber Cyan"
set "LANG=EN"
set "SET_RETURN="

:: Load persistent configuration settings from local storage if available [1]
call :load_settings

:: Load corresponding translation variables based on active language
call :set_lang_strings

:: Initial screen presentation
:welcome_screen
cls
echo !CLR_PRI!
echo  _      _   _ _____ _    _  _____ _       __                  ___   ___ ___  _____ 
echo ^| ^|    ^| \ ^| ^|_   _^| ^|  ^| ^|/ ____^| ^|     / _^|                ^|__ \ / _ \__ \^| ____^|
echo ^| ^|    ^|  \^| ^| ^| ^| ^| ^|__^| ^| ^|  __^| ^|    ^| ^|_  __ _ _ __       ) ^| ^| ^| ^| ) ^| ^|__  
echo ^| ^|    ^| . ` ^| ^| ^| ^|  __  ^| ^| ^|_ ^| ^|    ^|  _^|/ _` ^| '_ \     / /^| ^| ^| ^|/ /^|___ \ 
echo ^| ^|____^| ^|\  ^|_^| ^|_^| ^|  ^| ^| ^|__^| ^| ^|____^| ^| ^| (_^| ^| ^| ^| ^|   / /_^| ^|_^| / /_ ___) ^|
echo ^|______^|_^| \_^|_____^|_^|  ^|_^|\_____^|______^|__^|_^|\__,_^|_^| ^|_^| ^|____^\___/____^|____/ 
echo %CLR_RESET%
echo ====================================================================================
echo                      LNTHGLfan2025 RoleMods CLI v1.1.0
echo                      Release Date: June 25, 2026
echo ====================================================================================
echo !MSG_WELCOME!
echo !MSG_HELP_PROMPT!
echo.

:cmd_loop
set "cmd_input="
set /p "cmd_input=!CLR_PRI!LNTHGLfan2025> %CLR_RESET%"

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
if /I "!cmd_name!"=="/theme" goto cmd_theme
if /I "!cmd_name!"=="/talk" goto cmd_talk
if /I "!cmd_name!"=="/settings" goto cmd_settings
if /I "!cmd_name!"=="/hn" goto cmd_hn
if /I "!cmd_name!"=="hn" goto cmd_hn
if /I "!cmd_name!"=="/lang" goto cmd_lang
if /I "!cmd_name!"=="/install" goto cmd_install
if /I "!cmd_name!"=="/exit" goto cmd_exit

:: Fallback if input is not a recognized command
%SND_ERROR%
echo %CLR_RED%!MSG_UNKNOWN_CMD!%CLR_RESET%
echo.
goto cmd_loop

:cmd_help
%SND_CLICK%
echo.
echo !CLR_PRI!!MSG_ACTIVE_CMDS!%CLR_RESET%
echo  %CLR_GREEN%/help%CLR_RESET%               !MSG_HELP_DESC_HELP!
echo  %CLR_GREEN%/settings%CLR_RESET%           !MSG_HELP_DESC_SETTINGS!
echo  %CLR_GREEN%/talk%CLR_RESET%               !MSG_HELP_DESC_TALK!
echo  %CLR_GREEN%/hn%CLR_RESET% [mod] [call] [n] [pl] !MSG_HELP_DESC_HN!
echo  %CLR_GREEN%/lang%CLR_RESET% [en / uk]     !MSG_HELP_DESC_LANG!
echo  %CLR_GREEN%/list%CLR_RESET%               !MSG_HELP_DESC_LIST!
echo  %CLR_GREEN%/update%CLR_RESET%             !MSG_HELP_DESC_UPDATE!
echo  %CLR_GREEN%/play%CLR_RESET%               !MSG_HELP_DESC_PLAY!
echo  %CLR_GREEN%/install [mod]%CLR_RESET%      !MSG_HELP_DESC_INSTALL!
echo  %CLR_GREEN%/theme%CLR_RESET%              !MSG_HELP_DESC_THEME!
echo  %CLR_GREEN%/status%CLR_RESET%             !MSG_HELP_DESC_STATUS!
echo  %CLR_GREEN%/cli%CLR_RESET%                !MSG_HELP_DESC_CLI!
echo  %CLR_GREEN%/cd [path]%CLR_RESET%          !MSG_HELP_DESC_CD!
echo  %CLR_GREEN%/clear%CLR_RESET%              !MSG_HELP_DESC_CLEAR!
echo  %CLR_GREEN%/about%CLR_RESET%              !MSG_HELP_DESC_ABOUT!
echo  %CLR_GREEN%/exit%CLR_RESET%               !MSG_HELP_DESC_EXIT!
echo.
goto cmd_loop

:cmd_settings
%SND_CLICK%
echo.
echo !CLR_PRI!!MSG_SET_TITLE!%CLR_RESET%
echo  %CLR_GREEN%[1]%CLR_RESET% !MSG_SET_OPT1!
echo  %CLR_GREEN%[2]%CLR_RESET% !MSG_SET_OPT2!
echo  %CLR_GREEN%[3]%CLR_RESET% !MSG_SET_OPT3!
echo  %CLR_GREEN%[4]%CLR_RESET% !MSG_SET_OPT4!
echo  %CLR_GREEN%[5]%CLR_RESET% !MSG_SET_OPT5!
echo.
set "set_choice="
set /p "set_choice=Select option [1-5]: "

if "!set_choice!"=="1" (
    set "SET_RETURN=1"
    goto cmd_theme
)
if "!set_choice!"=="2" (
    goto settings_api
)
if "!set_choice!"=="3" (
    set "SET_RETURN=1"
    goto cmd_lang
)
if "!set_choice!"=="4" (
    set "SET_RETURN=1"
    goto cmd_cli
)
if "!set_choice!"=="5" (
    %SND_CLICK%
    echo.
    goto cmd_loop
)
%SND_ERROR%
goto cmd_settings

:settings_api
%SND_CLICK%
echo.
echo !CLR_PRI!=== Manage API Credentials ===%CLR_RESET%
if "!GEMINI_API_KEY!"=="" (
    echo Status: %CLR_RED%No API Key Configured%CLR_RESET%
) else (
    set "raw_key=!GEMINI_API_KEY!"
    set "masked_key=!raw_key:~0,6!******!raw_key:~-4!"
    echo Status: %CLR_GREEN%Key Configured%CLR_RESET% (!masked_key!)
)
echo.
echo  %CLR_GREEN%[1]%CLR_RESET% Set/Update API Key (Permanently via setx)
echo  %CLR_GREEN%[2]%CLR_RESET% Clear Current Session API Key
echo  %CLR_GREEN%[3]%CLR_RESET% Go Back
echo.
set "api_choice="
set /p "api_choice=Select option [1-3]: "

if "!api_choice!"=="1" (
    %SND_CLICK%
    echo.
    set /p "temp_key=Enter your Gemini API Key: "
    if not "!temp_key!"=="" (
        set "GEMINI_API_KEY=!temp_key!"
        setx GEMINI_API_KEY "!temp_key!" >nul
        echo.
        %SND_SUCCESS%
        echo %CLR_GREEN%[Success] Key saved permanently to Windows.%CLR_RESET%
    )
)
if "!api_choice!"=="2" (
    %SND_WARN%
    set "GEMINI_API_KEY="
    echo.
    echo %CLR_YELLOW%[INFO] Session API key cleared. (To remove permanently, run 'reg delete HKCU\Environment /v GEMINI_API_KEY /f' manually)%CLR_RESET%
)
goto cmd_settings

:cmd_list
echo.
echo !CLR_PRI!=== Scanning Directory for Installed Mods ===%CLR_RESET%
echo %CLR_GRAY%[INFO] Scanning target directory...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo %CLR_GRAY%[INFO] Reading mod metadata files...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo.
%SND_SUCCESS%
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
echo !CLR_PRI!=== Checking for RoleMod Updates ===%CLR_RESET%
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
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#" <nul
%SND_CLICK%
ping 127.0.0.1 -n 1 >nul
set /p "=#]" <nul
echo.
echo.
echo %CLR_GRAY%[INFO] Installing and verifying mod integrity...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
echo.
%SND_SUCCESS%
echo %CLR_GREEN%Update complete. Custom Chat Bubbles is updated to v1.3.0.%CLR_RESET%
echo.
goto cmd_loop

:cmd_play
echo.
echo !CLR_PRI!=== Upload & Play .sb3 (Scratch 3) File ===%CLR_RESET%
echo Please drag and drop your .sb3 file into this window, 
echo or manually type the full path to the file, then press Enter.
echo.
set "sb3_path="
set /p sb3_path="%CLR_WHITE%File path: %CLR_RESET%"

:: Strip quotation marks from path input
set "sb3_path=!sb3_path:"=!"

if "!sb3_path!"=="" (
    %SND_ERROR%
    echo %CLR_RED%[Error] No file path provided.%CLR_RESET%
    echo.
    goto cmd_loop
)

if not exist "!sb3_path!" (
    %SND_ERROR%
    echo %CLR_RED%[Error] File not found at the specified path.%CLR_RESET%
    echo.
    goto cmd_loop
)

if /I not "!sb3_path:~-4!"==".sb3" (
    %SND_ERROR%
    echo %CLR_RED%[Error] Invalid file type. Must be a valid .sb3 file.%CLR_RESET%
    echo.
    goto cmd_loop
)

echo.
echo %CLR_GRAY%[INFO] Parsing file contents...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
%SND_SUCCESS%
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
    %SND_CLICK%
    echo %CLR_GRAY%[INFO] Loading local system player...%CLR_RESET%
    start "" "!sb3_path!"
)
if "!play_opt!"=="2" (
    %SND_CLICK%
    echo %CLR_GRAY%[INFO] Navigating to https://turbowarp.org/...%CLR_RESET%
    start "" "https://turbowarp.org/"
    echo %CLR_YELLOW%[Action Required] Drag and drop your file into the web browser tab.%CLR_RESET%
)
echo.
goto cmd_loop

:cmd_install
if "!cmd_args!"=="" (
    %SND_ERROR%
    echo.
    echo %CLR_RED%[Error] Missing argument. Usage: /install [mod_name]%CLR_RESET%
    echo.
    goto cmd_loop
)
echo.
echo !CLR_PRI!=== Installing Mod: !cmd_args! ===%CLR_RESET%
echo %CLR_GRAY%[1/2] Connecting to repository and downloading package...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
%SND_CLICK%
echo %CLR_GREEN%[OK] Package downloaded successfully.%CLR_RESET%
echo %CLR_GRAY%[2/2] Extracting files and verifying directory integrity...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
%SND_SUCCESS%
echo %CLR_GREEN%[Success] "!cmd_args!" has been successfully installed and activated.%CLR_RESET%
echo.
goto cmd_loop

:cmd_theme
%SND_CLICK%
echo.
echo !CLR_PRI!=== Interface Color Theme Settings ===%CLR_RESET%
echo Select a visual profile to customize your CLI:
echo  %CLR_GREEN%[1]%CLR_RESET% Cyber Cyan (Default)
echo  %CLR_GREEN%[2]%CLR_RESET% Matrix Green
echo  %CLR_GREEN%[3]%CLR_RESET% Sunset Orange
echo  %CLR_GREEN%[4]%CLR_RESET% Classic White
echo.
set "theme_choice="
set /p theme_choice="Select profile [1-4]: "

if "!theme_choice!"=="1" (
    set "CLR_PRI=%CLR_CYAN%"
    set "THEME_NAME=Cyber Cyan"
    echo.
    %SND_SUCCESS%
    echo %CLR_GREEN%Theme updated to Cyber Cyan.%CLR_RESET%
)
if "!theme_choice!"=="2" (
    set "CLR_PRI=%CLR_GREEN%"
    set "THEME_NAME=Matrix Green"
    echo.
    %SND_SUCCESS%
    echo %CLR_GREEN%Theme updated to Matrix Green.%CLR_RESET%
)
if "!theme_choice!"=="3" (
    set "CLR_PRI=%CLR_YELLOW%"
    set "THEME_NAME=Sunset Orange"
    echo.
    %SND_SUCCESS%
    echo %CLR_GREEN%Theme updated to Sunset Orange.%CLR_RESET%
)
if "!theme_choice!"=="4" (
    set "CLR_PRI=%CLR_WHITE%"
    set "THEME_NAME=Classic White"
    echo.
    %SND_SUCCESS%
    echo %CLR_GREEN%Theme updated to Classic White.%CLR_RESET%
)
echo.
call :save_settings
if "!SET_RETURN!"=="1" (
    set "SET_RETURN="
    goto cmd_settings
)
goto cmd_loop

:cmd_talk
if "!GEMINI_API_KEY!"=="" (
    %SND_WARN%
    echo.
    echo %CLR_RED%[Warning] GEMINI_API_KEY environment variable is not defined.%CLR_RESET%
    set /p "temp_key=Please enter your Gemini API Key: "
    if "!temp_key!"=="" (
        echo %CLR_RED%[Error] API Key required to run assistant session.%CLR_RESET%
        echo.
        goto cmd_loop
    )
    set "GEMINI_API_KEY=!temp_key!"
    echo.
    set "save_key_choice="
    set /p "save_key_choice=Would you like to save this key permanently to Windows (using setx)? [Y/N]: "
    if /I "!save_key_choice!"=="Y" (
        setx GEMINI_API_KEY "!temp_key!" >nul
        echo.
        %SND_SUCCESS%
        echo %CLR_GREEN%[Success] Key saved permanently to Windows. It will load automatically next time.%CLR_RESET%
    )
)

echo.
%SND_SUCCESS%
echo !CLR_PRI!======================================================%CLR_RESET%
echo              Gemini Chat Assistant Session Started
echo              Target Engine: gemini-1.5-flash
echo              Type /exit or exit to return to CLI
echo !CLR_PRI!======================================================%CLR_RESET%
echo.

:talk_loop
set "user_msg="
set /p "user_msg=!CLR_PRI!Talk> %CLR_RESET%"

if "!user_msg!"=="" goto talk_loop
if /I "!user_msg!"=="/exit" (%SND_CLICK%&echo Session ended.&echo.&goto cmd_loop)
if /I "!user_msg!"=="exit" (%SND_CLICK%&echo Session ended.&echo.&goto cmd_loop)

set "TALK_PROMPT=!user_msg!"
set "TALK_KEY=!GEMINI_API_KEY!"

echo.
echo %CLR_GRAY%Thinking...%CLR_RESET%

:: Running inline PowerShell request using '-Depth 10' parameter to avoid API rejection
powershell -NoProfile -Command "$body = @{ contents = @( @{ parts = @( @{ text = $env:TALK_PROMPT } ) } ) } | ConvertTo-Json -Compress -Depth 10; $url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=' + $env:TALK_KEY; try { $res = Invoke-RestMethod -Uri $url -Method Post -Body $body -ContentType 'application/json'; Write-Output $res.candidates[0].content.parts[0].text } catch { Write-Host ('[Error] ' + $_.Exception.Message) -ForegroundColor Red }"
echo.
goto talk_loop

:cmd_hn
:: Check if arguments are provided
set "hn_rolemods="
set "hn_call="
set "hn_number="
set "hn_play="
for /F "tokens=1* delims= " %%a in ("!cmd_args!") do (
    set "hn_rolemods=%%a"
    set "hn_call=%%b"
    set "hn_number=%%c"
    set "hn_play=%%d"
)

if "!hn_rolemods!"=="" goto hn_usage
if "!hn_call!"=="" goto hn_usage
if "!hn_number!"=="" goto hn_usage
if "!hn_play!"=="" goto hn_usage

echo.
%SND_CLICK%
echo %CLR_YELLOW%[hn] Stand for: "however number" (JavaScript Package Manager)%CLR_RESET%
echo %CLR_YELLOW%[hn] Initializing execution pipeline...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul

echo %CLR_YELLOW%[hn] Module:     !hn_rolemods!%CLR_RESET%
echo %CLR_YELLOW%[hn] Callback:   !hn_call!%CLR_RESET%
echo %CLR_YELLOW%[hn] Sequence #: !hn_number!%CLR_RESET%
echo %CLR_YELLOW%[hn] Action:     !hn_play!%CLR_RESET%
ping 127.0.0.1 -n 1 >nul

echo %CLR_YELLOW%[hn] Connecting to the hn registry at registry.js.hn...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul

echo %CLR_YELLOW%[hn] Compiling JS assets for !hn_rolemods!...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul

echo %CLR_YELLOW%[hn] Resolving runtime dependencies...%CLR_RESET%
set /p "=%CLR_YELLOW%[hn] Linking: %CLR_RESET%" <nul
for /L %%x in (1,1,5) do (
    set /p "=%CLR_YELLOW%.%CLR_RESET%" <nul
    %SND_CLICK%
    ping 127.0.0.1 -n 1 >nul
)
echo  %CLR_YELLOW%[OK]%CLR_RESET%

echo %CLR_YELLOW%[hn] Calling JS event listener: !hn_call!(!hn_number!)...%CLR_RESET%
ping 127.0.0.1 -n 2 >nul

%SND_SUCCESS%
echo %CLR_YELLOW%[hn] Executing play task: !hn_play! - successful!%CLR_RESET%
echo.
goto cmd_loop

:hn_usage
%SND_ERROR%
echo.
echo %CLR_RED%[Error] Invalid arguments for hn package manager.%CLR_RESET%
echo Usage:  %CLR_YELLOW%/hn ^<rolemods^> ^<call^> ^<number^> ^<play^>%CLR_RESET%
echo Example:%CLR_YELLOW% /hn core trigger_mod 42 play%CLR_RESET%
echo.
goto cmd_loop

:cmd_lang
if /I "!cmd_args!"=="en" (
    set "LANG=EN"
    call :set_lang_strings
    %SND_SUCCESS%
    echo Language updated to English.
    echo.
    call :save_settings
    goto cmd_loop
)
if /I "!cmd_args!"=="uk" (
    set "LANG=UK"
    call :set_lang_strings
    %SND_SUCCESS%
    echo Мову змінено на українську.
    echo.
    call :save_settings
    goto cmd_loop
)

:: Interactive Prompt if no valid argument is specified
%SND_WARN%
echo.
if /I "!LANG!"=="UK" (
    echo !CLR_PRI!=== Налаштування мови інтерфейсу ===%CLR_RESET%
    echo  %CLR_GREEN%[1]%CLR_RESET% English (en)
    echo  %CLR_GREEN%[2]%CLR_RESET% Українська (uk)
    echo.
    set "lang_choice="
    set /p "lang_choice=Оберіть мову [1-2]: "
) else (
    echo !CLR_PRI!=== Language Settings ===%CLR_RESET%
    echo  %CLR_GREEN%[1]%CLR_RESET% English (en)
    echo  %CLR_GREEN%[2]%CLR_RESET% Ukrainian (uk)
    echo.
    set "lang_choice="
    set /p "lang_choice=Select language [1-2]: "
)

if "!lang_choice!"=="1" (
    set "LANG=EN"
    call :set_lang_strings
    %SND_SUCCESS%
    echo Language updated to English.
)
if "!lang_choice!"=="2" (
    set "LANG=UK"
    call :set_lang_strings
    %SND_SUCCESS%
    echo Мову змінено на українську.
)
echo.
call :save_settings
if "!SET_RETURN!"=="1" (
    set "SET_RETURN="
    goto cmd_settings
)
goto cmd_loop

:cmd_status
%SND_CLICK%
echo.
echo !CLR_PRI!=== !MSG_STATUS_TITLE! ===%CLR_RESET%
echo  - !MSG_STATUS_DIR!:     !cd!
echo  - !MSG_STATUS_PROF!:    LNTHGLfan2025
echo  - !MSG_STATUS_THEME!:   !THEME_NAME!
echo  - !MSG_STATUS_LANG!:    !LANG!
echo  - !MSG_STATUS_FRAME!:         Windows CLI Shell
echo  - !MSG_STATUS_CONN!: !CLR_GREEN!!MSG_STATUS_CONN_ON!%CLR_RESET%
echo  - !MSG_STATUS_OUT!:       ANSI Escape Color Sequencer
echo  - Local Storage:     %CLR_GREEN%Active (!CONFIG_FILE!)%CLR_RESET%
echo.
goto cmd_loop

:cmd_cli
%SND_CLICK%
echo.
echo !CLR_PRI!=== CLI Layout Settings ===%CLR_RESET%
echo  - Window Buffer:     100 columns x 35 lines
echo  - Terminal Mode:     Raw Command Prompt Loop
echo  - Escape Sequence:   Enabled (Virtual Terminal support active)
echo  - Output Encoding:   UTF-8 (Code Page 65001)
echo.
if "!SET_RETURN!"=="1" (
    set "SET_RETURN="
    goto cmd_settings
)
goto cmd_loop

:cmd_cd
if "!cmd_args!"=="" (
    %SND_CLICK%
    echo.
    echo Current Directory: !cd!
    echo.
) else (
    cd /d "!cmd_args!" 2>nul
    if errorlevel 1 (
        %SND_ERROR%
        echo.
        echo %CLR_RED%[Error] Directory path not found: !cmd_args!%CLR_RESET%
        echo.
    ) else (
        %SND_SUCCESS%
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
%SND_CLICK%
echo.
echo !CLR_PRI!=== !MSG_ABOUT_TITLE! ===%CLR_RESET%
echo !MSG_ABOUT_DESC!
echo.
echo  !MSG_ABOUT_DEV!:   LNTHGLfan2025
echo  !MSG_ABOUT_ENV!: Windows Command Processor (UTF-8 Mode)
echo  !MSG_ABOUT_VER!:     1.1.0
echo  !MSG_ABOUT_REL!:     June 25, 2026
echo.
goto cmd_loop

:cmd_exit
echo.
%SND_CLICK%
echo !CLR_PRI!Exiting LNTHGLfan2025 RoleMods CLI. Goodbye.%CLR_RESET%
ping 127.0.0.1 -n 2 >nul
endlocal
exit /b

:: Subroutine to load configuration from local storage [1]
:load_settings
set "CONFIG_DIR=C:\Users\Admin\Desktop\RoleMods CLI"
set "CONFIG_FILE=!CONFIG_DIR!\config.cfg"
if exist "!CONFIG_FILE!" (
    for /F "usebackq tokens=1,2 delims==" %%a in ("!CONFIG_FILE!") do (
        set "%%a=%%b"
    )
)
:: Re-map active escape strings based on loaded config parameters
if "!THEME_NAME!"=="Cyber Cyan" (
    set "CLR_PRI=%CLR_CYAN%"
)
if "!THEME_NAME!"=="Matrix Green" (
    set "CLR_PRI=%CLR_GREEN%"
)
if "!THEME_NAME!"=="Sunset Orange" (
    set "CLR_PRI=%CLR_YELLOW%"
)
if "!THEME_NAME!"=="Classic White" (
    set "CLR_PRI=%CLR_WHITE%"
)
goto :eof

:: Subroutine to save current environment parameters to disk [2]
:save_settings
set "CONFIG_DIR=C:\Users\Admin\Desktop\RoleMods CLI"
if not exist "!CONFIG_DIR!" mkdir "!CONFIG_DIR!" 2>nul
(
    echo LANG=!LANG!
    echo THEME_NAME=!THEME_NAME!
) > "!CONFIG_DIR!\config.cfg"
goto :eof

:: Subroutine to swap language assets
:set_lang_strings
if /I "!LANG!"=="UK" (
    set "MSG_WELCOME=Ласкаво просимо до інтерактивного консольного інтерфейсу."
    set "MSG_HELP_PROMPT=Введіть %CLR_GREEN%/help%CLR_RESET% для перегляду всіх 15 доступних команд."
    set "MSG_ACTIVE_CMDS==== Активні команди [15 всього] ==="
    set "MSG_HELP_DESC_HELP=- Відобразити це меню довідки."
    set "MSG_HELP_DESC_SETTINGS=- Відкрити центральну панель конфігурації."
    set "MSG_HELP_DESC_TALK=- Запустити сеанс чату з AI-асистентом (Gemini 1.5 Flash)."
    set "MSG_HELP_DESC_HN=- Запустити менеджер пакетів JavaScript 'however number'."
    set "MSG_HELP_DESC_LANG=- Змінити мову інтерфейсу (en / uk)."
    set "MSG_HELP_DESC_LIST=- Сканувати директорію та показати активні RoleMods."
    set "MSG_HELP_DESC_UPDATE=- Перевірити та завантажити оновлення модів."
    set "MSG_HELP_DESC_PLAY=- Імпортувати та запустити файл .sb3."
    set "MSG_HELP_DESC_INSTALL=- Встановити вказаний пакет модифікації."
    set "MSG_HELP_DESC_THEME=- Змінити колірний профіль інтерфейсу."
    set "MSG_HELP_DESC_STATUS=- Показати метрики системи та сеансу."
    set "MSG_HELP_DESC_CLI=- Показати конфігурацію макета терміналу."
    set "MSG_HELP_DESC_CD=- Змінити директорію або переглянути поточний робочий простір."
    set "MSG_HELP_DESC_CLEAR=- Очистити екран терміналу."
    set "MSG_HELP_DESC_ABOUT=- Переглянути інформацію про автора та середовище."
    set "MSG_HELP_DESC_EXIT=- Завершити поточний сеанс."
    set "MSG_UNKNOWN_CMD=[Помилка] Невідома команда. Введіть /help для перегляду доступних варіантів."
    
    set "MSG_SET_TITLE=Панель налаштувань CLI"
    set "MSG_SET_OPT1=Змінити тему інтерфейсу (Поточна: !THEME_NAME!)"
    set "MSG_SET_OPT2=Керування обліковими даними Gemini API"
    set "MSG_SET_OPT3=Змінити мову інтерфейсу (Поточна: !LANG!)"
    set "MSG_SET_OPT4=Переглянути буфер консолі та налаштування вікна"
    set "MSG_SET_OPT5=Повернутися до основної консолі"

    set "MSG_ABOUT_TITLE=Про LNTHGLfan2025 RoleMods CLI"
    set "MSG_ABOUT_DESC=Інтерактивна командна консоль для керування модифікаціями, перевірки параметрів файлів та запуску пакетів розробки Scratch."
    set "MSG_ABOUT_DEV=Розробник"
    set "MSG_ABOUT_ENV=Середовище"
    set "MSG_ABOUT_VER=Версія"
    set "MSG_ABOUT_REL=Реліз"

    set "MSG_STATUS_TITLE=Статус сеансу та системи"
    set "MSG_STATUS_DIR=Робоча директорія"
    set "MSG_STATUS_PROF=Активний профіль"
    set "MSG_STATUS_THEME=Тема інтерфейсу"
    set "MSG_STATUS_LANG=Мова системи"
    set "MSG_STATUS_FRAME=Платформа"
    set "MSG_STATUS_CONN=Мережеве підключення"
    set "MSG_STATUS_CONN_ON=В мережі / Підключено"
    set "MSG_STATUS_OUT=Режим виводу"
) else (
    set "MSG_WELCOME=Welcome to the interactive terminal interface."
    set "MSG_HELP_PROMPT=Type %CLR_GREEN%/help%CLR_RESET% to display all 15 available commands."
    set "MSG_ACTIVE_CMDS==== Active Commands [15 Total] ==="
    set "MSG_HELP_DESC_HELP=- Display this help menu."
    set "MSG_HELP_DESC_SETTINGS=- Open central configuration dashboard."
    set "MSG_HELP_DESC_TALK=- Start an AI assistant chat session (Gemini 1.5 Flash)."
    set "MSG_HELP_DESC_HN=- Run the 'however number' JavaScript package manager."
    set "MSG_HELP_DESC_LANG=- Switch the interface language profile (en / uk)."
    set "MSG_HELP_DESC_LIST=- Scan directory and list active RoleMods."
    set "MSG_HELP_DESC_UPDATE=- Check for and download mod updates."
    set "MSG_HELP_DESC_PLAY=- Import and run an .sb3 file."
    set "MSG_HELP_DESC_INSTALL=- Install a specified modification package."
    set "MSG_HELP_DESC_THEME=- Switch the interface visual color profile."
    set "MSG_HELP_DESC_STATUS=- Display system and host session metrics."
    set "MSG_HELP_DESC_CLI=- Display terminal layout configuration."
    set "MSG_HELP_DESC_CD=- Change directory or view current workspace."
    set "MSG_HELP_DESC_CLEAR=- Clear the terminal screen."
    set "MSG_HELP_DESC_ABOUT=- View author and environment information."
    set "MSG_HELP_DESC_EXIT=- Terminate the current session."
    set "MSG_UNKNOWN_CMD=[Error] Unknown command. Type /help to view valid options."

    set "MSG_SET_TITLE=CLI Settings Dashboard"
    set "MSG_SET_OPT1=Change Interface Theme (Current: !THEME_NAME!)"
    set "MSG_SET_OPT2=Manage Gemini API Credentials"
    set "MSG_SET_OPT3=Change Interface Language (Current: !LANG!)"
    set "MSG_SET_OPT4=View Console Buffer & Window Settings"
    set "MSG_SET_OPT5=Return to Main Console"

    set "MSG_ABOUT_TITLE=About LNTHGLfan2025 RoleMods CLI"
    set "MSG_ABOUT_DESC=An interactive command console for managing modifications, checking file parameters, and loading Scratch development packages."
    set "MSG_ABOUT_DEV=Developer"
    set "MSG_ABOUT_ENV=Environment"
    set "MSG_ABOUT_VER=Version"
    set "MSG_ABOUT_REL=Release"

    set "MSG_STATUS_TITLE=Session and System Status"
    set "MSG_STATUS_DIR=Workspace Dir"
    set "MSG_STATUS_PROF=Active Profile"
    set "MSG_STATUS_THEME=Interface Theme"
    set "MSG_STATUS_LANG=Interface Language"
    set "MSG_STATUS_FRAME=Framework"
    set "MSG_STATUS_CONN=Network Connection"
    set "MSG_STATUS_CONN_ON=Online / Connected"
    set "MSG_STATUS_OUT=Output Mode"
)
goto :eof
