#!/bin/bash

#######################################################
# Cursor Configuration Backup Script
#
# This script backs up your Cursor editor configuration
# to the current directory for version control and
# easy restoration on other machines.
#
# Usage: ./backup.sh
#######################################################

set -e  # Exit on error

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Source and destination paths
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
BACKUP_DIR="$(cd "$(dirname "$0")" && pwd)"

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Cursor Configuration Backup Script      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Backup settings.json
if [ -f "$CURSOR_USER_DIR/settings.json" ]; then
    echo -e "${YELLOW}📝 Backing up settings.json...${NC}"
    cp "$CURSOR_USER_DIR/settings.json" "$BACKUP_DIR/settings.json"
    echo -e "${GREEN}   ✓ settings.json backed up${NC}"
else
    echo -e "${YELLOW}   ⚠ settings.json not found${NC}"
fi

# Backup keybindings.json
if [ -f "$CURSOR_USER_DIR/keybindings.json" ]; then
    echo -e "${YELLOW}⌨️  Backing up keybindings.json...${NC}"
    cp "$CURSOR_USER_DIR/keybindings.json" "$BACKUP_DIR/keybindings.json"
    echo -e "${GREEN}   ✓ keybindings.json backed up${NC}"
else
    echo -e "${YELLOW}   ⚠ keybindings.json not found${NC}"
fi

# Backup snippets
if [ -d "$CURSOR_USER_DIR/snippets" ]; then
    echo -e "${YELLOW}✂️  Backing up snippets...${NC}"
    mkdir -p "$BACKUP_DIR/snippets"
    if [ "$(ls -A $CURSOR_USER_DIR/snippets/)" ]; then
        cp -r "$CURSOR_USER_DIR/snippets/"* "$BACKUP_DIR/snippets/"
        echo -e "${GREEN}   ✓ Snippets backed up${NC}"
    else
        echo -e "${YELLOW}   ⚠ No snippets found${NC}"
    fi
else
    echo -e "${YELLOW}   ⚠ Snippets directory not found${NC}"
fi

# Note: .cursorrules is maintained in the backup directory
echo -e "${YELLOW}🤖 Cursor AI Rules (.cursorrules)${NC}"
if [ -f "$BACKUP_DIR/.cursorrules" ]; then
    echo -e "${GREEN}   ✓ .cursorrules file present in backup${NC}"
else
    echo -e "${YELLOW}   ⚠ .cursorrules not found - consider creating one${NC}"
fi

# Update extensions list (manual - update as needed)
echo -e "${YELLOW}🔌 Extensions list is in extensions.txt${NC}"
echo -e "${YELLOW}   Update it manually if you install new extensions${NC}"

# Summary
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Backup completed successfully! 🎉        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Backup location:${NC} $BACKUP_DIR"
echo -e "${BLUE}Backed up files:${NC}"
echo "  • settings.json"
echo "  • keybindings.json"
echo "  • snippets/"
echo "  • .cursorrules"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review changes: git diff"
echo "  2. Commit changes: git add . && git commit -m 'Update Cursor config'"
echo "  3. Push to remote: git push"
echo ""

