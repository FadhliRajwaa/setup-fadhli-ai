# Fadhli AI Code Assistant Launcher

```
  ███████╗ █████╗ ██████╗ ██╗  ██╗██╗     ██╗
  ██╔════╝██╔══██╗██╔══██╗██║  ██║██║     ██║
  █████╗  ███████║██║  ██║███████║██║     ██║
  ██╔══╝  ██╔══██║██║  ██║██╔══██║██║     ██║
  ██║     ██║  ██║██████╔╝██║  ██║███████╗██║
  ╚═╝     ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝
           AI CODE ASSISTANT LAUNCHER
```

[![Windows](https://img.shields.io/badge/Platform-Windows-0078D6?style=flat-square&logo=windows)](https://www.microsoft.com/windows)
[![Batch Script](https://img.shields.io/badge/Script-Batch-4EAA25?style=flat-square)](https://en.wikipedia.org/wiki/Batch_file)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)

All-in-One Launcher untuk berbagai AI Coding Assistant dengan dukungan Multi-Provider API Proxy.

---

## Overview

**Fadhli AI Launcher** adalah unified command-line launcher untuk mengelola dan menjalankan berbagai AI coding assistant dari satu tempat. Dilengkapi dengan **CLIProxyAPIPlus Manager** yang mendukung multiple AI providers melalui single OpenAI-compatible API endpoint.

### Fitur Utama

- **Unified Launcher** - Claude Code, Factory Droid, OpenCode dalam satu interface
- **Multi-Provider Proxy** - GitHub Copilot, Kiro, Gemini, Codex, Claude via single API
- **Remote Access** - Built-in Cloudflare Tunnel untuk akses dari mana saja
- **Dynamic Path** - Auto-detect user profile, works out of the box
- **Port Management** - Auto-detect dan handle port conflicts

---

## Supported AI Assistants

| Assistant | Description | Command |
|-----------|-------------|---------|
| Claude Code | Anthropic AI Coding Assistant | `claude` |
| Factory Droid | Factory AI Agent | `droid` |
| OpenCode | Open Source AI Coder | `opencode` |

---

## CLIProxyAPIPlus Integration

Launcher ini terintegrasi dengan [CLIProxyAPIPlus](https://github.com/router-for-me/CLIProxyAPIPlus) untuk menyediakan unified API proxy.

### Arsitektur

```
+-------------------+
|  GitHub Copilot   |----+
+-------------------+    |
+-------------------+    |     +---------------------+     +------------------+
|  Kiro (AWS CW)    |----+     |                     |     |                  |
+-------------------+    +---->|  CLIProxyAPIPlus    |---->|  OpenAI API      |
+-------------------+    |     |  Port 8317          |     |  Compatible      |
|  Gemini           |----+     |                     |     |                  |
+-------------------+    |     +---------------------+     +------------------+
+-------------------+    |
|  ChatGPT/Codex    |----+
+-------------------+    |
+-------------------+    |
|  Claude           |----+
+-------------------+
```

### Supported Providers

| Provider | Login Method | Description |
|----------|--------------|-------------|
| GitHub Copilot | Device Flow | Code completion, Chat |
| Kiro (AWS CodeWhisperer) | Google OAuth / AWS Builder ID | Code completion, Security scans |
| Gemini (Antigravity) | Google OAuth | Google AI models |
| ChatGPT / Codex | Browser Login | OpenAI GPT models |
| Claude | Browser Login | Anthropic Claude models |

---

## Installation

### Prerequisites

- Windows 10/11 (x64)
- PowerShell 5.1+
- Node.js (untuk AI assistants)

### Required Components

```powershell
# Claude Code
npm install -g @anthropic-ai/claude-code

# OpenCode
npm install -g opencode

# CLIProxyAPIPlus
# Download dari: https://github.com/router-for-me/CLIProxyAPIPlus
# Extract ke: %USERPROFILE%\cliproxyapiplus
```

### Optional: Cloudflare Tunnel

```powershell
winget install Cloudflare.cloudflared
```

### Quick Start

```batch
git clone https://github.com/yourusername/fadhli-ai-launcher.git
cd fadhli-ai-launcher
fadhli-ai-launcher.bat
```

---

## Usage

### Main Menu

```
  ========================================================================
  ::                  AI CODE ASSISTANT LAUNCHER                        ::
  ========================================================================
  ::                                                                    ::
  ::    [1]   Claude Code              -   Anthropic AI Assistant       ::
  ::    [2]   Factory Droid            -   Factory AI Agent             ::
  ::    [3]   OpenCode                 -   Open Source AI Coder         ::
  ::    [4]   CLIProxyAPIPlus Manager  -   Copilot, Kiro, Gemini        ::
  ::    [5]   Keluar                                                    ::
  ::                                                                    ::
  ========================================================================
```

### Launching AI Assistant

1. Pilih AI assistant (1-3)
2. Dialog folder picker akan muncul
3. Pilih project folder
4. AI assistant akan launch di folder tersebut

### CLIProxyAPIPlus Manager

Menu `[4]` membuka proxy manager dengan opsi:

**Account Management**
- Lihat semua akun tersimpan
- Hapus akun

**Login Providers**
- GitHub Copilot (Device Flow)
- Kiro - Google OAuth
- Kiro - AWS Builder ID
- Kiro - Import dari IDE
- Google/Antigravity
- ChatGPT/Codex
- Claude

**Server Management**
- Start/Stop server (Port 8317)
- Lihat model tersedia
- Dashboard management

**Cloudflare Tunnel**
- Start/Stop tunnel
- Status check
- Install as Windows Service

---

## API Usage

Setelah server berjalan di port 8317:

```bash
# List available models
curl http://127.0.0.1:8317/v1/models \
  -H "Authorization: Bearer sk-dummy"

# Chat completion
curl http://127.0.0.1:8317/v1/chat/completions \
  -H "Authorization: Bearer sk-dummy" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "Hello"}]
  }'
```

---

## Cloudflare Tunnel Setup

### Configuration

Edit bagian berikut di `fadhli-ai-launcher.bat`:

```batch
set "TUNNEL_NAME=your-tunnel-name"
set "TUNNEL_DOMAIN=api.yourdomain.com"
```

### Setup Steps

1. Create tunnel: `cloudflared tunnel create <tunnel-name>`
2. Configure DNS route di Cloudflare Dashboard
3. Update configuration di launcher
4. Start tunnel dari menu [15]

### Auto-Start Service

Menu [18] untuk install sebagai Windows Service - tunnel akan otomatis start saat Windows boot.

---

## Directory Structure

```
%USERPROFILE%/
├── cliproxyapiplus/           # CLIProxyAPIPlus installation
│   └── cli-proxy-api-plus.exe
├── cliproxyapi/6.7.5/         # Standard CLIProxyAPI
│   └── cli-proxy-api.exe
├── .cli-proxy-api/            # Saved accounts (JSON)
└── .claude/
    └── settings.json          # Claude Code settings
```

---

## Troubleshooting

### Port 8317 Already in Use

Launcher otomatis mendeteksi port conflict dan menawarkan opsi untuk menghentikan proses yang sedang menggunakan port tersebut.

### Cloudflared Not Found

Pastikan cloudflared terinstall di salah satu lokasi:
- `C:\Program Files (x86)\cloudflared\cloudflared.exe`
- `C:\Program Files\Cloudflared\cloudflared.exe`

### Login Issues

1. Pastikan browser sudah login ke akun yang sesuai
2. Clear browser cache jika diperlukan
3. Untuk Kiro, gunakan method "Import dari IDE" sebagai alternatif

---

## License

MIT License - see [LICENSE](LICENSE) for details.

---

## Acknowledgments

- [Anthropic](https://anthropic.com) - Claude AI
- [GitHub Copilot](https://github.com/features/copilot)
- [AWS CodeWhisperer](https://aws.amazon.com/codewhisperer/)
- [CLIProxyAPIPlus](https://github.com/router-for-me/CLIProxyAPIPlus) - API Proxy
- [Cloudflare](https://cloudflare.com) - Tunnel Infrastructure

---

**Author:** Fadhli
