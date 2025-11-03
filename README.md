# 🎨 Cursor Editor Configuration Backup

This repository contains a complete backup of your Cursor editor configuration, making it easy to sync settings across multiple machines or restore after a fresh install.

## 📦 What's Included

- **`settings.json`** - All editor settings (fonts, theme, editor preferences)
- **`keybindings.json`** - Custom keyboard shortcuts
- **`snippets/`** - Code snippets (if any)
- **`extensions.txt`** - List of installed extensions
- **`backup.sh`** - Script to backup current configuration
- **`restore.sh`** - Script to restore configuration on a new machine

## 🎯 Current Configuration

- **Font:** JetBrains Mono with ligatures
- **Theme:** IntelliJ IDEA New UI Dark
- **Icons:** VSCode Icons
- **Java Runtimes:** JDK 11, 17, 21, 24 (GraalVM)
- **Features:**
  - Auto-save on focus change
  - Git auto-fetch enabled
  - Smart commit enabled
  - Font ligatures enabled

## 🔄 How to Backup (Update Configuration)

When you make changes to your Cursor settings that you want to save:

```bash
cd ~/cursor-config
./backup.sh
```

This will:
1. Copy current `settings.json` from Cursor
2. Copy current `keybindings.json`
3. Copy any snippets you've created
4. Show you what was backed up

### Committing Changes to Git

```bash
# Review what changed
git diff

# Stage and commit changes
git add .
git commit -m "Update Cursor configuration"

# Push to remote (if you have one configured)
git push
```

## 🚀 How to Restore (New Machine Setup)

On a new Mac where you want to restore your Cursor configuration:

### Step 1: Install Prerequisites

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install JetBrains Mono font
brew install font-jetbrains-mono

# Install Cursor (if not installed)
# Download from: https://cursor.sh
```

### Step 2: Clone This Repository

```bash
cd ~
git clone <your-repo-url> cursor-config
cd cursor-config
```

### Step 3: Run Restore Script

```bash
chmod +x restore.sh
./restore.sh
```

### Step 4: Install Extensions

Open Cursor (`Cmd + Shift + X`) and search for each extension listed in `extensions.txt`:

**Essential Extensions:**
- vscode-icons (Icon theme)
- IntelliJ IDEA Theme (Color theme)
- Java Language Support (redhat.java)
- YAML Language Support (redhat.vscode-yaml)
- Python Language Support (ms-python.python)
- Kotlin Language Support (fwcd.kotlin)
- And others as listed in `extensions.txt`

### Step 5: Restart Cursor

```bash
# Quit Cursor
Cmd + Q

# Reopen Cursor
# All settings should now be applied!
```

## 🛠️ Manual Configuration

If you prefer to manually copy files:

### Backup Manually

```bash
# Cursor configuration location on macOS
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"

# Copy settings
cp "$CURSOR_DIR/settings.json" ~/cursor-config/
cp "$CURSOR_DIR/keybindings.json" ~/cursor-config/
cp -r "$CURSOR_DIR/snippets/" ~/cursor-config/snippets/
```

### Restore Manually

```bash
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"

# Copy settings back
cp ~/cursor-config/settings.json "$CURSOR_DIR/"
cp ~/cursor-config/keybindings.json "$CURSOR_DIR/"
cp -r ~/cursor-config/snippets/ "$CURSOR_DIR/"
```

## 📝 Customization

### Adding New Extensions

When you install a new extension:

1. Add it to `extensions.txt` with a description
2. Run `./backup.sh`
3. Commit the changes

### Modifying Settings

1. Change settings in Cursor (Cmd + ,)
2. Run `./backup.sh` to save changes
3. Commit and push

## 🔧 Troubleshooting

### Scripts Not Executable

```bash
chmod +x backup.sh restore.sh
```

### Cursor Directory Not Found

Make sure Cursor is installed and has been opened at least once. The configuration directory is created on first launch.

### Font Not Showing

If JetBrains Mono isn't showing:

```bash
# Reinstall font
brew reinstall font-jetbrains-mono

# Restart Cursor
# Cmd+Q then reopen
```

### Theme Not Applied

1. Open Command Palette: `Cmd + Shift + P`
2. Type: "Preferences: Color Theme"
3. Select: "IntelliJ IDEA New UI Dark"

## 📋 Quick Reference

### Useful Cursor Commands

- **Command Palette:** `Cmd + Shift + P`
- **Settings:** `Cmd + ,`
- **Extensions:** `Cmd + Shift + X`
- **Keyboard Shortcuts:** `Cmd + K, Cmd + S`
- **Reload Window:** `Cmd + Shift + P` → "Reload Window"

### File Locations

```bash
# Cursor User Settings (macOS)
~/Library/Application Support/Cursor/User/

# Backup Location
~/cursor-config/
```

## 🎉 Configuration Highlights

### Font Settings
- **Family:** JetBrains Mono
- **Size:** 13px
- **Ligatures:** Enabled
- **Weight:** 400 (Regular)
- **Line Height:** 1.5

### Editor Features
- Auto-save on focus change
- Smart Git integration
- IntelliJ-style theme
- VSCode modern icons

## 📚 Additional Resources

- [Cursor Documentation](https://docs.cursor.sh)
- [JetBrains Mono Font](https://www.jetbrains.com/lp/mono/)
- [VSCode Icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons)
- [IntelliJ IDEA Theme](https://plugins.jetbrains.com/plugin/164-ideavim)

## 🤝 Contributing

This is a personal configuration backup, but feel free to fork and adapt it for your own use!

## 📄 License

Personal configuration - use as you wish!

---

**Last Updated:** $(date)
**Maintained by:** Your Name

