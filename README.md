# Amharic Proverbs for macOS

> Display Amharic proverbs on your Mac - Terminal, Notifications, and Lock Screen!

A delightful macOS utility that displays random Amharic proverbs from a collection of 1,440+ traditional Ethiopian sayings. Perfect for staying connected to Ethiopian culture while you work.

<div align="center">

![macOS](https://img.shields.io/badge/macOS-10.15+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Bash](https://img.shields.io/badge/bash-5.0+-orange.svg)

</div>

## ✨ Features

🖥️ **Terminal Display** - Beautiful colored proverb output  
🔔 **macOS Notifications** - Pop-up notifications with Ethiopian proverbs  
🔒 **Lock Screen Messages** - See wisdom when you lock your Mac  
⏰ **Automatic Updates** - New proverb every 15 minutes (customizable)  
🎯 **1,440+ Proverbs** - Rich collection of traditional Ethiopian sayings  
⚙️ **Highly Configurable** - Sound, frequency, and display options

## 🎬 Quick Demo

```bash
# Display a random proverb
$ welcome
የሚያልፈው ጊዜ አይመለስም።
```

## 📦 Installation

### Prerequisites

- macOS 10.15 (Catalina) or later
- Admin/sudo access

### Install Steps

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/welcome.git
cd welcome
```

2. **Run the installer**
```bash
sudo ./install.sh
```

3. **Done!** The proverb daemon is now running. 🎉

### What Gets Installed

- `/usr/local/bin/welcome` - Main script
- `/usr/local/share/welcome/amharic_cleaned.csv` - Proverb database
- `/Library/LaunchDaemons/com.henok.welcome.plist` - Auto-run configuration

## 🚀 Usage

### Basic Commands

```bash
# Display a random proverb
welcome

# Show help and all options
welcome --help

# Terminal-only mode (no notifications)
welcome -t

# Enable sound notification
welcome -s

# Disable lock screen message
welcome --no-lock
```

### Notification Setup

To receive notification pop-ups:

1. **Run the script once** to trigger macOS permission prompt:
   ```bash
   /usr/local/bin/welcome
   ```

2. **Allow notifications** when prompted

3. **Or manually enable in System Settings**:
   - Open **System Settings** (or **System Preferences**)
   - Go to **Notifications**
   - Find **"Terminal"** or **"Script Editor"** in the list
   - Enable **"Allow Notifications"**

### Lock Screen Setup

To display proverbs on your lock screen:

1. **Grant Full Disk Access** (macOS Catalina+):
   - Open **System Preferences** → **Security & Privacy** → **Privacy**
   - Select **Full Disk Access** from the sidebar
   - Click the 🔒 lock and authenticate
   - Click **+** and add `/usr/local/bin/welcome`

2. **Test it**: Lock your screen (`⌘ + ^ + Q`)
3. **See the proverb** displayed above the login field! ✨

## ⚙️ Configuration

### Change Update Frequency

Edit the daemon configuration:

```bash
sudo nano /Library/LaunchDaemons/com.henok.welcome.plist
```

Change the interval (in seconds):
```xml
<key>StartInterval</key>
<integer>900</integer>  <!-- 900 = 15 minutes -->
```

Reload the daemon:
```bash
sudo launchctl unload /Library/LaunchDaemons/com.henok.welcome.plist
sudo launchctl load /Library/LaunchDaemons/com.henok.welcome.plist
```

### Enable/Disable Features

Edit environment variables in the plist file:

```xml
<key>ENABLE_NOTIFICATION</key>
<string>1</string>  <!-- 1 = on, 0 = off -->

<key>ENABLE_LOCK_SCREEN</key>
<string>1</string>  <!-- 1 = on, 0 = off -->

<key>ENABLE_SOUND</key>
<string>0</string>  <!-- 1 = on, 0 = off -->
```

## 📊 Monitoring

### View Logs

```bash
# See proverb output
tail -f /tmp/welcome_output.log

# See any errors
tail -f /tmp/welcome_error.log

# View activity log
cat /tmp/greeting_log.txt
```

### Check Daemon Status

```bash
# Check if running
sudo launchctl list | grep welcome

# Should show: com.henok.welcome
```

### View Current Lock Screen Message

```bash
sudo defaults read /Library/Preferences/com.apple.loginwindow LoginwindowText
```

## 🗑️ Uninstall

```bash
cd /path/to/welcome
sudo ./uninstall.sh
```

This will remove all installed files, stop the daemon, and clear the lock screen message.

## 🛠️ Troubleshooting

<details>
<summary><b>Lock screen message not showing?</b></summary>

- Ensure Full Disk Access is granted (see Lock Screen Setup above)
- Try running manually: `sudo /usr/local/bin/welcome`
- Check error log: `cat /tmp/welcome_error.log`
- Restart your Mac if needed
</details>

<details>
<summary><b>Notifications not appearing?</b></summary>

**Check notification permissions:**

1. Go to **System Settings** → **Notifications**
2. Look for **"Terminal"**, **"Script Editor"**, or **"osascript"**
3. Enable **"Allow Notifications"** for each

**Test manually:**
```bash
# This should show a notification
osascript -e 'display notification "Test notification" with title "Testing"'
```

**If daemon notifications don't work:**
- Wait for the next scheduled run (every 15 min)
- Check `/tmp/welcome_error.log` for errors
- Make sure the daemon is running: `sudo launchctl list | grep welcome`

**Still not working?**
- Run: `/usr/local/bin/welcome` and approve any permission prompts
- Restart your Mac to refresh notification permissions
</details>

<details>
<summary><b>Daemon not running?</b></summary>

```bash
# Check if loaded
sudo launchctl list | grep welcome

# Reload daemon
sudo launchctl unload /Library/LaunchDaemons/com.henok.welcome.plist
sudo launchctl load /Library/LaunchDaemons/com.henok.welcome.plist

# Check logs
cat /tmp/welcome_error.log
```
</details>

<details>
<summary><b>Getting "CSV file not found" error?</b></summary>

Make sure the installation completed successfully:
```bash
ls -la /usr/local/share/welcome/amharic_cleaned.csv
```

If missing, reinstall:
```bash
sudo ./install.sh
```
</details>

## 📁 Project Structure

```
welcome/
├── welcome                  # Main script
├── amharic_cleaned.csv      # Database of 1,440+ proverbs
├── com.henok.welcome.plist  # LaunchDaemon configuration
├── install.sh               # Installation script
├── uninstall.sh             # Uninstallation script
├── README.md                # This file
└── LICENSE                  # MIT License
```


## 📝 Proverb Format

The `amharic_cleaned.csv` file contains one proverb per line in UTF-8 format:

```
እህል ያለ ውሀ ንጉስ ያለድሀ ።
ከሰነፍ ገበሬ ማሳ፥ ሞፈር ይቆረጣል።
...
```

To add your own proverbs, simply add new lines to this file!

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


