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
CURSOR_CONFIG_DIR="$HOME/.cursor"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/backup"

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Cursor Configuration Backup Script      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

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
    if [ "$(ls -A "$CURSOR_USER_DIR/snippets/")" ]; then
        cp -r "$CURSOR_USER_DIR/snippets/"* "$BACKUP_DIR/snippets/"
        echo -e "${GREEN}   ✓ Snippets backed up${NC}"
    else
        echo -e "${YELLOW}   ⚠ No snippets found${NC}"
    fi
else
    echo -e "${YELLOW}   ⚠ Snippets directory not found${NC}"
fi

# Backup cli-config.json (Cursor AI permissions, privacy, model)
if [ -f "$CURSOR_CONFIG_DIR/cli-config.json" ]; then
    echo -e "${YELLOW}⚙️  Backing up cli-config.json...${NC}"
    cp "$CURSOR_CONFIG_DIR/cli-config.json" "$BACKUP_DIR/cli-config.json"
    echo -e "${GREEN}   ✓ cli-config.json backed up (AI permissions & settings)${NC}"
else
    echo -e "${YELLOW}   ⚠ cli-config.json not found${NC}"
fi

# Backup mcp.json (MCP server integrations)
if [ -f "$CURSOR_CONFIG_DIR/mcp.json" ]; then
    echo -e "${YELLOW}🔌 Backing up mcp.json...${NC}"
    cp "$CURSOR_CONFIG_DIR/mcp.json" "$BACKUP_DIR/mcp.json"
    echo -e "${GREEN}   ✓ mcp.json backed up (MCP integrations)${NC}"
else
    echo -e "${YELLOW}   ⚠ mcp.json not found${NC}"
fi

# Generate extensions list automatically
echo -e "${YELLOW}📦 Generating extensions list...${NC}"
if [ -d "$HOME/.cursor/extensions" ]; then
    echo "# Cursor Extensions Installed" > "$BACKUP_DIR/extensions.txt"
    echo "# Generated on $(date)" >> "$BACKUP_DIR/extensions.txt"
    echo "# To install: Open Extensions panel (Cmd+Shift+X) and search for each extension" >> "$BACKUP_DIR/extensions.txt"
    echo "" >> "$BACKUP_DIR/extensions.txt"
    
    # List installed extensions from directory and extract IDs
    ls -1 "$HOME/.cursor/extensions" | grep -v "^\." | sed -E 's/-[0-9]+\.[0-9]+\.[0-9]+.*$//' | sort -u >> "$BACKUP_DIR/extensions.txt"
    
    echo -e "${GREEN}   ✓ extensions.txt generated with $(grep -v '^#' "$BACKUP_DIR/extensions.txt" | grep -v '^$' | wc -l | tr -d ' ') installed extensions${NC}"
else
    echo -e "${YELLOW}   ⚠ Extensions directory not found, skipping${NC}"
fi

# Note: .cursorrules is maintained in the backup directory
echo -e "${YELLOW}🤖 Cursor AI Rules (.cursorrules)${NC}"
if [ -f "$BACKUP_DIR/.cursorrules" ]; then
    echo -e "${GREEN}   ✓ .cursorrules file present in backup${NC}"
else
    echo -e "${YELLOW}   ⚠ .cursorrules not found - consider creating one${NC}"
fi

# Summary
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Backup completed successfully! 🎉        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Backup location:${NC} $BACKUP_DIR"
echo -e "${BLUE}Backed up files in backup/ directory:${NC}"
echo "  • settings.json (editor settings)"
echo "  • keybindings.json (keyboard shortcuts)"
echo "  • cli-config.json (AI permissions, privacy, model)"
echo "  • mcp.json (MCP integrations)"
echo "  • extensions.txt (installed extensions list)"
echo "  • .cursorrules (AI coding rules)"
echo "  • snippets/ (if you have custom snippets)"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review changes: git diff"
echo "  2. Commit changes: git add . && git commit -m 'Update Cursor config'"
echo "  3. Push to remote: git push"
echo ""

