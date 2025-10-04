#!/bin/bash
# Cursor Environment Docs System - Installer
# https://github.com/u00dxk2/cursor-kooi-env-docs

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Installing Cursor Environment Docs System...${NC}"
echo ""

# Check if in a git repo (warning, not error)
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Warning: Not in a git repository root${NC}"
    echo "This tool works best in the root of a git project."
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

# Create .cursor directory structure
echo -e "${BLUE}📁 Creating directory structure...${NC}"
mkdir -p .cursor/rules

# Base URL for downloading files
BASE_URL="https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/template"

# Check if files already exist
if [ -f ".cursor/project-environment.md" ]; then
    echo -e "${YELLOW}⚠️  .cursor/project-environment.md already exists${NC}"
    read -p "Overwrite? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping overwrite. Installation cancelled."
        exit 1
    fi
fi

# Download template files
echo -e "${BLUE}📥 Downloading template files...${NC}"

download_file() {
    local url=$1
    local dest=$2
    local filename=$(basename "$dest")
    
    if curl -fsSL "$url" -o "$dest" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} $filename"
        return 0
    else
        echo -e "  ${YELLOW}⚠${NC} Failed to download $filename"
        return 1
    fi
}

download_file "$BASE_URL/quick-prompt.txt" ".cursor/quick-prompt.txt"
download_file "$BASE_URL/rules/environment-maintenance.mdc" ".cursor/rules/environment-maintenance.mdc"
download_file "$BASE_URL/check-env-docs.sh" ".cursor/check-env-docs.sh"
download_file "$BASE_URL/README.md" ".cursor/README.md"
download_file "$BASE_URL/validate-install.sh" ".cursor/validate-install.sh"

# Make scripts executable
chmod +x .cursor/check-env-docs.sh 2>/dev/null || true
chmod +x .cursor/validate-install.sh 2>/dev/null || true

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo -e "${BLUE}📝 Next steps:${NC}"
echo "1. Verify installation (optional):"
echo -e "   ${YELLOW}./.cursor/validate-install.sh${NC}"
echo ""
echo "2. View the quick prompt:"
echo -e "   ${YELLOW}cat .cursor/quick-prompt.txt${NC}"
echo ""
echo "3. Open this project with your AI assistant (Cursor, Claude, etc.)"
echo "4. Ask your AI to create .cursor/project-environment.md"
echo "5. Commit the files:"
echo -e "   ${YELLOW}git add .cursor/${NC}"
echo -e "   ${YELLOW}git commit -m 'feat: Add environment documentation system'${NC}"
echo ""
echo -e "${BLUE}📊 Check documentation status anytime:${NC}"
echo -e "   ${YELLOW}./.cursor/check-env-docs.sh${NC}"
echo ""
echo -e "${BLUE}📚 Learn more:${NC} https://github.com/u00dxk2/cursor-kooi-env-docs"

