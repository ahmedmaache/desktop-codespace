#!/bin/bash

# Install XRDP and XFCE4 desktop
echo "📦 Installing XRDP and XFCE4..."
sudo apt-get update
sudo apt-get install -y xrdp xfce4 xfce4-goodies dbus-x11 xorg

# Configure XRDP
echo "⚙️ Configuring XRDP..."

# Set port to 3389
sudo sed -i 's/^port=.*/port=3389/' /etc/xrdp/xrdp.ini

# Configure XRDP to use Xvnc backend (more compatible)
sudo sed -i 's/^#xserverbpp=24/xserverbpp=24/' /etc/xrdp/xrdp.ini

# Allow multiple sessions
sudo sed -i 's/^max_bpp=.*/max_bpp=24/' /etc/xrdp/xrdp.ini

# Create startwm.sh for XFCE
cat << 'STARTWM' | sudo tee /etc/xrdp/startwm.sh
#!/bin/sh
# xrdp X session start script
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

# Start XFCE4
exec startxfce4
STARTWM

sudo chmod +x /etc/xrdp/startwm.sh

# Create user .xsession
echo "startxfce4" > ~/.xsession
chmod +x ~/.xsession

# Fix permissions
sudo adduser xrdp ssl-cert 2>/dev/null || true

# Set password for current user (for RDP login)
echo "codespace:vscode" | sudo chpasswd

# Restart XRDP
echo "🔄 Restarting XRDP..."
sudo pkill xrdp 2>/dev/null || true
sudo /usr/sbin/xrdp

echo "✅ XRDP setup complete!"
echo "📡 RDP available on port 3389"
echo "👤 Username: codespace"
echo "🔑 Password: vscode"
