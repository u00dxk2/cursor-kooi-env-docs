# Project Environment Notes

> **Last Updated:** 2025-10-04  
> **Review Frequency:** Check every 7 days or after major changes  
> **Next Review:** 2025-10-11

This document contains important context about the development environment to help AI assistants work more efficiently with this project.

## 📋 Maintenance Log

| Date | Change | Updated By |
|------|--------|------------|
| 2025-10-04 | Initial creation with PowerShell notes | AI Assistant |

---

## Directory Structure

**Project Root:** `C:\Users\david\Documents\Skylark Creations\Local\decomposer\decomposer`

- Always ensure you're in this directory when running git commands
- The workspace path uses backslashes (Windows)

## Shell Environment

**Shell Type:** PowerShell (Windows)

### Important PowerShell Syntax Differences

❌ **DON'T USE:** Bash-style command chaining with `&&`
```powershell
cd /path && git status  # FAILS in PowerShell
```

✅ **DO USE:** PowerShell command separator `;`
```powershell
cd "C:\Users\david\Documents\Skylark Creations\Local\decomposer\decomposer"; git status
```

### Other PowerShell Tips
- Use double quotes around paths with spaces
- Semicolon (`;`) is the command separator, not `&&` or `||`
- Commands run from: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`

## Git Workflow

When committing and pushing changes:
1. Ensure you're in the project directory first
2. Use `git status` to verify you're in the right location
3. Stage files with `git add <files>`
4. Commit with descriptive messages
5. Push to `origin main`

## Common Commands

```powershell
# Check git status
git status

# Stage specific files
git add path/to/file

# Commit with message
git commit -m "feat: description"

# Push to GitHub
git push origin main

# Run npm commands
npm run dev
npm run build
npm test
```

## Tech Stack

- **Framework:** Next.js 14+ with TypeScript
- **AI:** OpenAI API (gpt-5-mini)
- **Analytics:** PostHog (see `.cursor/rules/posthog-integration.mdc`)
- **Storage:** Redis/KV for plan persistence
- **Package Manager:** npm

## 🔄 When to Update This Document

Update immediately when:
- ✅ Shell or OS changes
- ✅ Major dependency upgrades (Next.js, TypeScript, etc.)
- ✅ New external services added
- ✅ Development workflow changes
- ✅ You discover a new gotcha or common mistake
- ✅ Directory structure changes

Review periodically:
- 📅 Every 7 days to check for drift
- 📅 Before starting a major feature
- 📅 After onboarding new tools/services

## 🤖 AI Assistant Instructions

When starting a new session:
1. Check the "Last Updated" date at the top
2. If >7 days old, offer to review and update
3. If you discover environment changes during work, update this doc
4. Add entries to the Maintenance Log when making changes

