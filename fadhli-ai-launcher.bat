@echo off
setlocal EnableDelayedExpansion
chcp 437 >nul 2>&1
title Fadhli AI Code Assistant Launcher

REM Dynamic paths based on current user - works for any Windows user
set "SETTINGS_FILE=%USERPROFILE%\.claude\settings.json"
set "CLIPROXY_DIR=%USERPROFILE%\cliproxyapiplus"
set "CLIPROXY_STANDARD_BASE=%USERPROFILE%\cliproxyapi"
set "CLIPROXY_ACCOUNTS=%USERPROFILE%\.cli-proxy-api"
set "CLOUDFLARED_EXE="
REM Detect cloudflared.exe location
if exist "C:\Program Files (x86)\cloudflared\cloudflared.exe" set "CLOUDFLARED_EXE=C:\Program Files (x86)\cloudflared\cloudflared.exe"
if exist "C:\Program Files\Cloudflared\cloudflared.exe" set "CLOUDFLARED_EXE=C:\Program Files\Cloudflared\cloudflared.exe"

REM ============================================================================
REM CLOUDFLARE TUNNEL SETTINGS - EDIT THIS SECTION!
REM ============================================================================
set "TUNNEL_NAME=fadproxy"
set "TUNNEL_DOMAIN=api.fadproxy.my.id"
REM ============================================================================

REM ============================================================================
REM AUTO-DETECT INSTALLED VERSIONS (Do not edit - detected automatically)
REM ============================================================================
set "CLIPROXY_PLUS_VER=N/A"
set "CLIPROXY_STD_VER=N/A"
set "CLIPROXY_STANDARD_DIR="

REM Detect CLIProxyAPIPlus version - parse "CLIProxyAPI Version: X.X.X, Commit: ..." to get just version
if exist "!CLIPROXY_DIR!\cli-proxy-api-plus.exe" (
    for /f "tokens=3 delims=, " %%v in ('"!CLIPROXY_DIR!\cli-proxy-api-plus.exe" --version 2^>nul') do (
        if "!CLIPROXY_PLUS_VER!"=="N/A" set "CLIPROXY_PLUS_VER=%%v"
    )
)

REM Detect CLIProxyAPI Standard version - scan for version folders (e.g., 6.7.7)
for /d %%d in ("%CLIPROXY_STANDARD_BASE%\*.*.*") do (
    if exist "%%d\cli-proxy-api.exe" (
        set "CLIPROXY_STANDARD_DIR=%%d"
        set "CLIPROXY_STD_VER=%%~nxd"
    )
)
REM If no version folder found, check base folder directly
if "!CLIPROXY_STANDARD_DIR!"=="" (
    if exist "%CLIPROXY_STANDARD_BASE%\cli-proxy-api.exe" (
        set "CLIPROXY_STANDARD_DIR=%CLIPROXY_STANDARD_BASE%"
        for /f "tokens=3 delims=, " %%v in ('"%CLIPROXY_STANDARD_BASE%\cli-proxy-api.exe" --version 2^>nul') do (
            if "!CLIPROXY_STD_VER!"=="N/A" set "CLIPROXY_STD_VER=%%v"
        )
    )
)
REM ============================================================================

REM Create ESC character for ANSI colors
for /F "delims=" %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"

REM Define colors
set "RED=!ESC![91m"
set "GRN=!ESC![92m"
set "YEL=!ESC![93m"
set "BLU=!ESC![94m"
set "MAG=!ESC![95m"
set "CYN=!ESC![96m"
set "WHT=!ESC![97m"
set "RST=!ESC![0m"

:main_menu
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::    ######   ###   ####   ##   ## ##      ##      ######  ##          :: !RST!
echo !RED!  ::    ##      ## ##  ##  ## ##   ## ##      ##        ##    ##          :: !RST!
echo !RED!  ::    #####  ####### ##  ## ####### ##      ##        ##    ##          :: !RST!
echo !RED!  ::    ##     ##   ## ##  ## ##   ## ##      ##        ##    ##          :: !RST!
echo !RED!  ::    ##     ##   ## ####   ##   ## ######  ######  ######  ######      :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::                   AI CODE ASSISTANT LAUNCHER                         :: !RST!
echo !RED!  ::                           by Fadhli                                  :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ========================================================================== !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::    [1]  Claude Code               -  Anthropic AI Assistant          :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::    [2]  Factory Droid             -  Factory AI Agent                :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::    [3]  OpenCode                  -  Open Source AI Coder            :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::    [4]  CLIProxyAPIPlus Manager   -  Copilot, Kiro, Gemini           :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::    [5]  Keluar                                                       :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

set /p "choice=        Pilih AI Assistant [1-5]: "

REM Input validation
if "!choice!"=="" goto main_menu
set "valid_input="
for %%i in (1 2 3 4 5) do if "!choice!"=="%%i" set "valid_input=1"
if not defined valid_input (
    echo.
    echo !RED!      [X] Input tidak valid! Masukkan angka 1-5!!RST!
    timeout /t 2 >nul
    goto main_menu
)

if "!choice!"=="1" goto claude_code
if "!choice!"=="2" goto droid
if "!choice!"=="3" goto opencode
if "!choice!"=="4" goto cliproxyplus_manager
if "!choice!"=="5" goto exit_app

goto main_menu

:exit_app
endlocal
exit /b 0

:claude_code
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::           #####  ##      ###   ##   ## ####   #####                  :: !RST!
echo !RED!  ::          ##      ##     ## ##  ##   ## ##  ## ##                     :: !RST!
echo !RED!  ::          ##      ##    ####### ##   ## ##  ## #####                  :: !RST!
echo !RED!  ::          ##      ##    ##   ## ##   ## ##  ## ##                     :: !RST!
echo !RED!  ::           #####  ##### ##   ##  #####  ####   #####                  :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::                      CLAUDE CODE LAUNCHER                            :: !RST!
echo !RED!  ::                           by Fadhli                                  :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ========================================================================== !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::                      KONFIGURASI MODEL                               :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Read current settings
set "CURRENT_OPUS="
set "CURRENT_SONNET="
set "CURRENT_HAIKU="
for /f "tokens=*" %%a in ('powershell -Command "(Get-Content '!SETTINGS_FILE!' | ConvertFrom-Json).env.ANTHROPIC_DEFAULT_OPUS_MODEL" 2^>nul') do set "CURRENT_OPUS=%%a"
for /f "tokens=*" %%a in ('powershell -Command "(Get-Content '!SETTINGS_FILE!' | ConvertFrom-Json).env.ANTHROPIC_DEFAULT_SONNET_MODEL" 2^>nul') do set "CURRENT_SONNET=%%a"
for /f "tokens=*" %%a in ('powershell -Command "(Get-Content '!SETTINGS_FILE!' | ConvertFrom-Json).env.ANTHROPIC_DEFAULT_HAIKU_MODEL" 2^>nul') do set "CURRENT_HAIKU=%%a"

echo !CYN!      === MODEL PRESET SAAT INI ===!RST!
echo.
echo !WHT!      OPUS   : !GRN!!CURRENT_OPUS!!RST!
echo !WHT!      SONNET : !GRN!!CURRENT_SONNET!!RST!
echo !WHT!      HAIKU  : !GRN!!CURRENT_HAIKU!!RST!
echo.
echo !WHT!  ========================================================================== !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !YEL!  ::    === PILIHAN MENU ===                                              :: !RST!
echo !WHT!  ::    [1]  Lanjut dengan model saat ini                                 :: !RST!
echo !WHT!  ::    [2]  Ganti Model OPUS                                             :: !RST!
echo !WHT!  ::    [3]  Ganti Model SONNET                                           :: !RST!
echo !WHT!  ::    [4]  Ganti Model HAIKU                                            :: !RST!
echo !WHT!  ::    [5]  Lihat Model Tersedia (dari API)                              :: !RST!
echo !WHT!  ::    [6]  Quick Preset - Gemini Thinking                               :: !RST!
echo !WHT!  ::    [7]  Quick Preset - Kiro                                          :: !RST!
echo !WHT!  ::    [8]  Quick Preset - Copilot                                       :: !RST!
echo !WHT!  ::    [0]  Kembali ke Menu Utama                                        :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

set /p "cc_choice=      Pilih opsi [0-8]: "

if "!cc_choice!"=="" goto claude_code
if "!cc_choice!"=="0" goto main_menu
if "!cc_choice!"=="1" goto claude_select_folder
if "!cc_choice!"=="2" goto claude_set_opus
if "!cc_choice!"=="3" goto claude_set_sonnet
if "!cc_choice!"=="4" goto claude_set_haiku
if "!cc_choice!"=="5" goto claude_list_models
if "!cc_choice!"=="6" goto claude_preset_gemini
if "!cc_choice!"=="7" goto claude_preset_kiro
if "!cc_choice!"=="8" goto claude_preset_copilot

goto claude_code

:claude_list_models
cls
echo.
echo !CYN!  ========================================================================== !RST!
echo !CYN!  ::                     MODEL TERSEDIA DARI API                          :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !YEL!      Mengambil daftar model dari http://127.0.0.1:8317...!RST!
echo.

REM Use curl to fetch models and save to temp file
set "TEMP_MODELS=%TEMP%\cliproxy_models.txt"
curl -s -H "Authorization: Bearer sk-dummy" http://127.0.0.1:8317/v1/models 2>nul | powershell -NoProfile -Command "$input | ConvertFrom-Json | ForEach-Object { $i=1; $_.data | ForEach-Object { Write-Output $_.id; $i++ } }" > "!TEMP_MODELS!" 2>nul

REM Check if we got models
set "MODEL_COUNT=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!" 2^>nul') do set /a MODEL_COUNT+=1

if !MODEL_COUNT! EQU 0 (
    echo !RED!      [ERROR] Server tidak berjalan atau tidak ada model.!RST!
) else (
    echo       Model yang tersedia:
    echo       ------------------------------------------------------------
    set "MODEL_NUM=0"
    for /f "tokens=*" %%a in ('type "!TEMP_MODELS!"') do (
        set /a MODEL_NUM+=1
        echo         [!MODEL_NUM!] %%a
    )
)

echo.
pause
goto claude_code

:claude_set_opus
cls
echo.
echo !MAG!  ========================================================================== !RST!
echo !MAG!  ::                       SET MODEL OPUS                                 :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Model OPUS saat ini: !GRN!!CURRENT_OPUS!!RST!
echo.
echo !YEL!      Mengambil daftar model dari API...!RST!
echo.

REM Use curl to fetch models and save to temp file
set "TEMP_MODELS=%TEMP%\cliproxy_models.txt"
curl -s -H "Authorization: Bearer sk-dummy" http://127.0.0.1:8317/v1/models 2>nul | powershell -NoProfile -Command "$input | ConvertFrom-Json | ForEach-Object { $i=1; $_.data | ForEach-Object { Write-Output $_.id; $i++ } }" > "!TEMP_MODELS!" 2>nul

REM Check if we got models
set "MODEL_COUNT=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!" 2^>nul') do set /a MODEL_COUNT+=1

if !MODEL_COUNT! EQU 0 (
    echo !RED!      [ERROR] Server tidak berjalan atau tidak ada model.!RST!
    echo.
    echo !YEL!        [0]  Kembali!RST!
    echo.
    set /p "MODEL_CHOICE=      Pilih [0 = Kembali]: "
    goto claude_code
)

REM Display models with numbers
set "MODEL_NUM=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!"') do (
    set /a MODEL_NUM+=1
    echo         [!MODEL_NUM!]  %%a
)
echo.
echo !YEL!        [0]  Batal - Kembali!RST!

echo.
set /p "MODEL_CHOICE=      Pilih nomor model [0 = Batal]: "

if "!MODEL_CHOICE!"=="" goto claude_code
if "!MODEL_CHOICE!"=="0" goto claude_code

REM Validate choice is a number
set "VALID_NUM="
for /f "delims=0123456789" %%a in ("!MODEL_CHOICE!") do set "VALID_NUM=%%a"
if defined VALID_NUM (
    echo !RED!      [X] Input harus berupa angka!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Check if choice is within range
if !MODEL_CHOICE! LSS 1 (
    echo !RED!      [X] Nomor tidak valid!!RST!
    timeout /t 2 >nul
    goto claude_code
)
if !MODEL_CHOICE! GTR !MODEL_COUNT! (
    echo !RED!      [X] Nomor tidak valid! Maksimal: !MODEL_COUNT!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Get model name by line number
set "TEMP_MODEL="
set "LINE_NUM=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!"') do (
    set /a LINE_NUM+=1
    if !LINE_NUM! EQU !MODEL_CHOICE! set "TEMP_MODEL=%%a"
)

if "!TEMP_MODEL!"=="" (
    echo !RED!      [X] Gagal mendapatkan nama model!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Update settings.json using PowerShell with proper escaping
set "SF=!SETTINGS_FILE!"
set "TM=!TEMP_MODEL!"
powershell -NoProfile -Command "$f='%SF%'; $c=Get-Content $f -Raw | ConvertFrom-Json; $c.env.ANTHROPIC_DEFAULT_OPUS_MODEL='%TM%'; $c | ConvertTo-Json -Depth 10 | Set-Content $f -Encoding UTF8"

echo.
echo !GRN!      [OK] Model OPUS diubah ke: !TEMP_MODEL!!RST!
timeout /t 2 >nul
goto claude_code

:claude_set_sonnet
cls
echo.
echo !MAG!  ========================================================================== !RST!
echo !MAG!  ::                      SET MODEL SONNET                                :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Model SONNET saat ini: !GRN!!CURRENT_SONNET!!RST!
echo.
echo !YEL!      Mengambil daftar model dari API...!RST!
echo.

REM Use curl to fetch models and save to temp file
set "TEMP_MODELS=%TEMP%\cliproxy_models.txt"
curl -s -H "Authorization: Bearer sk-dummy" http://127.0.0.1:8317/v1/models 2>nul | powershell -NoProfile -Command "$input | ConvertFrom-Json | ForEach-Object { $i=1; $_.data | ForEach-Object { Write-Output $_.id; $i++ } }" > "!TEMP_MODELS!" 2>nul

REM Check if we got models
set "MODEL_COUNT=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!" 2^>nul') do set /a MODEL_COUNT+=1

if !MODEL_COUNT! EQU 0 (
    echo !RED!      [ERROR] Server tidak berjalan atau tidak ada model.!RST!
    echo.
    echo !YEL!        [0]  Kembali!RST!
    echo.
    set /p "MODEL_CHOICE=      Pilih [0 = Kembali]: "
    goto claude_code
)

REM Display models with numbers
set "MODEL_NUM=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!"') do (
    set /a MODEL_NUM+=1
    echo         [!MODEL_NUM!]  %%a
)
echo.
echo !YEL!        [0]  Batal - Kembali!RST!

echo.
set /p "MODEL_CHOICE=      Pilih nomor model [0 = Batal]: "

if "!MODEL_CHOICE!"=="" goto claude_code
if "!MODEL_CHOICE!"=="0" goto claude_code

REM Validate choice is a number
set "VALID_NUM="
for /f "delims=0123456789" %%a in ("!MODEL_CHOICE!") do set "VALID_NUM=%%a"
if defined VALID_NUM (
    echo !RED!      [X] Input harus berupa angka!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Check if choice is within range
if !MODEL_CHOICE! LSS 1 (
    echo !RED!      [X] Nomor tidak valid!!RST!
    timeout /t 2 >nul
    goto claude_code
)
if !MODEL_CHOICE! GTR !MODEL_COUNT! (
    echo !RED!      [X] Nomor tidak valid! Maksimal: !MODEL_COUNT!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Get model name by line number
set "TEMP_MODEL="
set "LINE_NUM=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!"') do (
    set /a LINE_NUM+=1
    if !LINE_NUM! EQU !MODEL_CHOICE! set "TEMP_MODEL=%%a"
)

if "!TEMP_MODEL!"=="" (
    echo !RED!      [X] Gagal mendapatkan nama model!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Update settings.json using PowerShell with proper escaping
set "SF=!SETTINGS_FILE!"
set "TM=!TEMP_MODEL!"
powershell -NoProfile -Command "$f='%SF%'; $c=Get-Content $f -Raw | ConvertFrom-Json; $c.env.ANTHROPIC_DEFAULT_SONNET_MODEL='%TM%'; $c | ConvertTo-Json -Depth 10 | Set-Content $f -Encoding UTF8"

echo.
echo !GRN!      [OK] Model SONNET diubah ke: !TEMP_MODEL!!RST!
timeout /t 2 >nul
goto claude_code

:claude_set_haiku
cls
echo.
echo !MAG!  ========================================================================== !RST!
echo !MAG!  ::                       SET MODEL HAIKU                                :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Model HAIKU saat ini: !GRN!!CURRENT_HAIKU!!RST!
echo.
echo !YEL!      Mengambil daftar model dari API...!RST!
echo.

REM Use curl to fetch models and save to temp file
set "TEMP_MODELS=%TEMP%\cliproxy_models.txt"
curl -s -H "Authorization: Bearer sk-dummy" http://127.0.0.1:8317/v1/models 2>nul | powershell -NoProfile -Command "$input | ConvertFrom-Json | ForEach-Object { $i=1; $_.data | ForEach-Object { Write-Output $_.id; $i++ } }" > "!TEMP_MODELS!" 2>nul

REM Check if we got models
set "MODEL_COUNT=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!" 2^>nul') do set /a MODEL_COUNT+=1

if !MODEL_COUNT! EQU 0 (
    echo !RED!      [ERROR] Server tidak berjalan atau tidak ada model.!RST!
    echo.
    echo !YEL!        [0]  Kembali!RST!
    echo.
    set /p "MODEL_CHOICE=      Pilih [0 = Kembali]: "
    goto claude_code
)

REM Display models with numbers
set "MODEL_NUM=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!"') do (
    set /a MODEL_NUM+=1
    echo         [!MODEL_NUM!]  %%a
)
echo.
echo !YEL!        [0]  Batal - Kembali!RST!

echo.
set /p "MODEL_CHOICE=      Pilih nomor model [0 = Batal]: "

if "!MODEL_CHOICE!"=="" goto claude_code
if "!MODEL_CHOICE!"=="0" goto claude_code

REM Validate choice is a number
set "VALID_NUM="
for /f "delims=0123456789" %%a in ("!MODEL_CHOICE!") do set "VALID_NUM=%%a"
if defined VALID_NUM (
    echo !RED!      [X] Input harus berupa angka!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Check if choice is within range
if !MODEL_CHOICE! LSS 1 (
    echo !RED!      [X] Nomor tidak valid!!RST!
    timeout /t 2 >nul
    goto claude_code
)
if !MODEL_CHOICE! GTR !MODEL_COUNT! (
    echo !RED!      [X] Nomor tidak valid! Maksimal: !MODEL_COUNT!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Get model name by line number
set "TEMP_MODEL="
set "LINE_NUM=0"
for /f "tokens=*" %%a in ('type "!TEMP_MODELS!"') do (
    set /a LINE_NUM+=1
    if !LINE_NUM! EQU !MODEL_CHOICE! set "TEMP_MODEL=%%a"
)

if "!TEMP_MODEL!"=="" (
    echo !RED!      [X] Gagal mendapatkan nama model!!RST!
    timeout /t 2 >nul
    goto claude_code
)

REM Update settings.json using PowerShell with proper escaping
set "SF=!SETTINGS_FILE!"
set "TM=!TEMP_MODEL!"
powershell -NoProfile -Command "$f='%SF%'; $c=Get-Content $f -Raw | ConvertFrom-Json; $c.env.ANTHROPIC_DEFAULT_HAIKU_MODEL='%TM%'; $c | ConvertTo-Json -Depth 10 | Set-Content $f -Encoding UTF8"

echo.
echo !GRN!      [OK] Model HAIKU diubah ke: !TEMP_MODEL!!RST!
timeout /t 2 >nul
goto claude_code

:claude_preset_gemini
cls
echo.
echo !CYN!      Menerapkan preset Gemini Thinking...!RST!
set "SF=!SETTINGS_FILE!"
powershell -NoProfile -Command "$f='%SF%'; $j=Get-Content $f -Raw | ConvertFrom-Json; $j.env.ANTHROPIC_DEFAULT_OPUS_MODEL='gemini-claude-opus-4-5-thinking'; $j.env.ANTHROPIC_DEFAULT_SONNET_MODEL='gemini-claude-sonnet-4-5-thinking'; $j.env.ANTHROPIC_DEFAULT_HAIKU_MODEL='gemini-2.5-flash'; $j | ConvertTo-Json -Depth 10 | Set-Content $f -Encoding UTF8"
echo.
echo !GRN!      [OK] Preset Gemini Thinking diterapkan:!RST!
echo !WHT!        OPUS   : gemini-claude-opus-4-5-thinking!RST!
echo !WHT!        SONNET : gemini-claude-sonnet-4-5-thinking!RST!
echo !WHT!        HAIKU  : gemini-2.5-flash!RST!
timeout /t 2 >nul
goto claude_code

:claude_preset_kiro
cls
echo.
echo !CYN!      Menerapkan preset Kiro (AWS CodeWhisperer)...!RST!
set "SF=!SETTINGS_FILE!"
powershell -NoProfile -Command "$f='%SF%'; $j=Get-Content $f -Raw | ConvertFrom-Json; $j.env.ANTHROPIC_DEFAULT_OPUS_MODEL='kiro-claude-opus-4-5'; $j.env.ANTHROPIC_DEFAULT_SONNET_MODEL='kiro-claude-sonnet-4-5'; $j.env.ANTHROPIC_DEFAULT_HAIKU_MODEL='kiro-claude-haiku-3-5'; $j | ConvertTo-Json -Depth 10 | Set-Content $f -Encoding UTF8"
echo.
echo !GRN!      [OK] Preset Kiro diterapkan:!RST!
echo !WHT!        OPUS   : kiro-claude-opus-4-5!RST!
echo !WHT!        SONNET : kiro-claude-sonnet-4-5!RST!
echo !WHT!        HAIKU  : kiro-claude-haiku-3-5!RST!
timeout /t 2 >nul
goto claude_code

:claude_preset_copilot
cls
echo.
echo !CYN!      Menerapkan preset GitHub Copilot...!RST!
set "SF=!SETTINGS_FILE!"
powershell -NoProfile -Command "$f='%SF%'; $j=Get-Content $f -Raw | ConvertFrom-Json; $j.env.ANTHROPIC_DEFAULT_OPUS_MODEL='claude-opus-4.5'; $j.env.ANTHROPIC_DEFAULT_SONNET_MODEL='claude-sonnet-4.5'; $j.env.ANTHROPIC_DEFAULT_HAIKU_MODEL='claude-haiku-3.5'; $j | ConvertTo-Json -Depth 10 | Set-Content $f -Encoding UTF8"
echo.
echo !GRN!      [OK] Preset GitHub Copilot diterapkan:!RST!
echo !WHT!        OPUS   : claude-opus-4.5!RST!
echo !WHT!        SONNET : claude-sonnet-4.5!RST!
echo !WHT!        HAIKU  : claude-haiku-3.5!RST!
timeout /t 2 >nul
goto claude_code

:claude_select_folder
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                      CLAUDE CODE LAUNCHER                            :: !RST!
echo !WHT!  ========================================================================== !RST!
echo !WHT!  ::                      PILIH FOLDER PROJECT                            :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Membuka dialog pemilihan folder...!RST!

for /f "delims=" %%i in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.FolderBrowserDialog; $d.Description = 'Pilih folder project untuk Claude Code'; $d.ShowNewFolderButton = $true; if ($d.ShowDialog() -eq 'OK') { $d.SelectedPath } else { '' }"') do set "PROJECT_PATH=%%i"

if "!PROJECT_PATH!"=="" (
    echo !RED!      [X] Tidak ada folder yang dipilih!RST!
    pause
    goto claude_code
)

echo.
echo !GRN!      [OK] Folder: !PROJECT_PATH!!RST!
echo.
echo !WHT!      Launching Claude Code...!RST!
echo.

cd /d "!PROJECT_PATH!"
claude
pause
goto main_menu

:droid
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::            ####   ####    ###   ##  ####                             :: !RST!
echo !RED!  ::            ##  ## ##  ## ## ##  ## ##  ##                            :: !RST!
echo !RED!  ::            ##  ## ####   ## ##  ## ##  ##                            :: !RST!
echo !RED!  ::            ##  ## ##  ## ## ##  ## ##  ##                            :: !RST!
echo !RED!  ::            ####   ##  ##  ###   ## ####                              :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::                     FACTORY AI DROID                                 :: !RST!
echo !RED!  ::                         by Fadhli                                    :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ========================================================================== !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::                      PILIH FOLDER PROJECT                            :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Membuka dialog pemilihan folder...!RST!

for /f "delims=" %%i in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.FolderBrowserDialog; $d.Description = 'Pilih folder project untuk Factory Droid'; $d.ShowNewFolderButton = $true; if ($d.ShowDialog() -eq 'OK') { $d.SelectedPath } else { '' }"') do set "PROJECT_PATH=%%i"

if "!PROJECT_PATH!"=="" (
    echo !RED!      [X] Tidak ada folder yang dipilih!RST!
    pause
    goto main_menu
)

echo.
echo !GRN!      [OK] Folder: !PROJECT_PATH!!RST!
echo.
echo !WHT!      Launching Factory Droid...!RST!
echo.

cd /d "!PROJECT_PATH!"
droid
pause
goto main_menu

:opencode
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::     ####   ####   #####  ##   ##  #####  ####   ####   #####         :: !RST!
echo !RED!  ::    ##  ## ##  ## ##     ####  ## ##     ##  ## ##  ## ##             :: !RST!
echo !RED!  ::    ##  ## ####   #####  ## ## ## ##     ##  ## ##  ## #####          :: !RST!
echo !RED!  ::    ##  ## ##     ##     ##  #### ##     ##  ## ##  ## ##             :: !RST!
echo !RED!  ::     ####  ##     #####  ##   ###  ##### ####   ####   #####          :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::                         OPENCODE AI                                  :: !RST!
echo !RED!  ::                          by Fadhli                                   :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ========================================================================== !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::                      PILIH FOLDER PROJECT                            :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Membuka dialog pemilihan folder...!RST!

for /f "delims=" %%i in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.FolderBrowserDialog; $d.Description = 'Pilih folder project untuk OpenCode'; $d.ShowNewFolderButton = $true; if ($d.ShowDialog() -eq 'OK') { $d.SelectedPath } else { '' }"') do set "PROJECT_PATH=%%i"

if "!PROJECT_PATH!"=="" (
    echo !RED!      [X] Tidak ada folder yang dipilih!RST!
    pause
    goto main_menu
)

echo.
echo !GRN!      [OK] Folder: !PROJECT_PATH!!RST!
echo.
echo !WHT!      Launching OpenCode...!RST!
echo.

cd /d "!PROJECT_PATH!"
opencode
pause
goto main_menu

:cliproxyplus_manager
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::     #####  ##     ##  ####   ####    ###   ##  ## ##   ##            :: !RST!
echo !RED!  ::    ##      ##     ## ##  ## ##  ##  ## ##   ## ##   ## ##            :: !RST!
echo !RED!  ::    ##      ##     ## ####   ####   ## ##     ###     ###             :: !RST!
echo !RED!  ::    ##      ##     ## ##     ##  ## ## ##    ## ##     ##             :: !RST!
echo !RED!  ::     #####  ###### ## ##     ##  ##  ###    ##  ##    ##              :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ::                   CLIProxyAPIPlus MANAGER                            :: !RST!
echo !RED!  ::            GitHub Copilot + Kiro + Gemini + Codex                    :: !RST!
echo !RED!  ::                         by Fadhli                                    :: !RST!
echo !RED!  ::                                                                      :: !RST!
echo !RED!  ========================================================================== !RST!
echo !WHT!  ::  Plus: !GRN!!CLIPROXY_PLUS_VER!!WHT!  ^|  Standard: !CYN!!CLIPROXY_STD_VER!!RST!
echo !WHT!  ========================================================================== !RST!
echo !WHT!  ::    === AKUN MANAGEMENT ===                                           :: !RST!
echo !WHT!  ::    [1]  Lihat Semua Akun                                             :: !RST!
echo !WHT!  ::    [2]  Hapus Akun                                                   :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !GRN!  ::    === LOGIN PROVIDER ===                                            :: !RST!
echo !GRN!  ::    [3]  Login GitHub Copilot            [Device Flow]                :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !CYN!  ::    === KIRO (AWS CodeWhisperer) ===                                  :: !RST!
echo !CYN!  ::    [4]  Kiro - Google OAuth             [Browser]                    :: !RST!
echo !CYN!  ::    [5]  Kiro - AWS Builder ID           [Recommended]                :: !RST!
echo !CYN!  ::    [6]  Kiro - Import dari IDE          [Auto - Best]                :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !YEL!  ::    === OTHER PROVIDERS ===                                           :: !RST!
echo !YEL!  ::    [7]  Login Google/Antigravity        [Browser]                    :: !RST!
echo !YEL!  ::    [8]  Login ChatGPT/Codex             [Browser]                    :: !RST!
echo !YEL!  ::    [9]  Login Claude                    [Browser]                    :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::    === SERVER ===                                                    :: !RST!
echo !WHT!  ::    [10] Start CLIProxyAPIPlus Server    [Port 8317]                  :: !RST!
echo !WHT!  ::    [11] Lihat Model Tersedia                                         :: !RST!
echo !WHT!  ::    [12] Buka Dashboard Management       [Web Browser]                :: !RST!
echo !WHT!  ::    [13] Hentikan Server Port 8317                                    :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !CYN!  ::    === CLIPROXY STANDARD (Non-Plus) ===                              :: !RST!
echo !CYN!  ::    [14] Start CLIProxyAPI Standard      [Port 8317]                  :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !MAG!  ::    === CLOUDFLARE TUNNEL ===                                         :: !RST!
echo !MAG!  ::    [15] Start Cloudflare Tunnel         [api.fadproxy.my.id]         :: !RST!
echo !MAG!  ::    [16] Stop Cloudflare Tunnel                                       :: !RST!
echo !MAG!  ::    [17] Cek Status Tunnel                                            :: !RST!
echo !MAG!  ::    [18] Install Tunnel as Service       [Auto-Start]                 :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !BLU!  ::    === UPDATE / INSTALL ===                                          :: !RST!
echo !BLU!  ::    [19] Cek Versi Terbaru CLIProxyAPI                                :: !RST!
echo !BLU!  ::    [20] Auto Update CLIProxyAPIPlus     [Windows]                    :: !RST!
echo !BLU!  ::    [21] Auto Update CLIProxyAPI Std     [Windows]                    :: !RST!
echo !BLU!  ::    [22] Install untuk OS Lain           [Linux/macOS]                :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ::    [0]  Kembali ke Menu Utama                                        :: !RST!
echo !WHT!  ::                                                                      :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

set /p "ag_choice=      Pilih opsi [0-22]: "

REM Input validation - check if empty
if "!ag_choice!"=="" goto cliproxyplus_manager

REM Validate input is 0-22 using simple checks
set "valid_input="
for %%i in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22) do (
    if "!ag_choice!"=="%%i" set "valid_input=1"
)
if not defined valid_input (
    echo.
    echo !RED!      [X] Input tidak valid! Masukkan angka 0-22!!RST!
    timeout /t 2 >nul
    goto cliproxyplus_manager
)

if "!ag_choice!"=="0" goto main_menu
if "!ag_choice!"=="1" goto list_accounts
if "!ag_choice!"=="2" goto delete_account
if "!ag_choice!"=="3" goto login_github_copilot
if "!ag_choice!"=="4" goto login_kiro_google
if "!ag_choice!"=="5" goto login_kiro_aws
if "!ag_choice!"=="6" goto import_kiro_token
if "!ag_choice!"=="7" goto add_antigravity
if "!ag_choice!"=="8" goto add_codex
if "!ag_choice!"=="9" goto add_claude
if "!ag_choice!"=="10" goto start_server
if "!ag_choice!"=="11" goto list_models
if "!ag_choice!"=="12" goto open_dashboard
if "!ag_choice!"=="13" goto stop_server
if "!ag_choice!"=="14" goto start_standard_server
if "!ag_choice!"=="15" goto start_tunnel
if "!ag_choice!"=="16" goto stop_tunnel
if "!ag_choice!"=="17" goto tunnel_status
if "!ag_choice!"=="18" goto install_tunnel_service
if "!ag_choice!"=="19" goto cliproxy_check_version
if "!ag_choice!"=="20" goto cliproxy_update_plus
if "!ag_choice!"=="21" goto cliproxy_update_standard
if "!ag_choice!"=="22" goto cliproxy_install_other_os

goto cliproxyplus_manager

:list_accounts
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                         DAFTAR SEMUA AKUN                            :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Lokasi: !CLIPROXY_ACCOUNTS!\!RST!
echo.
dir /b "!CLIPROXY_ACCOUNTS!\*.json" 2>nul
if errorlevel 1 echo !RED!      [Tidak ada akun tersimpan]!RST!
echo.
pause
goto cliproxyplus_manager

:login_github_copilot
cls
echo.
echo !GRN!  ========================================================================== !RST!
echo !GRN!  ::                       LOGIN GITHUB COPILOT                           :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Langkah login GitHub Copilot:!RST!
echo !WHT!      1. Sebuah kode device akan ditampilkan!RST!
echo !WHT!      2. Browser akan terbuka ke github.com/login/device!RST!
echo !WHT!      3. Masukkan kode device yang ditampilkan!RST!
echo !WHT!      4. Authorize akses untuk CLIProxyAPIPlus!RST!
echo.
echo !YEL!      [!] Pastikan Anda memiliki GitHub Copilot subscription aktif!RST!
echo.
pause
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe -github-copilot-login
echo.
echo !GRN!      [OK] Login GitHub Copilot selesai!!RST!
pause
goto cliproxyplus_manager

:login_kiro_google
cls
echo.
echo !CYN!  ========================================================================== !RST!
echo !CYN!  ::                    LOGIN KIRO - GOOGLE OAUTH                         :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Browser akan terbuka untuk login Google...!RST!
echo !WHT!      Pilih akun Google yang terhubung dengan Kiro/AWS CodeWhisperer!RST!
echo.
pause
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe -kiro-google-login
echo.
echo !CYN!      [OK] Login Kiro - Google selesai!!RST!
pause
goto cliproxyplus_manager

:login_kiro_aws
cls
echo.
echo !CYN!  ========================================================================== !RST!
echo !CYN!  ::                   LOGIN KIRO - AWS BUILDER ID                        :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Browser akan terbuka untuk login AWS Builder ID...!RST!
echo !WHT!      Metode: Authorization Code Flow (Better UX)!RST!
echo.
pause
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe -kiro-aws-authcode
echo.
echo !CYN!      [OK] Login Kiro - AWS selesai!!RST!
pause
goto cliproxyplus_manager

:import_kiro_token
cls
echo.
echo !CYN!  ========================================================================== !RST!
echo !CYN!  ::                   IMPORT TOKEN KIRO DARI IDE                         :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Metode ini akan mengimport token dari Kiro IDE yang sudah login.!RST!
echo.
echo !YEL!      Lokasi token: ~/.aws/sso/cache/kiro-auth-token.json!RST!
echo.
echo !WHT!      Pastikan Anda sudah login di Kiro IDE terlebih dahulu!!RST!
echo.
pause
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe -kiro-import
echo.
echo !CYN!      [OK] Import token Kiro selesai!!RST!
pause
goto cliproxyplus_manager

:add_antigravity
cls
echo.
echo !YEL!  ========================================================================== !RST!
echo !YEL!  ::                   LOGIN GOOGLE - ANTIGRAVITY                         :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Browser akan terbuka untuk login Google...!RST!
echo.
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe -antigravity-login
echo.
echo !YEL!      [OK] Login Google/Antigravity selesai!!RST!
pause
goto cliproxyplus_manager

:add_codex
cls
echo.
echo !YEL!  ========================================================================== !RST!
echo !YEL!  ::                  TAMBAH AKUN CHATGPT - CODEX                         :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Browser akan terbuka untuk login ChatGPT/OpenAI...!RST!
echo.
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe -codex-login
echo.
echo !YEL!      [OK] Login ChatGPT/Codex selesai!!RST!
pause
goto cliproxyplus_manager

:add_claude
cls
echo.
echo !YEL!  ========================================================================== !RST!
echo !YEL!  ::                          LOGIN CLAUDE                                :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Browser akan terbuka untuk login Claude/Anthropic...!RST!
echo.
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe -claude-login
echo.
echo !YEL!      [OK] Login Claude selesai!!RST!
pause
goto cliproxyplus_manager

:delete_account
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                            HAPUS AKUN                                :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Akun yang tersedia:!RST!
echo.
dir /b "!CLIPROXY_ACCOUNTS!\*.json" 2>nul
if errorlevel 1 (
    echo !RED!      [Tidak ada akun tersimpan]!RST!
    pause
    goto cliproxyplus_manager
)
echo.
echo !WHT!      Untuk menghapus, buka folder dan hapus file JSON secara manual:!RST!
echo !YEL!      !CLIPROXY_ACCOUNTS!\!RST!
echo.
start explorer "!CLIPROXY_ACCOUNTS!"
pause
goto cliproxyplus_manager

:start_server
cls
echo.
echo !GRN!  ========================================================================== !RST!
echo !GRN!  ::                   START CLIPROXYAPIPLUS SERVER                       :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Check if port 8317 is already in use
set "PORT_IN_USE="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8317" ^| findstr "LISTENING" 2^>nul') do (
    set "PORT_IN_USE=%%a"
)

if defined PORT_IN_USE (
    echo.
    echo !RED!  ========================================================================== !RST!
    echo !RED!  ::                    PORT 8317 SUDAH DIGUNAKAN                         :: !RST!
    echo !WHT!  ========================================================================== !RST!
    echo !WHT!  ::                                                                      :: !RST!
    echo !YEL!  ::      Port 8317 sedang digunakan oleh proses lain.                    :: !RST!
    echo !YEL!  ::      PID: !PORT_IN_USE!                                                              :: !RST!
    echo !WHT!  ::                                                                      :: !RST!
    echo !WHT!  ::      [1] Hentikan proses dan lanjutkan start server                  :: !RST!
    echo !WHT!  ::      [2] Kembali ke menu                                             :: !RST!
    echo !WHT!  ::                                                                      :: !RST!
    echo !WHT!  ========================================================================== !RST!
    echo.
    set /p "port_choice=      Pilih [1-2]: "
    
    if "!port_choice!"=="1" (
        echo.
        echo !YEL!      Menghentikan proses PID: !PORT_IN_USE!...!RST!
        taskkill /F /PID !PORT_IN_USE! >nul 2>&1
        if !errorlevel! equ 0 (
            echo !GRN!      [OK] Proses berhasil dihentikan!!RST!
        ) else (
            echo !RED!      [X] Gagal menghentikan proses. Coba jalankan sebagai Administrator.!RST!
        )
    ) else (
        goto cliproxyplus_manager
    )
)

echo !WHT!      Server akan berjalan di port 8317...!RST!
echo !WHT!      Tekan Ctrl+C untuk menghentikan server.!RST!
echo.
echo !GRN!      Features: GitHub Copilot + Kiro + Gemini + Codex!RST!
echo.
cd /d "!CLIPROXY_DIR!"
cli-proxy-api-plus.exe
pause
goto cliproxyplus_manager

:list_models
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                        MODEL YANG TERSEDIA                           :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Pastikan CLIProxyAPIPlus server sudah berjalan!!RST!
echo.

powershell -Command "$r = Invoke-WebRequest -Uri 'http://127.0.0.1:8317/v1/models' -Headers @{'Authorization'='Bearer sk-dummy'} -UseBasicParsing -ErrorAction SilentlyContinue; if ($r) { $j = $r.Content | ConvertFrom-Json; Write-Host '      Model yang tersedia:'; Write-Host '      ------------------------------------------------------------'; foreach ($m in $j.data) { Write-Host ('        - ' + $m.id) } } else { Write-Host '      [ERROR] Server tidak berjalan.' }"

echo.
pause
goto cliproxyplus_manager

:open_dashboard
cls
echo.
echo !GRN!  ========================================================================== !RST!
echo !GRN!  ::                  CLIPROXY DASHBOARD MANAGEMENT                       :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Pastikan server CLIProxy sudah berjalan di port 8317!!RST!
echo.
echo !YEL!      Dashboard URL: http://127.0.0.1:8317!RST!
echo.
echo !WHT!      Pilih halaman yang ingin dibuka:!RST!
echo !WHT!        [1] Dashboard Utama (Port 8317)!RST!
echo !WHT!        [2] Management Console (management.html)!RST!
echo !WHT!        [0] Kembali!RST!
echo.
set /p "dash_choice=      Pilih [0-2]: "

if "!dash_choice!"=="1" (
    start http://127.0.0.1:8317
    echo !GRN!      [OK] Dashboard CLIProxy dibuka!!RST!
)
if "!dash_choice!"=="2" (
    start http://127.0.0.1:8317/management.html
    echo !GRN!      [OK] Management Console dibuka!!RST!
)
pause
goto cliproxyplus_manager

:stop_server
cls
echo.
echo !RED!  ========================================================================== !RST!
echo !RED!  ::                    HENTIKAN SERVER PORT 8317                         :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Check if port 8317 is in use
set "PORT_IN_USE="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8317" ^| findstr "LISTENING" 2^>nul') do (
    set "PORT_IN_USE=%%a"
)

if defined PORT_IN_USE (
    echo !YEL!      Server terdeteksi berjalan di port 8317!RST!
    echo !YEL!      PID: !PORT_IN_USE!!RST!
    echo.
    echo !WHT!      Apakah Anda yakin ingin menghentikan server?!RST!
    echo !WHT!        [1] Ya, hentikan server!RST!
    echo !WHT!        [2] Tidak, kembali ke menu!RST!
    echo.
    set /p "stop_choice=      Pilih [1-2]: "
    
    if "!stop_choice!"=="1" (
        echo.
        echo !YEL!      Menghentikan proses PID: !PORT_IN_USE!...!RST!
        taskkill /F /PID !PORT_IN_USE! >nul 2>&1
        if !errorlevel! equ 0 (
            echo !GRN!      [OK] Server berhasil dihentikan!!RST!
        ) else (
            echo !RED!      [X] Gagal menghentikan server. Coba jalankan sebagai Administrator.!RST!
        )
    )
) else (
    echo !YEL!      Tidak ada server yang berjalan di port 8317.!RST!
)

echo.
pause
goto cliproxyplus_manager

:start_standard_server
cls
echo.
echo !CYN!  ========================================================================== !RST!
echo !CYN!  ::            START CLIPROXYAPI STANDARD - v!CLIPROXY_STD_VER!                       :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Check if Standard is installed
if "!CLIPROXY_STANDARD_DIR!"=="" (
    echo !RED!  ========================================================================== !RST!
    echo !RED!  ::              CLIPROXYAPI STANDARD TIDAK TERINSTALL                   :: !RST!
    echo !WHT!  ========================================================================== !RST!
    echo.
    echo !YEL!      CLIProxyAPI Standard belum terinstall.!RST!
    echo !WHT!      Gunakan menu [21] Auto Update CLIProxyAPI Standard untuk install.!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

if not exist "!CLIPROXY_STANDARD_DIR!\cli-proxy-api.exe" (
    echo !RED!  ========================================================================== !RST!
    echo !RED!  ::              CLI-PROXY-API.EXE TIDAK DITEMUKAN                       :: !RST!
    echo !WHT!  ========================================================================== !RST!
    echo.
    echo !YEL!      File cli-proxy-api.exe tidak ditemukan di:!RST!
    echo !WHT!      !CLIPROXY_STANDARD_DIR!!RST!
    echo.
    echo !WHT!      Gunakan menu [21] Auto Update CLIProxyAPI Standard untuk install.!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

REM Check if port 8317 is already in use (same port as Plus)
set "PORT_STD_IN_USE="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8317" ^| findstr "LISTENING" 2^>nul') do (
    set "PORT_STD_IN_USE=%%a"
)

if defined PORT_STD_IN_USE (
    echo.
    echo !RED!  ========================================================================== !RST!
    echo !RED!  ::                    PORT 8317 SUDAH DIGUNAKAN                         :: !RST!
    echo !WHT!  ========================================================================== !RST!
    echo !WHT!  ::                                                                      :: !RST!
    echo !YEL!  ::      Port 8317 sedang digunakan oleh proses lain.                    :: !RST!
    echo !YEL!  ::      Kemungkinan CLIProxyAPIPlus sedang berjalan.                    :: !RST!
    echo !YEL!  ::      PID: !PORT_STD_IN_USE!                                                              :: !RST!
    echo !WHT!  ::                                                                      :: !RST!
    echo !WHT!  ::      [1] Hentikan proses dan lanjutkan start Standard server         :: !RST!
    echo !WHT!  ::      [2] Kembali ke menu                                             :: !RST!
    echo !WHT!  ::                                                                      :: !RST!
    echo !WHT!  ========================================================================== !RST!
    echo.
    set /p "port_std_choice=      Pilih [1-2]: "
    
    if "!port_std_choice!"=="1" (
        echo.
        echo !YEL!      Menghentikan proses PID: !PORT_STD_IN_USE!...!RST!
        taskkill /F /PID !PORT_STD_IN_USE! >nul 2>&1
        if !errorlevel! equ 0 (
            echo !GRN!      [OK] Proses berhasil dihentikan!!RST!
        ) else (
            echo !RED!      [X] Gagal menghentikan proses. Coba jalankan sebagai Administrator.!RST!
        )
    ) else (
        goto cliproxyplus_manager
    )
)

echo !WHT!      Server Standard akan berjalan di port 8317...!RST!
echo !WHT!      Tekan Ctrl+C untuk menghentikan server.!RST!
echo.
echo !CYN!      Version: !CLIPROXY_STD_VER! - Standard Edition!RST!
echo !CYN!      Location: !CLIPROXY_STANDARD_DIR!!RST!
echo !YEL!      [!] Catatan: CLIProxyAPIPlus dan Standard menggunakan port yang sama!RST!
echo !YEL!          Hanya SATU yang bisa berjalan dalam satu waktu!!RST!
echo.
cd /d "!CLIPROXY_STANDARD_DIR!"
"!CLIPROXY_STANDARD_DIR!\cli-proxy-api.exe"
pause
goto cliproxyplus_manager

REM ============================================================================
REM CLOUDFLARE TUNNEL FUNCTIONS
REM ============================================================================

:start_tunnel
cls
echo.
echo !MAG!  ========================================================================== !RST!
echo !MAG!  ::                   START CLOUDFLARE TUNNEL                            :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Domain: !TUNNEL_DOMAIN!!RST!
echo.

REM Check if cloudflared is installed
if "!CLOUDFLARED_EXE!"=="" (
    echo !RED!  ========================================================================== !RST!
    echo !RED!  ::                  CLOUDFLARED TIDAK DITEMUKAN                         :: !RST!
    echo !WHT!  ========================================================================== !RST!
    echo.
    echo !YEL!      Cloudflared tidak terinstall di lokasi standar:!RST!
    echo !WHT!        - C:\Program Files (x86)\cloudflared\cloudflared.exe!RST!
    echo !WHT!        - C:\Program Files\Cloudflared\cloudflared.exe!RST!
    echo.
    echo !CYN!      Install dengan perintah:!RST!
    echo !WHT!        winget install Cloudflare.cloudflared!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

REM Check if CLIProxyAPIPlus is running
set "CLIPROXY_RUNNING="
for /f "tokens=5" %%a in ('netstat -aon 2^>nul ^| findstr ":8317.*LISTENING"') do (
    set "CLIPROXY_RUNNING=%%a"
)

if "!CLIPROXY_RUNNING!"=="" (
    echo !YEL!  [!] CLIProxyAPIPlus belum berjalan di port 8317!RST!
    echo !YEL!      Tunnel membutuhkan CLIProxyAPIPlus aktif!!RST!
    echo.
    echo !WHT!      [1] Start CLIProxyAPIPlus dulu di terminal lain!RST!
    echo !WHT!      [2] Lanjutkan tanpa CLIProxyAPIPlus!RST!
    echo !WHT!      [0] Kembali!RST!
    echo.
    set /p "tun_choice=      Pilih [0-2]: "
    if "!tun_choice!"=="0" goto cliproxyplus_manager
    if "!tun_choice!"=="1" (
        echo.
        echo !CYN!      Jalankan di terminal terpisah:!RST!
        echo !WHT!      cd %USERPROFILE%\cliproxyapiplus!RST!
        echo !WHT!      .\cli-proxy-api-plus.exe!RST!
        echo.
        pause
        goto cliproxyplus_manager
    )
)

echo !GRN!      CLIProxyAPIPlus aktif di port 8317!!RST!
echo.
echo !CYN!      Memulai Cloudflare Tunnel...!RST!
echo !WHT!      Tekan Ctrl+C untuk menghentikan tunnel.!RST!
echo.
"!CLOUDFLARED_EXE!" tunnel run !TUNNEL_NAME!
pause
goto cliproxyplus_manager

:stop_tunnel
cls
echo.
echo !MAG!  ========================================================================== !RST!
echo !MAG!  ::                   STOP CLOUDFLARE TUNNEL                             :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !YEL!      Mencari proses cloudflared...!RST!
echo.

REM Find and kill cloudflared processes
set "TUNNEL_FOUND="
for /f "tokens=2" %%a in ('tasklist /FI "IMAGENAME eq cloudflared.exe" /NH 2^>nul ^| findstr /I "cloudflared"') do (
    set "TUNNEL_FOUND=%%a"
    taskkill /F /IM cloudflared.exe >nul 2>&1
)

if "!TUNNEL_FOUND!"=="" (
    echo !YEL!      Tidak ada tunnel yang berjalan.!RST!
) else (
    echo !GRN!      [OK] Cloudflare Tunnel berhasil dihentikan!!RST!
)
echo.
pause
goto cliproxyplus_manager

:tunnel_status
cls
echo.
echo !MAG!  ========================================================================== !RST!
echo !MAG!  ::                   STATUS CLOUDFLARE TUNNEL                           :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Check cloudflared process
echo !WHT!  --- Proses Cloudflared ---!RST!
tasklist /FI "IMAGENAME eq cloudflared.exe" /NH 2>nul | findstr /I "cloudflared" >nul
if !errorlevel! equ 0 (
    echo !GRN!      [RUNNING] Cloudflare Tunnel aktif!!RST!
    echo.
    tasklist /FI "IMAGENAME eq cloudflared.exe" /FO TABLE
) else (
    echo !YEL!      [NOT RUNNING] Cloudflare Tunnel tidak aktif!RST!
)
echo.

REM Check CLIProxyAPIPlus
echo !WHT!  --- CLIProxyAPIPlus (Port 8317) ---!RST!
set "PORT_CHECK="
for /f "tokens=5" %%a in ('netstat -aon 2^>nul ^| findstr ":8317.*LISTENING"') do (
    set "PORT_CHECK=%%a"
)
if "!PORT_CHECK!"=="" (
    echo !YEL!      [NOT RUNNING] Port 8317 tidak aktif!RST!
) else (
    echo !GRN!      [RUNNING] CLIProxyAPIPlus aktif di PID: !PORT_CHECK!!RST!
)
echo.

REM Show tunnel info
echo !WHT!  --- Tunnel Info ---!RST!
echo !CYN!      Tunnel Name: !TUNNEL_NAME!!RST!
echo !CYN!      Domain: !TUNNEL_DOMAIN!!RST!
echo !CYN!      Target: http://localhost:8317!RST!
echo.
echo !WHT!  --- Quick Links ---!RST!
echo !WHT!      [1] Buka Dashboard Cloud (!TUNNEL_DOMAIN!)!RST!
echo !WHT!      [2] Buka Dashboard Local (localhost:8317)!RST!
echo !WHT!      [3] Test API Cloud!RST!
echo !WHT!      [0] Kembali!RST!
echo.
set /p "dash_choice=      Pilih [0-3]: "

if "!dash_choice!"=="1" (
    start "" "https://!TUNNEL_DOMAIN!/management.html"
    goto tunnel_status
)
if "!dash_choice!"=="2" (
    start "" "http://127.0.0.1:8317/management.html"
    goto tunnel_status
)
if "!dash_choice!"=="3" (
    start "" "https://!TUNNEL_DOMAIN!/v1/models"
    goto tunnel_status
)
goto cliproxyplus_manager

:install_tunnel_service
cls
echo.
echo !MAG!  ========================================================================== !RST!
echo !MAG!  ::             INSTALL TUNNEL AS WINDOWS SERVICE                        :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Check if cloudflared is installed
if "!CLOUDFLARED_EXE!"=="" (
    echo !RED!      [X] Cloudflared tidak ditemukan!!RST!
    echo !YEL!      Install dengan: winget install Cloudflare.cloudflared!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

echo !YEL!      [!] Ini akan menginstall Cloudflare Tunnel sebagai Windows Service!RST!
echo !YEL!          Tunnel akan otomatis jalan saat Windows startup.!RST!
echo.
echo !WHT!      [1] Install Service (Membutuhkan Admin)!RST!
echo !WHT!      [2] Uninstall Service!RST!
echo !WHT!      [3] Start Service!RST!
echo !WHT!      [4] Stop Service!RST!
echo !WHT!      [0] Kembali!RST!
echo.
set /p "svc_choice=      Pilih [0-4]: "

if "!svc_choice!"=="0" goto cliproxyplus_manager
if "!svc_choice!"=="1" (
    echo.
    echo !CYN!      Menginstall service... (Jalankan sebagai Administrator^)!RST!
    "!CLOUDFLARED_EXE!" service install
    echo.
    pause
)
if "!svc_choice!"=="2" (
    echo.
    echo !YEL!      Menghapus service...!RST!
    "!CLOUDFLARED_EXE!" service uninstall
    echo.
    pause
)
if "!svc_choice!"=="3" (
    echo.
    echo !CYN!      Memulai service...!RST!
    net start cloudflared
    echo.
    pause
)
if "!svc_choice!"=="4" (
    echo.
    echo !YEL!      Menghentikan service...!RST!
    net stop cloudflared
    echo.
    pause
)
goto cliproxyplus_manager

REM ============================================================================
REM                     UPDATE / INSTALL FUNCTIONS
REM ============================================================================

:cliproxy_check_version
cls
echo.
echo !BLU!  ========================================================================== !RST!
echo !BLU!  ::                     CEK VERSI TERBARU                                :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !YEL!      Mengecek versi terbaru dari GitHub...!RST!
echo.

REM Get current installed versions (use auto-detected versions)
set "CURRENT_PLUS_VER=!CLIPROXY_PLUS_VER!"
set "CURRENT_STD_VER=!CLIPROXY_STD_VER!"

REM Re-detect if N/A (in case not detected at startup)
if "!CURRENT_PLUS_VER!"=="N/A" (
    if exist "!CLIPROXY_DIR!\cli-proxy-api-plus.exe" (
        for /f "tokens=3 delims=, " %%v in ('"!CLIPROXY_DIR!\cli-proxy-api-plus.exe" --version 2^>nul') do (
            if "!CURRENT_PLUS_VER!"=="N/A" set "CURRENT_PLUS_VER=%%v"
        )
    )
)
if "!CURRENT_STD_VER!"=="N/A" (
    if exist "!CLIPROXY_STANDARD_DIR!\cli-proxy-api.exe" (
        set "CLIPROXY_STANDARD_DIR=!CLIPROXY_STANDARD_BASE!"
        for /f "tokens=3 delims=, " %%v in ('"!CLIPROXY_STANDARD_DIR!\cli-proxy-api.exe" --version 2^>nul') do (
            if "!CURRENT_STD_VER!"=="N/A" set "CURRENT_STD_VER=%%v"
        )
    )
)

REM Fetch latest version from GitHub API
echo !WHT!      [1/2] Mengecek CLIProxyAPIPlus...!RST!
curl -s -H "User-Agent: FadhliAILauncher" "https://api.github.com/repos/router-for-me/CLIProxyAPIPlus/releases/latest" > "%TEMP%\cliproxy_version.json" 2>nul
set "LATEST_PLUS="
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_version.json -Raw -ErrorAction Stop | ConvertFrom-Json; $j.tag_name } catch { Write-Output 'ERROR' }" 2^>nul') do set "LATEST_PLUS=%%a"

echo !WHT!      [2/2] Mengecek CLIProxyAPI Standard...!RST!
curl -s -H "User-Agent: FadhliAILauncher" "https://api.github.com/repos/router-for-me/CLIProxyAPI/releases/latest" > "%TEMP%\cliproxy_version.json" 2>nul
set "LATEST_STD="
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_version.json -Raw -ErrorAction Stop | ConvertFrom-Json; $j.tag_name } catch { Write-Output 'ERROR' }" 2^>nul') do set "LATEST_STD=%%a"

REM Strip 'v' prefix from version tags for comparison (v6.7.7 -> 6.7.7)
set "LATEST_PLUS_CLEAN=!LATEST_PLUS!"
set "LATEST_STD_CLEAN=!LATEST_STD!"
if "!LATEST_PLUS:~0,1!"=="v" set "LATEST_PLUS_CLEAN=!LATEST_PLUS:~1!"
if "!LATEST_STD:~0,1!"=="v" set "LATEST_STD_CLEAN=!LATEST_STD:~1!"

REM Extract base version (X.Y.Z) for comparison - handles formats like:
REM   6.7.5-0-plus -> 6.7.5
REM   6.7.6-1 -> 6.7.6
REM   6.7.7 -> 6.7.7
set "CURRENT_PLUS_BASE=!CURRENT_PLUS_VER!"
set "CURRENT_STD_BASE=!CURRENT_STD_VER!"
set "LATEST_PLUS_BASE=!LATEST_PLUS_CLEAN!"
set "LATEST_STD_BASE=!LATEST_STD_CLEAN!"

REM Extract base version from CURRENT_PLUS (e.g., 6.7.5-0-plus -> 6.7.5)
for /f "tokens=1 delims=-" %%a in ("!CURRENT_PLUS_VER!") do set "CURRENT_PLUS_BASE=%%a"

REM Extract base version from CURRENT_STD (e.g., 6.7.7-1 -> 6.7.7)
for /f "tokens=1 delims=-" %%a in ("!CURRENT_STD_VER!") do set "CURRENT_STD_BASE=%%a"

REM Extract base version from LATEST_PLUS (e.g., 6.7.6-1 -> 6.7.6)
for /f "tokens=1 delims=-" %%a in ("!LATEST_PLUS_CLEAN!") do set "LATEST_PLUS_BASE=%%a"

REM Extract base version from LATEST_STD (e.g., 6.7.7-1 -> 6.7.7)
for /f "tokens=1 delims=-" %%a in ("!LATEST_STD_CLEAN!") do set "LATEST_STD_BASE=%%a"

echo.
echo !WHT!  ========================================================================== !RST!
echo !WHT!  ::                         HASIL PENGECEKAN                             :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !CYN!      CLIProxyAPIPlus:!RST!
if "!CURRENT_PLUS_VER!"=="N/A" (
    echo !WHT!        Versi Terpasang : !RED!Belum terinstall!RST!
) else (
    echo !WHT!        Versi Terpasang : !GRN!!CURRENT_PLUS_VER!!RST!
)
echo !WHT!        Versi Terbaru   : !YEL!!LATEST_PLUS!!RST!
if defined CLIPROXY_DIR echo !WHT!        Lokasi          : !CYN!!CLIPROXY_DIR!!RST!
echo.
echo !CYN!      CLIProxyAPI Standard:!RST!
if "!CURRENT_STD_VER!"=="N/A" (
    echo !WHT!        Versi Terpasang : !RED!Belum terinstall!RST!
) else (
    echo !WHT!        Versi Terpasang : !GRN!!CURRENT_STD_VER!!RST!
)
echo !WHT!        Versi Terbaru   : !YEL!!LATEST_STD!!RST!
if not "!CLIPROXY_STANDARD_DIR!"=="" echo !WHT!        Lokasi          : !CYN!!CLIPROXY_STANDARD_DIR!!RST!
echo.

REM Compare base versions (X.Y.Z only)
if "!CURRENT_PLUS_VER!"=="N/A" (
    echo !YEL!      [!] CLIProxyAPIPlus belum terinstall. Gunakan [20] untuk install.!RST!
) else if "!CURRENT_PLUS_BASE!"=="!LATEST_PLUS_BASE!" (
    echo !GRN!      [OK] CLIProxyAPIPlus sudah versi terbaru ^(!CURRENT_PLUS_BASE!^)!!RST!
) else (
    echo !YEL!      [!] CLIProxyAPIPlus tersedia update: !CURRENT_PLUS_BASE! -^> !LATEST_PLUS_BASE!!RST!
)

if "!CURRENT_STD_VER!"=="N/A" (
    echo !YEL!      [!] CLIProxyAPI Standard belum terinstall. Gunakan [21] untuk install.!RST!
) else if "!CURRENT_STD_BASE!"=="!LATEST_STD_BASE!" (
    echo !GRN!      [OK] CLIProxyAPI Standard sudah versi terbaru ^(!CURRENT_STD_BASE!^)!!RST!
) else (
    echo !YEL!      [!] CLIProxyAPI Standard tersedia update: !CURRENT_STD_BASE! -^> !LATEST_STD_BASE!!RST!
)
echo.

echo !WHT!      Pilih [20] untuk update Plus, [21] untuk update Standard!RST!
echo.
pause
goto cliproxyplus_manager

:cliproxy_update_plus
cls
echo.
echo !BLU!  ========================================================================== !RST!
echo !BLU!  ::                AUTO UPDATE CLIProxyAPIPlus (Windows)                 :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Fetch latest release info
echo !YEL!      Mengambil informasi release terbaru...!RST!
curl -s -H "User-Agent: FadhliAILauncher" "https://api.github.com/repos/router-for-me/CLIProxyAPIPlus/releases/latest" > "%TEMP%\cliproxy_release.json" 2>nul

REM Get version and download URL using $env:TEMP
set "LATEST_VER="
set "DOWNLOAD_URL="
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_release.json -Raw -ErrorAction Stop | ConvertFrom-Json; $j.tag_name } catch { Write-Output '' }" 2^>nul') do set "LATEST_VER=%%a"
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_release.json -Raw -ErrorAction Stop | ConvertFrom-Json; ($j.assets | Where-Object { $_.name -like '*windows_amd64.zip' }).browser_download_url } catch { Write-Output '' }" 2^>nul') do set "DOWNLOAD_URL=%%a"

if "!LATEST_VER!"=="" (
    echo !RED!      [X] Gagal mendapatkan info release dari GitHub!!RST!
    echo !YEL!      Kemungkinan: Rate limit GitHub API atau tidak ada koneksi internet.!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

if "!DOWNLOAD_URL!"=="" (
    echo !RED!      [X] Gagal mendapatkan download URL!!RST!
    echo !YEL!      Kemungkinan: Tidak ada asset Windows untuk versi ini.!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

echo.
echo !WHT!      Versi Terbaru: !GRN!!LATEST_VER!!RST!
echo !WHT!      Download URL : !CYN!!DOWNLOAD_URL!!RST!
echo.

set /p "confirm=      Lanjutkan download dan install? [Y/N]: "
if /i not "!confirm!"=="Y" goto cliproxyplus_manager

REM Stop server if running
echo.
echo !YEL!      Menghentikan server jika sedang berjalan...!RST!
taskkill /f /im cli-proxy-api-plus.exe >nul 2>&1

REM Download file
echo !YEL!      Mendownload !LATEST_VER!...!RST!
echo !WHT!      Target: %TEMP%\cli-proxy-api-plus.zip!RST!
curl -L --progress-bar -o "%TEMP%\cli-proxy-api-plus.zip" "!DOWNLOAD_URL!"
REM Check if download was successful (file exists and size > 0)
if not exist "%TEMP%\cli-proxy-api-plus.zip" (
    echo !RED!      [X] Gagal download file!!RST!
    echo !YEL!      File tidak ditemukan di: %TEMP%\cli-proxy-api-plus.zip!RST!
    pause
    goto cliproxyplus_manager
)

REM Check file size
for %%A in ("%TEMP%\cli-proxy-api-plus.zip") do set "FILESIZE=%%~zA"
if "!FILESIZE!"=="" set "FILESIZE=0"
if !FILESIZE! LSS 1000000 (
    echo !RED!      [X] Download tidak lengkap atau file corrupt!!RST!
    echo !YEL!      Ukuran file: !FILESIZE! bytes ^(seharusnya ~11MB^)!RST!
    del "%TEMP%\cli-proxy-api-plus.zip" >nul 2>&1
    pause
    goto cliproxyplus_manager
)
echo !GRN!      [OK] Download selesai ^(!FILESIZE! bytes^)!RST!

REM Extract
echo !YEL!      Mengekstrak file...!RST!
if exist "%TEMP%\cli-proxy-api-plus-extract" rd /s /q "%TEMP%\cli-proxy-api-plus-extract"
mkdir "%TEMP%\cli-proxy-api-plus-extract"
powershell -NoProfile -Command "Expand-Archive -Path '%TEMP%\cli-proxy-api-plus.zip' -DestinationPath '%TEMP%\cli-proxy-api-plus-extract' -Force"

REM Find source folder (archive may have subfolder like CLIProxyAPIPlus_6.7.6-1_windows_amd64)
set "SOURCE_DIR="
for /d %%d in ("%TEMP%\cli-proxy-api-plus-extract\*") do (
    if exist "%%d\cli-proxy-api-plus.exe" set "SOURCE_DIR=%%d"
)
REM If exe not in subfolder, check root
if "!SOURCE_DIR!"=="" (
    if exist "%TEMP%\cli-proxy-api-plus-extract\cli-proxy-api-plus.exe" (
        set "SOURCE_DIR=%TEMP%\cli-proxy-api-plus-extract"
    )
)

REM Debug: show what we found
echo !WHT!      Source directory: !SOURCE_DIR!!RST!

REM Verify exe exists in source
if "!SOURCE_DIR!"=="" (
    echo !RED!      [X] File cli-proxy-api-plus.exe tidak ditemukan dalam archive!!RST!
    echo !YEL!      Isi archive:!RST!
    dir /s /b "%TEMP%\cli-proxy-api-plus-extract" 2>nul | findstr /i ".exe"
    pause
    goto cliproxyplus_manager
)

if not exist "!SOURCE_DIR!\cli-proxy-api-plus.exe" (
    echo !RED!      [X] File cli-proxy-api-plus.exe tidak ditemukan!!RST!
    pause
    goto cliproxyplus_manager
)

REM Set install directory
set "INSTALL_DIR=!CLIPROXY_DIR!"
echo !YEL!      Install target: !INSTALL_DIR!!RST!

REM Backup existing config.yaml if exists
set "CONFIG_BACKED_UP="
if exist "!INSTALL_DIR!\config.yaml" (
    echo !YEL!      Backup config.yaml...!RST!
    copy /y "!INSTALL_DIR!\config.yaml" "%TEMP%\config.yaml.backup" >nul 2>&1
    set "CONFIG_BACKED_UP=1"
)

REM Create install directory if not exists
if not exist "!INSTALL_DIR!" mkdir "!INSTALL_DIR!"

REM Copy ALL files from extracted archive to install directory
echo !YEL!      Menginstall semua file ke !INSTALL_DIR!...!RST!
xcopy /s /e /y "!SOURCE_DIR!\*" "!INSTALL_DIR!\" >nul 2>&1

REM Restore config.yaml backup if existed
if defined CONFIG_BACKED_UP (
    echo !YEL!      Restore config.yaml...!RST!
    copy /y "%TEMP%\config.yaml.backup" "!INSTALL_DIR!\config.yaml" >nul 2>&1
    del "%TEMP%\config.yaml.backup" >nul 2>&1
) else (
    REM Create optimized config.yaml if not exists (fresh install)
    if not exist "!INSTALL_DIR!\config.yaml" (
        echo !YEL!      Membuat config.yaml yang sudah dioptimasi...!RST!
        (
            echo # CLIProxyAPIPlus Configuration
            echo # OPTIMIZED FOR OPENCODE - Prevents streaming disconnections
            echo.
            echo host: ""
            echo port: 8317
            echo remote-management:
            echo   allow-remote: true
            echo   secret-key: ""
            echo   disable-control-panel: false
            echo   panel-github-repository: https://github.com/router-for-me/Cli-Proxy-API-Management-Center
            echo auth-dir: "!USERPROFILE:\=\\!\.cli-proxy-api"
            echo api-keys:
            echo   - "sk-dummy"
            echo debug: false
            echo incognito-browser: true
            echo logging-to-file: false
            echo logs-max-total-size-mb: 100
            echo usage-statistics-enabled: true
            echo proxy-url: ""
            echo request-retry: 5
            echo max-retry-interval: 120
            echo quota-exceeded:
            echo   switch-project: true
            echo   switch-preview-model: true
            echo routing:
            echo   strategy: "round-robin"
            echo ws-auth: false
            echo streaming:
            echo   keepalive-seconds: 3
            echo   bootstrap-retries: 5
            echo nonstream-keepalive-interval: 10
        ) > "!INSTALL_DIR!\config.yaml"
        echo !GRN!      [OK] config.yaml berhasil dibuat!!RST!
    )
)

REM Update detected version variable
set "CLIPROXY_PLUS_VER=N/A"
for /f "tokens=3 delims=, " %%v in ('"!INSTALL_DIR!\cli-proxy-api-plus.exe" --version 2^>nul') do (
    if "!CLIPROXY_PLUS_VER!"=="N/A" set "CLIPROXY_PLUS_VER=%%v"
)

REM Cleanup temp files
rd /s /q "%TEMP%\cli-proxy-api-plus-extract" >nul 2>&1
del "%TEMP%\cli-proxy-api-plus.zip" >nul 2>&1

echo.
echo !GRN!      [OK] CLIProxyAPIPlus berhasil diupdate ke !LATEST_VER!!RST!
echo !WHT!      Lokasi: !INSTALL_DIR!!RST!
echo !WHT!      Versi terdeteksi: !CLIPROXY_PLUS_VER!!RST!
echo.
echo !WHT!      File yang terinstall:!RST!
dir /b "!INSTALL_DIR!" 2>nul | findstr /v "^$"
echo.
pause
goto cliproxyplus_manager

:cliproxy_update_standard
cls
echo.
echo !BLU!  ========================================================================== !RST!
echo !BLU!  ::               AUTO UPDATE CLIProxyAPI Standard (Windows)             :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.

REM Fetch latest release info
echo !YEL!      Mengambil informasi release terbaru...!RST!
curl -s -H "User-Agent: FadhliAILauncher" "https://api.github.com/repos/router-for-me/CLIProxyAPI/releases/latest" > "%TEMP%\cliproxy_release.json" 2>nul

REM Get version and download URL using $env:TEMP
set "LATEST_VER="
set "DOWNLOAD_URL="
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_release.json -Raw -ErrorAction Stop | ConvertFrom-Json; $j.tag_name } catch { Write-Output '' }" 2^>nul') do set "LATEST_VER=%%a"
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_release.json -Raw -ErrorAction Stop | ConvertFrom-Json; ($j.assets | Where-Object { $_.name -like '*windows_amd64.zip' }).browser_download_url } catch { Write-Output '' }" 2^>nul') do set "DOWNLOAD_URL=%%a"

if "!LATEST_VER!"=="" (
    echo !RED!      [X] Gagal mendapatkan info release dari GitHub!!RST!
    echo !YEL!      Kemungkinan: Rate limit GitHub API atau tidak ada koneksi internet.!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

if "!DOWNLOAD_URL!"=="" (
    echo !RED!      [X] Gagal mendapatkan download URL!!RST!
    echo !YEL!      Kemungkinan: Tidak ada asset Windows untuk versi ini.!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

echo.
echo !WHT!      Versi Terbaru: !GRN!!LATEST_VER!!RST!
echo !WHT!      Download URL : !CYN!!DOWNLOAD_URL!!RST!
echo.

set /p "confirm=      Lanjutkan download dan install? [Y/N]: "
if /i not "!confirm!"=="Y" goto cliproxyplus_manager

REM Stop server if running
echo.
echo !YEL!      Menghentikan server jika sedang berjalan...!RST!
taskkill /f /im cli-proxy-api.exe >nul 2>&1

REM Download file
echo !YEL!      Mendownload !LATEST_VER!...!RST!
echo !WHT!      Target: %TEMP%\cli-proxy-api.zip!RST!
curl -L --progress-bar -o "%TEMP%\cli-proxy-api.zip" "!DOWNLOAD_URL!"

REM Check if download was successful (file exists and size > 0)
if not exist "%TEMP%\cli-proxy-api.zip" (
    echo !RED!      [X] Gagal download file!!RST!
    echo !YEL!      File tidak ditemukan di: %TEMP%\cli-proxy-api.zip!RST!
    pause
    goto cliproxyplus_manager
)

REM Check file size
for %%A in ("%TEMP%\cli-proxy-api.zip") do set "FILESIZE=%%~zA"
if "!FILESIZE!"=="" set "FILESIZE=0"
if !FILESIZE! LSS 1000000 (
    echo !RED!      [X] Download tidak lengkap atau file corrupt!!RST!
    echo !YEL!      Ukuran file: !FILESIZE! bytes ^(seharusnya ~11MB^)!RST!
    del "%TEMP%\cli-proxy-api.zip" >nul 2>&1
    pause
    goto cliproxyplus_manager
)
echo !GRN!      [OK] Download selesai ^(!FILESIZE! bytes^)!RST!

REM Extract
echo !YEL!      Mengekstrak file...!RST!
if exist "%TEMP%\cli-proxy-api-extract" rd /s /q "%TEMP%\cli-proxy-api-extract"
mkdir "%TEMP%\cli-proxy-api-extract"
powershell -NoProfile -Command "Expand-Archive -Path '%TEMP%\cli-proxy-api.zip' -DestinationPath '%TEMP%\cli-proxy-api-extract' -Force"

REM Find source folder (archive may have subfolder like CLIProxyAPI_6.7.7_windows_amd64)
set "SOURCE_DIR="
for /d %%d in ("%TEMP%\cli-proxy-api-extract\*") do (
    if exist "%%d\cli-proxy-api.exe" set "SOURCE_DIR=%%d"
)
REM If exe not in subfolder, check root
if "!SOURCE_DIR!"=="" (
    if exist "%TEMP%\cli-proxy-api-extract\cli-proxy-api.exe" (
        set "SOURCE_DIR=%TEMP%\cli-proxy-api-extract"
    )
)

REM Debug: show what we found
echo !WHT!      Source directory: !SOURCE_DIR!!RST!

REM Verify exe exists in source
if "!SOURCE_DIR!"=="" (
    echo !RED!      [X] File cli-proxy-api.exe tidak ditemukan dalam archive!!RST!
    echo !YEL!      Isi archive:!RST!
    dir /s /b "%TEMP%\cli-proxy-api-extract" 2>nul | findstr /i ".exe"
    pause
    goto cliproxyplus_manager
)

if not exist "!SOURCE_DIR!\cli-proxy-api.exe" (
    echo !RED!      [X] File cli-proxy-api.exe tidak ditemukan!!RST!
    pause
    goto cliproxyplus_manager
)

REM Get version number (strip 'v' prefix from v6.7.7)
set "VERSION_NUM=!LATEST_VER!"
if "!VERSION_NUM:~0,1!"=="v" set "VERSION_NUM=!VERSION_NUM:~1!"

REM Set install directory using version folder
set "BASE_DIR=!CLIPROXY_STANDARD_BASE!"
set "INSTALL_DIR=!BASE_DIR!\!VERSION_NUM!"
echo !YEL!      Install target: !INSTALL_DIR!!RST!

REM Create base directory if not exists
if not exist "!BASE_DIR!" mkdir "!BASE_DIR!"

REM Backup config.yaml from OLD version before deleting
set "STD_CONFIG_BACKED_UP="
for /d %%d in ("!BASE_DIR!\*.*.*") do (
    if /i not "%%~nxd"=="!VERSION_NUM!" (
        if exist "%%d\config.yaml" (
            echo !YEL!      Backup config.yaml dari versi lama ^(%%~nxd^)...!RST!
            copy /y "%%d\config.yaml" "%TEMP%\cliproxy_std_config.yaml.backup" >nul 2>&1
            set "STD_CONFIG_BACKED_UP=1"
        )
    )
)

REM Delete old version folders (keep auth, logs, static)
echo !YEL!      Menghapus versi lama...!RST!
for /d %%d in ("!BASE_DIR!\*.*.*") do (
    if /i not "%%~nxd"=="!VERSION_NUM!" (
        echo !YEL!        Hapus: %%~nxd!RST!
        rd /s /q "%%d" >nul 2>&1
    )
)

REM Create version directory
if not exist "!INSTALL_DIR!" mkdir "!INSTALL_DIR!"

REM Copy ALL files from extracted archive to install directory
echo !YEL!      Menginstall semua file ke !INSTALL_DIR!...!RST!
xcopy /s /e /y "!SOURCE_DIR!\*" "!INSTALL_DIR!\" >nul 2>&1

REM Restore backed-up config.yaml if exists
if defined STD_CONFIG_BACKED_UP (
    echo !YEL!      Restore config.yaml dari backup...!RST!
    copy /y "%TEMP%\cliproxy_std_config.yaml.backup" "!INSTALL_DIR!\config.yaml" >nul 2>&1
    del "%TEMP%\cliproxy_std_config.yaml.backup" >nul 2>&1
    echo !GRN!      [OK] config.yaml berhasil di-restore!!RST!
) else (
    REM Create optimized config.yaml if not exists (fresh install)
    if not exist "!INSTALL_DIR!\config.yaml" (
        echo !YEL!      Membuat config.yaml yang sudah dioptimasi...!RST!
        (
            echo # CLIProxyAPI Standard Configuration
            echo # Version: !VERSION_NUM!
            echo # OPTIMIZED FOR OPENCODE - Prevents streaming disconnections
            echo.
            echo host: ""
            echo port: 8317
            echo remote-management:
            echo   allow-remote: true
            echo   secret-key: ""
            echo   disable-control-panel: false
            echo   panel-github-repository: https://github.com/router-for-me/Cli-Proxy-API-Management-Center
            echo auth-dir: "!USERPROFILE:\=\\!\.cli-proxy-api"
            echo api-keys:
            echo   - "sk-dummy"
            echo debug: false
            echo logging-to-file: false
            echo logs-max-total-size-mb: 100
            echo usage-statistics-enabled: true
            echo proxy-url: ""
            echo request-retry: 5
            echo max-retry-interval: 120
            echo quota-exceeded:
            echo   switch-project: true
            echo   switch-preview-model: true
            echo routing:
            echo   strategy: "round-robin"
            echo ws-auth: false
            echo streaming:
            echo   keepalive-seconds: 3
            echo   bootstrap-retries: 5
            echo nonstream-keepalive-interval: 10
        ) > "!INSTALL_DIR!\config.yaml"
        echo !GRN!      [OK] config.yaml berhasil dibuat!!RST!
    )
)

REM Update detected version and path variables
set "CLIPROXY_STANDARD_DIR=!INSTALL_DIR!"
set "CLIPROXY_STD_VER=!VERSION_NUM!"

REM Cleanup temp files
rd /s /q "%TEMP%\cli-proxy-api-extract" >nul 2>&1
del "%TEMP%\cli-proxy-api.zip" >nul 2>&1

echo.
echo !GRN!      [OK] CLIProxyAPI Standard berhasil diupdate ke !LATEST_VER!!RST!
echo !WHT!      Lokasi: !INSTALL_DIR!!RST!
echo !WHT!      Versi: !CLIPROXY_STD_VER!!RST!
echo.
echo !WHT!      File yang terinstall:!RST!
dir /b "!INSTALL_DIR!" 2>nul | findstr /v "^$"
echo.
pause
goto cliproxyplus_manager

:cliproxy_install_other_os
cls
echo.
echo !BLU!  ========================================================================== !RST!
echo !BLU!  ::                 INSTALL UNTUK OS LAIN (Linux/macOS)                  :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      Pilih versi yang ingin diinstall:!RST!
echo.
echo !GRN!      [1]  CLIProxyAPIPlus!RST!
echo !CYN!      [2]  CLIProxyAPI Standard!RST!
echo !YEL!      [0]  Kembali!RST!
echo.

set "REPO_NAME="
set "BINARY_PREFIX="
set /p "ver_choice=      Pilih versi [0-2]: "
if "!ver_choice!"=="0" goto cliproxyplus_manager
if "!ver_choice!"=="1" (
    set "REPO_NAME=CLIProxyAPIPlus"
    set "BINARY_PREFIX=cli-proxy-api-plus"
)
if "!ver_choice!"=="2" (
    set "REPO_NAME=CLIProxyAPI"
    set "BINARY_PREFIX=cli-proxy-api"
)
if "!REPO_NAME!"=="" goto cliproxy_install_other_os

cls
echo.
echo !BLU!  ========================================================================== !RST!
echo !BLU!  ::                     PILIH SISTEM OPERASI                             :: !RST!
echo !WHT!  ========================================================================== !RST!
echo.
echo !WHT!      [1]  Linux x86_64 (AMD/Intel 64-bit)!RST!
echo !WHT!      [2]  Linux ARM64 (Raspberry Pi 4, etc)!RST!
echo !WHT!      [3]  macOS Intel (x86_64)!RST!
echo !WHT!      [4]  macOS Apple Silicon (ARM64/M1/M2/M3)!RST!
echo !WHT!      [5]  Windows x86_64 (AMD/Intel 64-bit)!RST!
echo !WHT!      [6]  Windows ARM64!RST!
echo !YEL!      [0]  Kembali!RST!
echo.

set "OS_NAME="
set "ARCH="
set "EXT="
set /p "os_choice=      Pilih OS [0-6]: "
if "!os_choice!"=="0" goto cliproxyplus_manager

REM Set OS and architecture
if "!os_choice!"=="1" set "OS_NAME=Linux" & set "ARCH=x86_64" & set "EXT=tar.gz"
if "!os_choice!"=="2" set "OS_NAME=Linux" & set "ARCH=arm64" & set "EXT=tar.gz"
if "!os_choice!"=="3" set "OS_NAME=Darwin" & set "ARCH=x86_64" & set "EXT=tar.gz"
if "!os_choice!"=="4" set "OS_NAME=Darwin" & set "ARCH=arm64" & set "EXT=tar.gz"
if "!os_choice!"=="5" set "OS_NAME=Windows" & set "ARCH=x86_64" & set "EXT=zip"
if "!os_choice!"=="6" set "OS_NAME=Windows" & set "ARCH=arm64" & set "EXT=zip"

if "!OS_NAME!"=="" goto cliproxy_install_other_os

REM Fetch latest release - save variables for PowerShell
set "REPO_URL=https://api.github.com/repos/router-for-me/!REPO_NAME!/releases/latest"
echo.
echo !YEL!      Mengambil informasi release terbaru !REPO_NAME!...!RST!
curl -s -H "User-Agent: FadhliAILauncher" "!REPO_URL!" > "%TEMP%\cliproxy_release.json" 2>nul

REM Get version using $env:TEMP
set "LATEST_VER="
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_release.json -Raw -ErrorAction Stop | ConvertFrom-Json; $j.tag_name } catch { Write-Output '' }" 2^>nul') do set "LATEST_VER=%%a"

REM Build asset name pattern
set "ASSET_PATTERN=!BINARY_PREFIX!_!OS_NAME!_!ARCH!.!EXT!"

REM Get download URL - need to pass ASSET_PATTERN to PowerShell via env var
set "SEARCH_PATTERN=!ASSET_PATTERN!"
set "DOWNLOAD_URL="
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $j=Get-Content -Path $env:TEMP\cliproxy_release.json -Raw -ErrorAction Stop | ConvertFrom-Json; $pattern=$env:SEARCH_PATTERN; ($j.assets | Where-Object { $_.name -eq $pattern }).browser_download_url } catch { Write-Output '' }" 2^>nul') do set "DOWNLOAD_URL=%%a"

if "!DOWNLOAD_URL!"=="" (
    echo !RED!      [X] File tidak ditemukan untuk !OS_NAME! !ARCH!!!RST!
    echo !YEL!      Pattern yang dicari: !ASSET_PATTERN!!RST!
    echo.
    pause
    goto cliproxyplus_manager
)

echo.
echo !WHT!      Versi    : !GRN!!LATEST_VER!!RST!
echo !WHT!      File     : !CYN!!ASSET_PATTERN!!RST!
echo !WHT!      Download : !CYN!!DOWNLOAD_URL!!RST!
echo.

REM Ask for download location
set "DOWNLOAD_DIR=%USERPROFILE%\Downloads"
set /p "custom_dir=      Folder download [default: !DOWNLOAD_DIR!]: "
if not "!custom_dir!"=="" set "DOWNLOAD_DIR=!custom_dir!"

REM Download
set "DOWNLOAD_FILE=!DOWNLOAD_DIR!\!ASSET_PATTERN!"
echo.
echo !YEL!      Mendownload ke !DOWNLOAD_FILE!...!RST!
curl -L -o "!DOWNLOAD_FILE!" "!DOWNLOAD_URL!" 2>nul

if exist "!DOWNLOAD_FILE!" (
    echo.
    echo !GRN!      [OK] Download berhasil!!RST!
    echo !WHT!      File tersimpan di: !DOWNLOAD_FILE!!RST!
    echo.
    echo !CYN!      === INSTRUKSI INSTALASI ===!RST!
    if "!OS_NAME!"=="Linux" (
        echo !WHT!      1. Transfer file ke mesin Linux!RST!
        echo !WHT!      2. Ekstrak: tar -xzf !ASSET_PATTERN!!RST!
        echo !WHT!      3. Pindahkan: sudo mv !BINARY_PREFIX! /usr/local/bin/!RST!
        echo !WHT!      4. Beri permission: sudo chmod +x /usr/local/bin/!BINARY_PREFIX!!RST!
        echo !WHT!      5. Jalankan: !BINARY_PREFIX! --help!RST!
    )
    if "!OS_NAME!"=="Darwin" (
        echo !WHT!      1. Transfer file ke Mac!RST!
        echo !WHT!      2. Ekstrak: tar -xzf !ASSET_PATTERN!!RST!
        echo !WHT!      3. Pindahkan: sudo mv !BINARY_PREFIX! /usr/local/bin/!RST!
        echo !WHT!      4. Hapus quarantine: xattr -d com.apple.quarantine /usr/local/bin/!BINARY_PREFIX!!RST!
        echo !WHT!      5. Jalankan: !BINARY_PREFIX! --help!RST!
    )
    if "!OS_NAME!"=="Windows" (
        echo !WHT!      1. Ekstrak file zip!RST!
        echo !WHT!      2. Pindahkan !BINARY_PREFIX!.exe ke folder yang diinginkan!RST!
        echo !WHT!      3. Jalankan: !BINARY_PREFIX!.exe --help!RST!
    )
) else (
    echo !RED!      [X] Gagal download file!!RST!
)
echo.
pause
goto cliproxyplus_manager
