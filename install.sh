#!/bin/bash
# Cursor Environment Docs System - Installer
# https://github.com/u00dxk2/cursor-kooi-env-docs
# Version: 1.1.3

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Parse command line arguments
FORCE_INSTALL=false
if [[ "$1" == "--force" ]]; then
    FORCE_INSTALL=true
fi

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

# Arrays to track installation results
installed_files=()
skipped_files=()
failed_downloads=0

# Check if .cursor/ directory has existing files
if [ -d ".cursor" ] && [ "$(ls -A .cursor 2>/dev/null)" ]; then
    if [ "$FORCE_INSTALL" = false ]; then
        echo -e "${YELLOW}⚠️  Existing .cursor/ setup detected${NC}"
        echo -e "${YELLOW}Existing files will be preserved (use --force to overwrite)${NC}"
        echo ""
    else
        echo -e "${YELLOW}⚠️  Existing .cursor/ setup detected${NC}"
        echo -e "${YELLOW}--force flag detected: will overwrite existing files${NC}"
        echo ""
    fi
fi

# Download template files
echo -e "${BLUE}📥 Downloading template files...${NC}"

download_file() {
    local url=$1
    local dest=$2
    local filename=$(basename "$dest")
    
    # Check if file exists and we're not in force mode
    if [ -f "$dest" ] && [ "$FORCE_INSTALL" = false ]; then
        echo -e "  ${YELLOW}⚠${NC} $filename (exists - skipped)"
        skipped_files+=("$filename")
        return 0
    fi
    
    # Download the file
    if curl -fsSL "$url" -o "$dest" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} $filename"
        installed_files+=("$filename")
        return 0
    else
        echo -e "  ${RED}✗${NC} Failed to download $filename"
        return 1
    fi
}

download_file "$BASE_URL/quick-prompt.txt" ".cursor/quick-prompt.txt" || ((failed_downloads++))
download_file "$BASE_URL/rules/environment-maintenance.mdc" ".cursor/rules/environment-maintenance.mdc" || ((failed_downloads++))
download_file "$BASE_URL/check-env-docs.sh" ".cursor/check-env-docs.sh" || ((failed_downloads++))
download_file "$BASE_URL/README.md" ".cursor/README.md" || ((failed_downloads++))
download_file "$BASE_URL/validate-install.sh" ".cursor/validate-install.sh" || ((failed_downloads++))

# Check if any critical files failed
if [ $failed_downloads -gt 0 ]; then
    echo ""
    echo -e "${RED}❌ Installation failed: $failed_downloads file(s) could not be downloaded${NC}"
    echo -e "${YELLOW}Please check your internet connection and try again.${NC}"
    exit 1
fi

# Make scripts executable
chmod +x .cursor/check-env-docs.sh 2>/dev/null || true
chmod +x .cursor/validate-install.sh 2>/dev/null || true

echo ""
echo -e "${GREEN}✅ Template files installed successfully!${NC}"
echo ""

# Show summary
if [ ${#installed_files[@]} -gt 0 ] || [ ${#skipped_files[@]} -gt 0 ]; then
    echo -e "${BLUE}📊 Summary:${NC}"
    [ ${#installed_files[@]} -gt 0 ] && echo -e "  ${GREEN}✓${NC} Installed: ${#installed_files[@]} file(s)"
    if [ ${#skipped_files[@]} -gt 0 ]; then
        echo -e "  ${YELLOW}⚠${NC} Skipped: ${#skipped_files[@]} existing file(s)"
        echo -e "    ${YELLOW}Tip: Use 'bash install.sh --force' to overwrite existing files${NC}"
    fi
    echo ""
fi

echo -e "${RED}⚠️  IMPORTANT: Installation requires one more critical step!${NC}"
echo -e "${YELLOW}You must create the project-environment.mdc file to complete setup.${NC}"
echo ""

echo -e "${BLUE}📝 Next steps to complete installation:${NC}"
echo "1. View the quick prompt:"
echo -e "   ${YELLOW}cat .cursor/quick-prompt.txt${NC}"
echo ""
echo "2. Open this project with Cursor"
echo "3. Ask Cursor to create .cursor/rules/project-environment.mdc using the prompt"
echo "4. Commit ALL .cursor/ files to Git:"
echo -e "   ${YELLOW}git add .cursor/${NC}"
echo -e "   ${YELLOW}git commit -m 'feat: Add environment documentation system'${NC}"
echo ""
echo -e "   ${YELLOW}⚠️  IMPORTANT: Commit the ENTIRE .cursor/ directory.${NC}"
echo -e "   ${YELLOW}Do NOT add .cursor/ to .gitignore - it's shared team documentation!${NC}"
echo ""
echo -e "${BLUE}📊 Check documentation status anytime:${NC}"
echo -e "   ${YELLOW}./.cursor/check-env-docs.sh${NC}"
echo ""
echo -e "${BLUE}📚 Learn more:${NC} https://github.com/u00dxk2/cursor-kooi-env-docs"

