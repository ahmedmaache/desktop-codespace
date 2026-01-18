# 🖥️ GitHub Codespace with Desktop Environment (RDP/VNC)

This repository is pre-configured with a **graphical desktop environment** that you can access via **RDP**, VNC, or directly in your browser.

## 🚀 Quick Start

1. Click the green **"Code"** button on this repository
2. Select **"Codespaces"** tab
3. Click **"Create codespace on main"**
4. Wait for the container to build (~3-5 minutes first time)

## 🖼️ Accessing the Desktop

### Method 1: RDP (Recommended for Windows)
This is the best experience on Windows using the built-in Remote Desktop Connection.

1. Forward port 3389 to a **different local port** (3390) to avoid conflict with Windows:
   ```powershell
   gh codespace ports forward 3390:3389 -c <codespace-name>
   ```
2. Open **Remote Desktop Connection** (`mstsc.exe`)
3. Connect to: `localhost:3390` ⚠️ Note: use 3390, NOT 3389!
4. Username: `codespace`
5. Password: `vscode`

### Method 2: Browser (No Setup Required)
1. Open the **Ports** tab in VS Code
2. Click the 🌐 globe icon next to port **6080**
3. Enter password: `vscode`

### Method 3: VNC Client
1. Forward port 5901 to your local machine
2. Connect your VNC client to `localhost:5901`
3. Enter password: `vscode`

## 🔐 SSH Access

To SSH into your Codespace from your local terminal:

```bash
# Configure SSH (one-time setup)
gh codespace ssh --config

# List your codespaces
gh codespace list

# Connect via SSH
ssh <codespace-name>
```

## 📁 What's Included

- **XFCE4**: Lightweight and fast desktop environment
- **XRDP**: Remote Desktop Protocol server on port 3389
- **noVNC**: Web-based VNC client on port 6080
- **VNC Server**: Traditional VNC access on port 5901
- **Universal Dev Container**: Pre-installed with common development tools

## 🔧 Available Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 3389 | RDP | Remote Desktop (best for Windows) |
| 6080 | HTTP | noVNC web client (browser access) |
| 5901 | VNC | Traditional VNC client |

## 📚 Resources

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Dev Containers Features](https://containers.dev/features)
- [Desktop Lite Feature](https://github.com/devcontainers/features/tree/main/src/desktop-lite)

---

**Default Password**: `vscode`

