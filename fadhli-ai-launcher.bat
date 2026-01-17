@echo off
setlocal EnableDelayedExpansion
chcp 437 >nul 2>&1
title Fadhli AI Code Assistant Launcher

REM Dynamic paths based on current user - works for any Windows user
set "SETTINGS_FILE=%USERPROFILE%\.claude\settings.json"
set "CLIPROXY_DIR=%USERPROFILE%\cliproxyapiplus"
set "CLIPROXY_STANDARD_DIR=%USERPROFILE%\cliproxyapi\6.7.5"
set "CLOUDFLARED_EXE="
REM Detect cloudflared.exe location
if exist "C:\Program Files (x86)\cloudflared\cloudflared.exe" set "CLOUDFLARED_EXE=C:\Program Files (x86)\cloudflared\cloudflared.exe"
if exist "C:\Program Files\Cloudflared\cloudflared.exe" set "CLOUDFLARED_EXE=C:\Program Files\Cloudflared\cloudflared.exe"

REM ============================================================================
REM CLOUDFLARE TUNNEL SETTINGS - EDIT THIS SECTION FOR YOUR OWN DOMAIN!
REM ============================================================================
set "TUNNEL_NAME=fadproxy"
set "TUNNEL_DOMAIN=api.fadproxy.my.id"
REM ============================================================================

REM Create ESC character for ANSI colors
for /F "delims=" %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"

REM Define colors
set "RED=!ESC![91m"
set "GRN=!ESC![92m"
set "YEL=!ESC![93m"
set "CYN=!ESC![96m"
set "WHT=!ESC![97m"
set "RST=!ESC![0m"

:main_menu
cls
echo.
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::   ######   ###   ####   ##   ## ##      ##      ######  ##         :: !RST!
echo !RED!  ::   ##      ## ##  ##  ## ##   ## ##      ##        ##    ##         :: !RST!
echo !RED!  ::   #####  ####### ##  ## ####### ##      ##        ##    ##         :: !RST!
echo !RED!  ::   ##     ##   ## ##  ## ##   ## ##      ##        ##    ##         :: !RST!
echo !RED!  ::   ##     ##   ## ####   ##   ## ######  ######  ######  ######     :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::                  AI CODE ASSISTANT LAUNCHER                        :: !RST!
echo !RED!  ::                          by Fadhli                                 :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ======================================================================== !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    [1]   Claude Code              -   Anthropic AI Assistant       :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    [2]   Factory Droid            -   Factory AI Agent             :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    [3]   OpenCode                 -   Open Source AI Coder         :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    [4]   CLIProxyAPIPlus Manager  -   Copilot, Kiro, Gemini        :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    [5]   Keluar                                                    :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.

set /p "choice=        Pilih AI Assistant [1-5]: "

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
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::          #####  ##      ###   ##   ## ####   #####                 :: !RST!
echo !RED!  ::         ##      ##     ## ##  ##   ## ##  ## ##                    :: !RST!
echo !RED!  ::         ##      ##    ####### ##   ## ##  ## #####                 :: !RST!
echo !RED!  ::         ##      ##    ##   ## ##   ## ##  ## ##                    :: !RST!
echo !RED!  ::          #####  ##### ##   ##  #####  ####   #####                 :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::                     CLAUDE CODE LAUNCHER                           :: !RST!
echo !RED!  ::                          by Fadhli                                 :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ======================================================================== !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::                     PILIH FOLDER PROJECT                           :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.
echo !WHT!      Membuka dialog pemilihan folder...!RST!

for /f "delims=" %%i in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.FolderBrowserDialog; $d.Description = 'Pilih folder project untuk Claude Code'; $d.ShowNewFolderButton = $true; if ($d.ShowDialog() -eq 'OK') { $d.SelectedPath } else { '' }"') do set "PROJECT_PATH=%%i"

if "!PROJECT_PATH!"=="" (
    echo !RED!      [X] Tidak ada folder yang dipilih!RST!
    pause
    goto main_menu
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
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::           ####   ####    ###   ##  ####                            :: !RST!
echo !RED!  ::           ##  ## ##  ## ## ##  ## ##  ##                           :: !RST!
echo !RED!  ::           ##  ## ####   ## ##  ## ##  ##                           :: !RST!
echo !RED!  ::           ##  ## ##  ## ## ##  ## ##  ##                           :: !RST!
echo !RED!  ::           ####   ##  ##  ###   ## ####                             :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::                    FACTORY AI DROID                                :: !RST!
echo !RED!  ::                        by Fadhli                                   :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ======================================================================== !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::                     PILIH FOLDER PROJECT                           :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::    ####   ####   #####  ##   ##  #####  ####   ####   #####        :: !RST!
echo !RED!  ::   ##  ## ##  ## ##     ####  ## ##     ##  ## ##  ## ##            :: !RST!
echo !RED!  ::   ##  ## ####   #####  ## ## ## ##     ##  ## ##  ## #####         :: !RST!
echo !RED!  ::   ##  ## ##     ##     ##  #### ##     ##  ## ##  ## ##            :: !RST!
echo !RED!  ::    ####  ##     #####  ##   ###  ##### ####   ####   #####         :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::                        OPENCODE AI                                 :: !RST!
echo !RED!  ::                         by Fadhli                                  :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ======================================================================== !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::                     PILIH FOLDER PROJECT                           :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::    #####  ##     ##  ####   ####    ###   ##  ## ##   ##           :: !RST!
echo !RED!  ::   ##      ##     ## ##  ## ##  ##  ## ##   ## ##   ## ##           :: !RST!
echo !RED!  ::   ##      ##     ## ####   ####   ## ##     ###     ###            :: !RST!
echo !RED!  ::   ##      ##     ## ##     ##  ## ## ##    ## ##     ##            :: !RST!
echo !RED!  ::    #####  ###### ## ##     ##  ##  ###    ##  ##    ##             :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ::              CLIProxyAPIPlus MANAGER v6.7.5-0                      :: !RST!
echo !RED!  ::           GitHub Copilot + Kiro + Gemini + Codex                   :: !RST!
echo !RED!  ::                        by Fadhli                                   :: !RST!
echo !RED!  ::                                                                    :: !RST!
echo !RED!  ======================================================================== !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    === AKUN MANAGEMENT ===                                         :: !RST!
echo !WHT!  ::    [1]   Lihat Semua Akun                                          :: !RST!
echo !WHT!  ::    [2]   Hapus Akun                                                :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !GRN!  ::    === LOGIN PROVIDER ===                                          :: !RST!
echo !GRN!  ::    [3]   Login GitHub Copilot           [Device Flow]              :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !CYN!  ::    === KIRO (AWS CodeWhisperer) ===                                :: !RST!
echo !CYN!  ::    [4]   Kiro - Google OAuth            [Browser]                  :: !RST!
echo !CYN!  ::    [5]   Kiro - AWS Builder ID          [Auth Code - Recommended]  :: !RST!
echo !CYN!  ::    [6]   Kiro - Import dari IDE         [Auto - Best Method]       :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !YEL!  ::    === OTHER PROVIDERS ===                                         :: !RST!
echo !YEL!  ::    [7]   Login Google/Antigravity       [Browser]                  :: !RST!
echo !YEL!  ::    [8]   Login ChatGPT/Codex            [Browser]                  :: !RST!
echo !YEL!  ::    [9]   Login Claude                   [Browser]                  :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    === SERVER ===                                                  :: !RST!
echo !WHT!  ::    [10]  Start CLIProxyAPIPlus Server      [Port 8317]              :: !RST!
echo !WHT!  ::    [11]  Lihat Model Tersedia                                      :: !RST!
echo !WHT!  ::    [12]  Buka Dashboard Management         [Web Browser]           :: !RST!
echo !WHT!  ::    [13]  Hentikan Server Port 8317                                 :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !CYN!  ::    === CLIPROXY STANDARD (Non-Plus) ===                            :: !RST!
echo !CYN!  ::    [14]  Start CLIProxyAPI Standard Server [Port 8317 - v6.7.5]    :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !MAG!  ::    === CLOUDFLARE TUNNEL (Remote Access) ===                       :: !RST!
echo !MAG!  ::    [15]  Start Cloudflare Tunnel            [api.fadproxy.my.id]   :: !RST!
echo !MAG!  ::    [16]  Stop Cloudflare Tunnel                                    :: !RST!
echo !MAG!  ::    [17]  Cek Status Tunnel                                         :: !RST!
echo !MAG!  ::    [18]  Install Tunnel as Windows Service  [Auto-Start]           :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ::    [0]   Kembali ke Menu Utama                                     :: !RST!
echo !WHT!  ::                                                                    :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.

set /p "ag_choice=      Pilih opsi [0-18]: "

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

goto cliproxyplus_manager

:list_accounts
cls
echo.
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                        DAFTAR SEMUA AKUN                           :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.
echo !WHT!      Lokasi: C:\Users\FADHLI\.cli-proxy-api\!RST!
echo.
dir /b "C:\Users\FADHLI\.cli-proxy-api\*.json" 2>nul
if errorlevel 1 echo !RED!      [Tidak ada akun tersimpan]!RST!
echo.
pause
goto cliproxyplus_manager

:login_github_copilot
cls
echo.
echo !GRN!  ======================================================================== !RST!
echo !GRN!  ::                      LOGIN GITHUB COPILOT                          :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !CYN!  ======================================================================== !RST!
echo !CYN!  ::                   LOGIN KIRO - GOOGLE OAUTH                        :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !CYN!  ======================================================================== !RST!
echo !CYN!  ::                  LOGIN KIRO - AWS BUILDER ID                       :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !CYN!  ======================================================================== !RST!
echo !CYN!  ::                  IMPORT TOKEN KIRO DARI IDE                        :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !YEL!  ======================================================================== !RST!
echo !YEL!  ::                  LOGIN GOOGLE - ANTIGRAVITY                        :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !YEL!  ======================================================================== !RST!
echo !YEL!  ::                 TAMBAH AKUN CHATGPT - CODEX                        :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !YEL!  ======================================================================== !RST!
echo !YEL!  ::                         LOGIN CLAUDE                               :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                           HAPUS AKUN                               :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.
echo !WHT!      Akun yang tersedia:!RST!
echo.
dir /b "C:\Users\FADHLI\.cli-proxy-api\*.json" 2>nul
if errorlevel 1 (
    echo !RED!      [Tidak ada akun tersimpan]!RST!
    pause
    goto cliproxyplus_manager
)
echo.
echo !WHT!      Untuk menghapus, buka folder dan hapus file JSON secara manual:!RST!
echo !YEL!      C:\Users\FADHLI\.cli-proxy-api\!RST!
echo.
start explorer "C:\Users\FADHLI\.cli-proxy-api"
pause
goto cliproxyplus_manager

:start_server
cls
echo.
echo !GRN!  ======================================================================== !RST!
echo !GRN!  ::                  START CLIPROXYAPIPLUS SERVER                      :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.

REM Check if port 8317 is already in use
set "PORT_IN_USE="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8317" ^| findstr "LISTENING" 2^>nul') do (
    set "PORT_IN_USE=%%a"
)

if defined PORT_IN_USE (
    echo.
    echo !RED!  ======================================================================== !RST!
    echo !RED!  ::                   PORT 8317 SUDAH DIGUNAKAN                        :: !RST!
    echo !WHT!  ======================================================================== !RST!
    echo !WHT!  ::                                                                    :: !RST!
    echo !YEL!  ::      Port 8317 sedang digunakan oleh proses lain.                  :: !RST!
    echo !YEL!  ::      PID: !PORT_IN_USE!                                                            :: !RST!
    echo !WHT!  ::                                                                    :: !RST!
    echo !WHT!  ::      [1] Hentikan proses dan lanjutkan start server                :: !RST!
    echo !WHT!  ::      [2] Kembali ke menu                                           :: !RST!
    echo !WHT!  ::                                                                    :: !RST!
    echo !WHT!  ======================================================================== !RST!
    echo.
    set /p "port_choice=      Pilih [1-2]: "
    
    if "!port_choice!"=="1" (
        echo.
        echo !YEL!      Menghentikan proses PID: !PORT_IN_USE!...!RST!
        taskkill /F /PID !PORT_IN_USE! >nul 2>&1
        if !errorlevel! equ 0 (
            echo !GRN!      [OK] Proses berhasil dihentikan!!RST!
            timeout /t 2 >nul
        ) else (
            echo !RED!      [X] Gagal menghentikan proses. Coba jalankan sebagai Administrator.!RST!
            pause
            goto cliproxyplus_manager
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
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                       MODEL YANG TERSEDIA                          :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !GRN!  ======================================================================== !RST!
echo !GRN!  ::                 CLIPROXY DASHBOARD MANAGEMENT                      :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !RED!  ======================================================================== !RST!
echo !RED!  ::                   HENTIKAN SERVER PORT 8317                        :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !CYN!  ======================================================================== !RST!
echo !CYN!  ::                START CLIPROXYAPI STANDARD v6.7.5                   :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.

REM Check if port 8317 is already in use (same port as Plus)
set "PORT_STD_IN_USE="
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8317" ^| findstr "LISTENING" 2^>nul') do (
    set "PORT_STD_IN_USE=%%a"
)

if defined PORT_STD_IN_USE (
    echo.
    echo !RED!  ======================================================================== !RST!
    echo !RED!  ::                   PORT 8317 SUDAH DIGUNAKAN                        :: !RST!
    echo !WHT!  ======================================================================== !RST!
    echo !WHT!  ::                                                                    :: !RST!
    echo !YEL!  ::      Port 8317 sedang digunakan oleh proses lain.                  :: !RST!
    echo !YEL!  ::      Kemungkinan CLIProxyAPIPlus sedang berjalan.                  :: !RST!
    echo !YEL!  ::      PID: !PORT_STD_IN_USE!                                                            :: !RST!
    echo !WHT!  ::                                                                    :: !RST!
    echo !WHT!  ::      [1] Hentikan proses dan lanjutkan start Standard server       :: !RST!
    echo !WHT!  ::      [2] Kembali ke menu                                           :: !RST!
    echo !WHT!  ::                                                                    :: !RST!
    echo !WHT!  ======================================================================== !RST!
    echo.
    set /p "port_std_choice=      Pilih [1-2]: "
    
    if "!port_std_choice!"=="1" (
        echo.
        echo !YEL!      Menghentikan proses PID: !PORT_STD_IN_USE!...!RST!
        taskkill /F /PID !PORT_STD_IN_USE! >nul 2>&1
        if !errorlevel! equ 0 (
            echo !GRN!      [OK] Proses berhasil dihentikan!!RST!
            timeout /t 2 >nul
        ) else (
            echo !RED!      [X] Gagal menghentikan proses. Coba jalankan sebagai Administrator.!RST!
            pause
            goto cliproxyplus_manager
        )
    ) else (
        goto cliproxyplus_manager
    )
)

echo !WHT!      Server Standard akan berjalan di port 8317...!RST!
echo !WHT!      Tekan Ctrl+C untuk menghentikan server.!RST!
echo.
echo !CYN!      Version: v6.7.4 - Standard Edition!RST!
echo !YEL!      [!] Catatan: CLIProxyAPIPlus dan Standard menggunakan port yang sama!RST!
echo !YEL!          Hanya SATU yang bisa berjalan dalam satu waktu!!RST!
echo.
cd /d "!CLIPROXY_STANDARD_DIR!"
cli-proxy-api.exe
pause
goto cliproxyplus_manager

REM ============================================================================
REM CLOUDFLARE TUNNEL FUNCTIONS
REM ============================================================================

:start_tunnel
cls
echo.
echo !MAG!  ======================================================================== !RST!
echo !MAG!  ::              START CLOUDFLARE TUNNEL                               :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.
echo !WHT!      Domain: api.fadproxy.my.id!RST!
echo !WHT!      Domain: !TUNNEL_DOMAIN!!RST!
echo.

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
echo !MAG!  ======================================================================== !RST!
echo !MAG!  ::              STOP CLOUDFLARE TUNNEL                                :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !MAG!  ======================================================================== !RST!
echo !MAG!  ::              STATUS CLOUDFLARE TUNNEL                              :: !RST!
echo !WHT!  ======================================================================== !RST!
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
echo !MAG!  ======================================================================== !RST!
echo !MAG!  ::        INSTALL TUNNEL AS WINDOWS SERVICE                           :: !RST!
echo !WHT!  ======================================================================== !RST!
echo.
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
