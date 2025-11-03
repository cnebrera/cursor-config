#!/bin/bash

#######################################################
# Cursor Configuration Restore Script
#
# This script restores your Cursor editor configuration
# from the backup files in this directory.
#
# Usage: ./restore.sh
#######################################################

set -e  # Exit on error

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Source and destination paths
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
CURSOR_CONFIG_DIR="$HOME/.cursor"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/backup"

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Cursor Configuration Restore Script     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Check if backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${RED}Error: Backup directory not found${NC}"
    echo -e "${YELLOW}Expected location: $BACKUP_DIR${NC}"
    echo -e "${YELLOW}Please run the backup script first or clone the repository.${NC}"
    exit 1
fi

# Check if Cursor User directory exists
if [ ! -d "$CURSOR_USER_DIR" ]; then
    echo -e "${RED}Error: Cursor User directory not found${NC}"
    echo -e "${YELLOW}Expected location: $CURSOR_USER_DIR${NC}"
    echo -e "${YELLOW}Please make sure Cursor is installed.${NC}"
    exit 1
fi

# Warning message
echo -e "${YELLOW}⚠️  WARNING: This will overwrite your current Cursor configuration!${NC}"
echo -e "${YELLOW}   Press Ctrl+C to cancel, or Enter to continue...${NC}"
read -r

# Restore settings.json
if [ -f "$BACKUP_DIR/settings.json" ]; then
    echo -e "${YELLOW}📝 Restoring settings.json...${NC}"
    cp "$BACKUP_DIR/settings.json" "$CURSOR_USER_DIR/settings.json"
    echo -e "${GREEN}   ✓ settings.json restored${NC}"
else
    echo -e "${RED}   ✗ settings.json not found in backup${NC}"
fi

# Restore keybindings.json
if [ -f "$BACKUP_DIR/keybindings.json" ]; then
    echo -e "${YELLOW}⌨️  Restoring keybindings.json...${NC}"
    cp "$BACKUP_DIR/keybindings.json" "$CURSOR_USER_DIR/keybindings.json"
    echo -e "${GREEN}   ✓ keybindings.json restored${NC}"
else
    echo -e "${RED}   ✗ keybindings.json not found in backup${NC}"
fi

# Restore snippets
if [ -d "$BACKUP_DIR/snippets" ]; then
    echo -e "${YELLOW}✂️  Restoring snippets...${NC}"
    mkdir -p "$CURSOR_USER_DIR/snippets"
    if [ "$(ls -A $BACKUP_DIR/snippets/)" ]; then
        cp -r "$BACKUP_DIR/snippets/"* "$CURSOR_USER_DIR/snippets/"
        echo -e "${GREEN}   ✓ Snippets restored${NC}"
    else
        echo -e "${YELLOW}   ⚠ No snippets to restore${NC}"
    fi
else
    echo -e "${YELLOW}   ⚠ Snippets directory not found in backup${NC}"
fi

# Restore cli-config.json
if [ -f "$BACKUP_DIR/cli-config.json" ]; then
    echo -e "${YELLOW}⚙️  Restoring cli-config.json...${NC}"
    mkdir -p "$CURSOR_CONFIG_DIR"
    cp "$BACKUP_DIR/cli-config.json" "$CURSOR_CONFIG_DIR/cli-config.json"
    echo -e "${GREEN}   ✓ cli-config.json restored (AI permissions & settings)${NC}"
else
    echo -e "${RED}   ✗ cli-config.json not found in backup${NC}"
fi

# Restore mcp.json
if [ -f "$BACKUP_DIR/mcp.json" ]; then
    echo -e "${YELLOW}🔌 Restoring mcp.json...${NC}"
    mkdir -p "$CURSOR_CONFIG_DIR"
    cp "$BACKUP_DIR/mcp.json" "$CURSOR_CONFIG_DIR/mcp.json"
    echo -e "${GREEN}   ✓ mcp.json restored (MCP integrations)${NC}"
else
    echo -e "${RED}   ✗ mcp.json not found in backup${NC}"
fi

# Restore .cursorrules
if [ -f "$BACKUP_DIR/.cursorrules" ]; then
    echo -e "${YELLOW}🤖 Restoring Cursor AI Rules...${NC}"
    # Copy to home directory for global rules
    cp "$BACKUP_DIR/.cursorrules" "$HOME/.cursorrules"
    echo -e "${GREEN}   ✓ .cursorrules restored to home directory${NC}"
    echo -e "${BLUE}   ℹ️  You can also copy .cursorrules to specific project directories${NC}"
else
    echo -e "${YELLOW}   ⚠ .cursorrules not found in backup${NC}"
fi

# Extensions reminder
echo ""
echo -e "${BLUE}🔌 Extensions Installation:${NC}"
echo -e "${YELLOW}   Extensions need to be installed manually.${NC}"
echo -e "${YELLOW}   Check extensions.txt for the list.${NC}"
echo ""
echo -e "${YELLOW}   To install extensions:${NC}"
echo "   1. Open Cursor"
echo "   2. Press Cmd+Shift+X (Extensions panel)"
echo "   3. Search and install each extension from extensions.txt"
echo ""

# Summary
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Restore completed successfully! 🎉       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Restart Cursor: Cmd+Q and reopen"
echo "  2. Install extensions from extensions.txt"
echo "  3. Install JetBrains Mono font (if not installed):"
echo "     brew install font-jetbrains-mono"
echo "  4. .cursorrules has been copied to your home directory"
echo "     Copy to specific projects if needed:"
echo "     cp ~/.cursorrules /path/to/your/project/"
echo ""

