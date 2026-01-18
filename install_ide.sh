#!/bin/sh
echo "📦 Installing Desktop Tools..."

# 1. Enable Community Repositories (if not enabled)
grep -q "http://dl-cdn.alpinelinux.org/alpine/v3.22/community" /etc/apk/repositories || echo "http://dl-cdn.alpinelinux.org/alpine/v3.22/community" | sudo tee -a /etc/apk/repositories

# 2. Update and Install Chromium & VS Code (Code-OSS)
sudo apk update
sudo apk add chromium code-oss bash

# 3. Create Desktop Shortcuts Directory
mkdir -p /home/vscode/Desktop
chmod 755 /home/vscode/Desktop

# 4. Create Chromium Shortcut
cat <<EOF > /home/vscode/Desktop/chromium.desktop
[Desktop Entry]
Version=1.0
Name=Chromium
Comment=Access the Internet
Exec=/usr/bin/chromium-browser --no-sandbox
Icon=chromium
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOF
chmod +x /home/vscode/Desktop/chromium.desktop

# 5. Create VS Code Shortcut
cat <<EOF > /home/vscode/Desktop/code.desktop
[Desktop Entry]
Version=1.0
Name=VS Code
Comment=Code Editor
Exec=/usr/bin/code-oss --no-sandbox --unity-launch %F
Icon=code-oss
Terminal=false
Type=Application
Categories=Development;IDE;
EOF
chmod +x /home/vscode/Desktop/code.desktop

echo "✅ Installation Complete!"
echo "desktop icons created for Chromium and VS Code."
