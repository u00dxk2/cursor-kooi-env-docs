#!/bin/bash
# Check Environment Documentation Staleness
# Run this script to see if .cursor/project-environment.md needs review

ENV_DOC_PATH=".cursor/project-environment.md"
WARNING_DAYS=7
CRITICAL_DAYS=14

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

if [ ! -f "$ENV_DOC_PATH" ]; then
    echo -e "${RED}ERROR: Environment documentation not found at $ENV_DOC_PATH${NC}"
    echo -e "${YELLOW}Consider creating it using the prompt in .cursor/quick-prompt.txt${NC}"
    exit 1
fi

# Read the file and extract the Last Updated date
if grep -q "Last Updated:" "$ENV_DOC_PATH"; then
    # Use sed for cross-platform compatibility (works on both GNU and BSD)
    LAST_UPDATED=$(grep "Last Updated:" "$ENV_DOC_PATH" | head -1 | sed -E 's/.*Last Updated:.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
    
    if [ -z "$LAST_UPDATED" ]; then
        echo -e "${YELLOW}WARNING: Could not parse 'Last Updated' date in the document${NC}"
        echo -e "${YELLOW}The document may need to be reformatted.${NC}"
        exit 1
    fi
    
    # Calculate days since last update (works on macOS and Linux)
    if date --version >/dev/null 2>&1; then
        # GNU date (Linux)
        LAST_UPDATED_SECONDS=$(date -d "$LAST_UPDATED" +%s)
        TODAY_SECONDS=$(date +%s)
    else
        # BSD date (macOS)
        LAST_UPDATED_SECONDS=$(date -j -f "%Y-%m-%d" "$LAST_UPDATED" +%s)
        TODAY_SECONDS=$(date +%s)
    fi
    
    DAYS_SINCE=$(( (TODAY_SECONDS - LAST_UPDATED_SECONDS) / 86400 ))
    
    echo -e "\n${CYAN}[Environment Documentation Status]${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo "Last Updated: $LAST_UPDATED ($DAYS_SINCE days ago)"
    
    if [ $DAYS_SINCE -ge $CRITICAL_DAYS ]; then
        echo -e "${RED}Status: CRITICAL - Review needed immediately!${NC}"
        echo -e "\n${RED}The documentation is significantly out of date.${NC}"
        echo -e "${YELLOW}Ask your AI assistant to review and update it.${NC}"
    elif [ $DAYS_SINCE -ge $WARNING_DAYS ]; then
        echo -e "${YELLOW}Status: WARNING - Review recommended${NC}"
        echo -e "\n${YELLOW}The documentation may be out of date.${NC}"
        echo -e "${YELLOW}Consider asking your AI assistant to review it.${NC}"
    else
        echo -e "${GREEN}Status: CURRENT - No action needed${NC}"
        echo -e "\n${GREEN}The documentation is up to date.${NC}"
    fi
    
    echo -e "${CYAN}========================================${NC}\n"
else
    echo -e "${YELLOW}WARNING: Could not find 'Last Updated' date in the document${NC}"
    echo -e "${YELLOW}The document may need to be reformatted.${NC}"
fi

