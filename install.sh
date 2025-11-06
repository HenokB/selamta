#!/bin/bash
# Install selamta daemon script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📜 Installing Selamta - Amharic Proverb Display System..."
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
sudo mkdir -p /usr/local/share/selamta
sudo cp "${SCRIPT_DIR}/amharic_cleaned.csv" /usr/local/share/selamta/
sudo chmod 644 /usr/local/share/selamta/amharic_cleaned.csv

# Copy the script to /usr/local/bin
echo "Installing script..."
sudo cp "${SCRIPT_DIR}/selamta" /usr/local/bin/
sudo chmod +x /usr/local/bin/selamta

# Copy the plist to LaunchDaemons
echo "Installing daemon configuration..."
sudo cp "${SCRIPT_DIR}/com.ethiopia.selamta.plist" /Library/LaunchDaemons/
sudo chmod 644 /Library/LaunchDaemons/com.ethiopia.selamta.plist

# Load and start the daemon
echo "Starting daemon..."
sudo launchctl load /Library/LaunchDaemons/com.ethiopia.selamta.plist
sudo launchctl start com.ethiopia.selamta

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
echo "  selamta"
echo ""
echo "To view logs:"
echo "  tail -f /var/log/selamta_output.log"
echo "  tail -f /var/log/selamta_error.log"
echo "  tail -f ~/Library/Logs/selamta.log"
echo ""
echo "To check daemon status:"
echo "  sudo launchctl list | grep selamta"
echo ""
echo "To uninstall:"
echo "  sudo ${SCRIPT_DIR}/uninstall.sh"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
