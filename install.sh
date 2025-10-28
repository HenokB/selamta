#!/bin/bash
# Install welcome daemon script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📜 Installing Amharic Proverb Display System..."
echo ""

# Check if CSV file exists
if [ ! -f "${SCRIPT_DIR}/amharic_cleaned.csv" ]; then
    echo "❌ Error: amharic_cleaned.csv not found in ${SCRIPT_DIR}"
    exit 1
fi

# First, uninstall any existing installation
if [ -f "${SCRIPT_DIR}/uninstall.sh" ]; then
    echo "Removing any existing installation..."
    bash "${SCRIPT_DIR}/uninstall.sh"
    sleep 2
fi

# Create data directory
echo "Creating data directory..."
sudo mkdir -p /usr/local/share/welcome
sudo cp "${SCRIPT_DIR}/amharic_cleaned.csv" /usr/local/share/welcome/
sudo chmod 644 /usr/local/share/welcome/amharic_cleaned.csv

# Copy the script to /usr/local/bin
echo "Installing script..."
sudo cp "${SCRIPT_DIR}/welcome" /usr/local/bin/
sudo chmod +x /usr/local/bin/welcome

# Copy the plist to LaunchDaemons
echo "Installing daemon configuration..."
sudo cp "${SCRIPT_DIR}/com.henok.welcome.plist" /Library/LaunchDaemons/
sudo chmod 644 /Library/LaunchDaemons/com.henok.welcome.plist

# Load and start the daemon
echo "Starting daemon..."
sudo launchctl load /Library/LaunchDaemons/com.henok.welcome.plist
sudo launchctl start com.henok.welcome

echo ""
echo "✅ Installation complete!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "The script will now run every 15 minutes and will:"
echo "  • Display a proverb in the terminal"
echo "  • Show a macOS notification"
echo "  • Set a message on your lock screen"
echo ""
echo "To test immediately, run:"
echo "  /usr/local/bin/welcome"
echo ""
echo "To view logs:"
echo "  tail -f /tmp/welcome_output.log"
echo "  tail -f /tmp/welcome_error.log"
echo ""
echo "To check daemon status:"
echo "  sudo launchctl list | grep welcome"
echo ""
echo "To uninstall:"
echo "  sudo ${SCRIPT_DIR}/uninstall.sh"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
