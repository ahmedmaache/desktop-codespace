#!/bin/sh
echo "🔧 Starting Nuclear Repair for Alpine RDP..."

# 1. Install Dependencies (TigerVNC is critical for Xvnc)
echo "📦 Installing packages..."
sudo apk update
sudo apk add xrdp tigervnc xfce4 xfce4-terminal xfce4-screensaver dbus-x11 xorg-server xf86-video-dummy openssl sudo

# 2. Configure Users
echo "👤 Configuring users..."
# Set root password
echo "root:vscode" | sudo chpasswd
# Set vscode password
echo "vscode:vscode" | sudo chpasswd

# 3. Configure XRDP (ini files)
echo "⚙️ Configuring XRDP..."

# xrdp.ini - minimalistic valid config
cat <<EOF | sudo tee /etc/xrdp/xrdp.ini
[Globals]
port=3389
crypt_level=high
security_layer=rdp
bitmap_cache=yes
bitmap_compression=yes
bulk_compression=yes
max_bpp=24
new_cursors=true
allow_channels=true
allow_multimon=true
bitmap_fonts=yes
allow_video_redirect=false
allow_raw_bitmaps=true
fastboot=true

[logging]
LogFile=xrdp.log
LogLevel=DEBUG
EnableSyslog=true
SyslogLevel=DEBUG

[channels]
rdpdr=true
rdpsnd=true
drdynvc=true
cliprdr=true
rail=true
xrdpvr=true
tcutils=true

[Xvnc]
name=Xvnc
lib=libvnc.so
username=ask
password=ask
ip=127.0.0.1
port=-1
#xserverbpp=24
delay_ms=2000
EOF

# sesman.ini - AllowRootLogin=true is key here
cat <<EOF | sudo tee /etc/xrdp/sesman.ini
[Globals]
ListenAddress=127.0.0.1
ListenPort=3350
EnableUserWindowManager=true
UserWindowManager=startwm.sh
DefaultWindowManager=startwm.sh

[Security]
AllowRootLogin=true
MaxLoginRetry=4
TerminalServerUsers=tsusers
TerminalServerAdmins=tsadmins
AlwaysGroupCheck=false

[Sessions]
X11DisplayOffset=10
MaxSessions=50
KillDisconnected=false
DisconnectedTimeLimit=0
IdleTimeLimit=0
Policy=Default

[Xvnc]
param=Xvnc
param=-bs
param=-nolisten
param=tcp
param=-localhost
param=-dpi
param=96

[Logging]
LogFile=xrdp-sesman.log
LogLevel=DEBUG
EnableSyslog=true
SyslogLevel=DEBUG
EOF

# 4. Certificates
echo "🔑 Generating Keys..."
if [ ! -f /etc/xrdp/cert.pem ]; then
    sudo openssl req -x509 -newkey rsa:2048 -nodes -keyout /etc/xrdp/key.pem -out /etc/xrdp/cert.pem -days 365 -subj "/CN=localhost"
fi
sudo chmod 600 /etc/xrdp/key.pem

# 5. Startup Script
echo "📝 Creating startup scripts..."
cat <<EOF | sudo tee /etc/xrdp/startwm.sh
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
# Alpine specific dbus launch
if [ -x /usr/bin/dbus-launch ]; then
  eval \$(dbus-launch --sh-syntax)
fi
exec startxfce4
EOF
sudo chmod +x /etc/xrdp/startwm.sh

# Ensure .xsession exists for root and vscode
echo "startxfce4" | sudo tee /root/.xsession
sudo chmod +x /root/.xsession
echo "startxfce4" > /home/vscode/.xsession
chmod +x /home/vscode/.xsession

# 6. Cleanup and Restart
echo "🧹 Cleaning up..."
sudo pkill xrdp
sudo pkill Xvnc
sudo rm -rf /var/run/xrdp*.pid /tmp/.X11-unix /tmp/.X*-lock

echo "🚀 Starting Services..."
sudo mkdir -p /var/run/xrdp
sudo chmod 777 /var/run/xrdp
sudo /usr/sbin/xrdp-sesman
sudo /usr/sbin/xrdp

echo "✅ DONE! Connect to localhost:13389 as root/vscode"
