#!/bin/bash
set -e

echo "🚀 Starting Ubuntu Setup..."

# 1. Install Updates and Essentials
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y curl wget git xfce4 xfce4-goodies xrdp chromium-browser dbus-x11 xorg

# 2. Configure XRDP for Ubuntu
echo "⚙️ Configuring XRDP..."
sudo sed -i 's/^port=.*/port=3389/' /etc/xrdp/xrdp.ini
echo "xfce4-session" > ~/.xsession
sudo echo "xfce4-session" > /root/.xsession
sudo adduser xrdp ssl-cert
sudo systemctl enable xrdp

# 3. Install Antigravity (DEB method)
echo "📦 Installing Antigravity..."
sudo mkdir -p /etc/apt/keyrings

# Try to fetch key (skipping error if URL is unreachable/internal)
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg || echo "⚠️ Warning: Antigravity key fetch failed (network issue?)"

echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  sudo tee /etc/apt/sources.list.d/antigravity.list

sudo apt-get update || echo "⚠️ Repository update failed (check access)"
sudo apt-get install -y antigravity || echo "⚠️ Antigravity install failed (check repo access)"

# 4. Set Passwords
echo "vscode:vscode" | sudo chpasswd
echo "root:vscode" | sudo chpasswd

# 5. Create Desktop Shortcuts
mkdir -p ~/Desktop
cat <<EOF > ~/Desktop/Chromium.desktop
[Desktop Entry]
Version=1.0
Name=Chromium
Exec=chromium-browser --no-sandbox
Icon=chromium-browser
Terminal=false
Type=Application
EOF
chmod +x ~/Desktop/Chromium.desktop

echo "✅ Ubuntu Setup Complete! Rebuild now."
