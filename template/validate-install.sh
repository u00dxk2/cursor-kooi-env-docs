#!/bin/bash
# Validate Cursor Environment Docs Installation
# Run this script to verify your installation is complete and correct

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

errors=0
warnings=0

echo -e "${CYAN}\n🔍 Validating Cursor Environment Docs Installation...\n${NC}"

# Helper function to check file exists
check_file_exists() {
    local path=$1
    local description=$2
    
    if [ -f "$path" ]; then
        echo -e "  ${GREEN}✓${NC} $description"
        return 0
    else
        echo -e "  ${RED}✗${NC} $description - NOT FOUND"
        ((errors++))
        return 1
    fi
}

# Helper function for optional files
check_optional_file() {
    local path=$1
    local description=$2
    
    if [ -f "$path" ]; then
        echo -e "  ${GREEN}✓${NC} $description"
    else
        echo -e "  ${YELLOW}⚠${NC} $description - Not found (optional)"
        ((warnings++))
    fi
}

# 1. Check required files
echo -e "${CYAN}[Required Files]${NC}"
check_file_exists ".cursor/project-environment.mdc" "project-environment.mdc"
check_file_exists ".cursor/rules/environment-maintenance.mdc" "environment-maintenance.mdc"

# 2. Check optional but recommended files
echo -e "\n${CYAN}[Recommended Files]${NC}"
check_optional_file ".cursor/quick-prompt.txt" "quick-prompt.txt"
check_optional_file ".cursor/check-env-docs.ps1" "check-env-docs.ps1"
check_optional_file ".cursor/check-env-docs.sh" "check-env-docs.sh"
check_optional_file ".cursor/README.md" "README.md"

# 3. Validate project-environment.mdc format
echo -e "\n${CYAN}[Document Format]${NC}"

if [ -f ".cursor/project-environment.mdc" ]; then
    content=$(cat .cursor/project-environment.mdc)
    
    # Check for Last Updated (using grep -E for cross-platform compatibility)
    if echo "$content" | grep -qE 'Last Updated:.*[0-9]{4}-[0-9]{2}-[0-9]{2}'; then
        echo -e "  ${GREEN}✓${NC} 'Last Updated' date format correct"
        
        # Extract and check date (using sed for cross-platform compatibility)
        LAST_UPDATED=$(echo "$content" | grep "Last Updated:" | head -1 | sed -E 's/.*Last Updated:.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
        
        if [ -n "$LAST_UPDATED" ]; then
            # Calculate days since last update
            if date --version >/dev/null 2>&1; then
                # GNU date (Linux)
                LAST_UPDATED_SECONDS=$(date -d "$LAST_UPDATED" +%s)
                TODAY_SECONDS=$(date +%s)
            else
                # BSD date (macOS)
                LAST_UPDATED_SECONDS=$(date -j -f "%Y-%m-%d" "$LAST_UPDATED" +%s 2>/dev/null || echo 0)
                TODAY_SECONDS=$(date +%s)
            fi
            
            if [ "$LAST_UPDATED_SECONDS" != "0" ]; then
                DAYS_SINCE=$(( (TODAY_SECONDS - LAST_UPDATED_SECONDS) / 86400 ))
                
                if [ $DAYS_SINCE -le 7 ]; then
                    echo -e "  ${GREEN}✓${NC} Documentation is current ($DAYS_SINCE days old)"
                elif [ $DAYS_SINCE -le 14 ]; then
                    echo -e "  ${YELLOW}⚠${NC} Documentation needs review ($DAYS_SINCE days old)"
                    ((warnings++))
                else
                    echo -e "  ${YELLOW}⚠${NC} Documentation is stale ($DAYS_SINCE days old)"
                    ((warnings++))
                fi
            fi
        fi
    else
        echo -e "  ${RED}✗${NC} 'Last Updated' date missing or incorrect format"
        echo -e "    ${YELLOW}Expected: > **Last Updated:** YYYY-MM-DD${NC}"
        ((errors++))
    fi
    
    # Check for Next Review
    if echo "$content" | grep -qE 'Next Review:.*[0-9]{4}-[0-9]{2}-[0-9]{2}'; then
        echo -e "  ${GREEN}✓${NC} 'Next Review' date present"
    else
        echo -e "  ${YELLOW}⚠${NC} 'Next Review' date missing"
        ((warnings++))
    fi
    
    # Check for Maintenance Log
    if echo "$content" | grep -q "Maintenance Log"; then
        echo -e "  ${GREEN}✓${NC} Maintenance Log section present"
    else
        echo -e "  ${YELLOW}⚠${NC} Maintenance Log section missing"
        ((warnings++))
    fi
    
    # Check for AI Instructions
    if echo "$content" | grep -q "AI Assistant Instructions"; then
        echo -e "  ${GREEN}✓${NC} AI Assistant Instructions present"
    else
        echo -e "  ${YELLOW}⚠${NC} AI Assistant Instructions missing"
        ((warnings++))
    fi
fi

# 4. Check git integration
echo -e "\n${CYAN}[Git Integration]${NC}"

if [ -d ".git" ]; then
    echo -e "  ${GREEN}✓${NC} Git repository detected"
    
    # Check if .cursor/ is tracked
    if git ls-files .cursor/ >/dev/null 2>&1 && [ -n "$(git ls-files .cursor/)" ]; then
        echo -e "  ${GREEN}✓${NC} .cursor/ directory is in git repository"
    else
        echo -e "  ${YELLOW}⚠${NC} .cursor/ directory not tracked by git"
        echo -e "    ${YELLOW}Run: git add .cursor/${NC}"
        ((warnings++))
    fi
else
    echo -e "  ${YELLOW}⚠${NC} Not a git repository"
    echo -e "    ${YELLOW}This system works best with git version control${NC}"
    ((warnings++))
fi

# 5. Check script executability
echo -e "\n${CYAN}[Scripts]${NC}"

if [ -f ".cursor/check-env-docs.sh" ]; then
    echo -e "  ${GREEN}✓${NC} Bash check script present"
    
    # Check if executable
    if [ -x ".cursor/check-env-docs.sh" ]; then
        echo -e "  ${GREEN}✓${NC} Bash check script is executable"
    else
        echo -e "  ${YELLOW}⚠${NC} Bash check script not executable"
        echo -e "    ${YELLOW}Run: chmod +x .cursor/check-env-docs.sh${NC}"
        ((warnings++))
    fi
fi

if [ -f ".cursor/validate-install.sh" ] && [ ! -x ".cursor/validate-install.sh" ]; then
    echo -e "  ${YELLOW}⚠${NC} validate-install.sh not executable"
    echo -e "    ${YELLOW}Run: chmod +x .cursor/validate-install.sh${NC}"
    ((warnings++))
fi

# 6. Summary
echo -e "\n${CYAN}========================================${NC}"
echo -e "${CYAN}Validation Summary${NC}"
echo -e "${CYAN}========================================${NC}"

if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo -e "${GREEN}✅ EXCELLENT! Installation is complete and correct.${NC}"
    echo -e "\n${GREEN}Your environment documentation system is ready to use!${NC}"
elif [ $errors -eq 0 ]; then
    echo -e "${YELLOW}✅ GOOD! Installation is functional with $warnings warning(s).${NC}"
    echo -e "\n${YELLOW}The system will work, but consider addressing the warnings above.${NC}"
else
    echo -e "${RED}❌ ISSUES FOUND: $errors error(s), $warnings warning(s)${NC}"
    echo -e "\n${RED}Please fix the errors above before using the system.${NC}"
    echo -e "${YELLOW}See docs/TROUBLESHOOTING.md for help.${NC}"
fi

echo -e "\n${CYAN}📚 Next Steps:${NC}"
if [ $errors -eq 0 ]; then
    echo -e "  1. Commit .cursor/ to git: ${NC}git add .cursor/ && git commit${NC}"
    echo -e "  2. Start using AI with your project"
    echo -e "  3. Check staleness anytime: ${NC}./.cursor/check-env-docs.sh${NC}"
else
    echo -e "  1. Fix errors listed above"
    echo -e "  2. Run validation again: ${NC}./.cursor/validate-install.sh${NC}"
    echo -e "  3. See docs/TROUBLESHOOTING.md for help"
fi

echo ""
exit $errors

