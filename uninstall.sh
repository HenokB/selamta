#!/bin/bash
# Uninstall selamta daemon script

echo "🗑️  Uninstalling Selamta daemon..."

# Unload the daemon (check for both old and new names)
if sudo launchctl list | grep -q "com.ethiopia.selamta"; then
    echo "Stopping daemon..."
    sudo launchctl stop com.ethiopia.selamta 2>/dev/null
    sudo launchctl unload /Library/LaunchDaemons/com.ethiopia.selamta.plist 2>/dev/null
    echo "✓ Daemon stopped"
elif sudo launchctl list | grep -q "com.henok.selamta"; then
    echo "Stopping old daemon..."
    sudo launchctl stop com.henok.selamta 2>/dev/null
    sudo launchctl unload /Library/LaunchDaemons/com.henok.selamta.plist 2>/dev/null
    echo "✓ Old daemon stopped"
elif sudo launchctl list | grep -q "com.henok.welcome"; then
    echo "Stopping old daemon..."
    sudo launchctl stop com.henok.welcome 2>/dev/null
    sudo launchctl unload /Library/LaunchDaemons/com.henok.welcome.plist 2>/dev/null
    echo "✓ Old daemon stopped"
fi

# Remove files
echo "Removing files..."
sudo rm -f /usr/local/bin/selamta
sudo rm -f /usr/local/bin/welcome  # Remove old version if exists
sudo rm -f /usr/local/bin/hello  # Remove even older version if exists
sudo rm -rf /usr/local/share/selamta  # Remove data directory
sudo rm -rf /usr/local/share/welcome  # Remove old data directory if exists
sudo rm -f /Library/LaunchDaemons/com.ethiopia.selamta.plist
sudo rm -f /Library/LaunchDaemons/com.henok.selamta.plist  # Remove old plist if exists
sudo rm -f /Library/LaunchDaemons/com.henok.welcome.plist  # Remove old plist if exists

# Clear lock screen message
echo "Clearing lock screen message..."
sudo defaults delete /Library/Preferences/com.apple.loginwindow LoginwindowText 2>/dev/null || true

# Clean up logs
echo "Cleaning up logs..."
rm -f ~/.greeting_log
rm -f /tmp/greeting_log.txt
rm -f /tmp/welcome_output.log
rm -f /tmp/welcome_error.log
sudo rm -f /var/log/selamta_output.log
sudo rm -f /var/log/selamta_error.log
rm -f ~/Library/Logs/selamta.log

echo "✓ Uninstall complete!"

