#!/bin/bash
# Uninstall welcome daemon script

echo "🗑️  Uninstalling welcome daemon..."

# Unload the daemon
if sudo launchctl list | grep -q "com.henok.welcome"; then
    echo "Stopping daemon..."
    sudo launchctl stop com.henok.welcome 2>/dev/null
    sudo launchctl unload /Library/LaunchDaemons/com.henok.welcome.plist 2>/dev/null
    echo "✓ Daemon stopped"
fi

# Remove files
echo "Removing files..."
sudo rm -f /usr/local/bin/welcome
sudo rm -f /usr/local/bin/hello  # Remove old version if exists
sudo rm -rf /usr/local/share/welcome  # Remove data directory
sudo rm -f /Library/LaunchDaemons/com.henok.welcome.plist

# Clear lock screen message
echo "Clearing lock screen message..."
sudo defaults delete /Library/Preferences/com.apple.loginwindow LoginwindowText 2>/dev/null || true

# Clean up logs
echo "Cleaning up logs..."
rm -f ~/.greeting_log
rm -f /tmp/greeting_log.txt
rm -f /tmp/welcome_output.log
rm -f /tmp/welcome_error.log

echo "✓ Uninstall complete!"

