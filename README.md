# 🖥️ GitHub Codespace with Desktop Environment

This repository is pre-configured with a **graphical desktop environment** that you can access directly in your browser or via VNC.

## 🚀 Quick Start

1. Click the green **"Code"** button on this repository
2. Select **"Codespaces"** tab
3. Click **"Create codespace on main"**
4. Wait for the container to build (~2-3 minutes first time)

## 🖼️ Accessing the Desktop

### Method 1: Browser (Recommended)
1. Open the **Ports** tab in VS Code
2. Click the 🌐 globe icon next to port **6080**
3. Enter password: `vscode`

### Method 2: VNC Client
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

- **Desktop Lite**: Lightweight Fluxbox window manager
- **noVNC**: Web-based VNC client on port 6080
- **VNC Server**: Traditional VNC access on port 5901
- **Universal Dev Container**: Pre-installed with common development tools

## 🔧 Customization

Edit `.devcontainer/devcontainer.json` to:
- Change the VNC password
- Add more development tools
- Install additional VS Code extensions
- Modify port configurations

## 📚 Resources

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Dev Containers Features](https://containers.dev/features)
- [Desktop Lite Feature](https://github.com/devcontainers/features/tree/main/src/desktop-lite)

---

**Default Password**: `vscode`
