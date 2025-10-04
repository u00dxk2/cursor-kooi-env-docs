# .cursor Directory

This directory contains documentation and rules that help AI assistants work more effectively with this Python/Flask project.

## 📁 Files Overview

### Documentation
- **`project-environment.md`** - Complete environment documentation for this Python/Flask project
  - 🔄 Auto-checked by AI at session start
  - 📅 Review every 7 days
  - ✅ Update when environment changes

### Rules (Auto-loaded by AI)
- **`rules/environment-maintenance.mdc`** - Instructions for keeping environment docs current

### Templates
- **`quick-prompt.txt`** - Copy-paste prompt for generating/updating docs

### Utilities
- **`check-env-docs.ps1`** - PowerShell script to check documentation staleness
- **`check-env-docs.sh`** - Bash script to check documentation staleness

## 🔄 How It Works

### Automatic Updates
1. **At Session Start:** AI checks `project-environment.md` "Last Updated" date
2. **If >7 days old:** AI offers to review and update
3. **If >14 days old:** AI strongly recommends immediate review
4. **During Work:** AI updates when discovering environment changes

### Manual Check
Run the staleness check script anytime:

**Unix/macOS:**
```bash
./.cursor/check-env-docs.sh
```

**Windows:**
```powershell
.\.cursor\check-env-docs.ps1
```

**Output:**
- ✅ **CURRENT** - No action needed (< 7 days)
- ⚠️ **WARNING** - Review recommended (7-13 days)
- 🔴 **CRITICAL** - Update immediately (14+ days)

## 📝 When to Update Environment Docs

### Update Immediately When:
- requirements.txt dependencies change
- Python version requirements change
- New environment variables added
- Virtual environment setup changes
- Development workflow changes
- You discover a gotcha or common mistake

### Review Periodically:
- Every 7 days to check for drift
- Before starting major features
- After dependency upgrades

## 🎯 Python-Specific Benefits

- ✅ Correct virtual environment activation for each shell/OS
- ✅ pip vs pip3 clarity
- ✅ PYTHONPATH and import path documentation
- ✅ Common Python errors documented (ImportError, ModuleNotFoundError, etc.)
- ✅ Requirements.txt maintenance strategy

## 🤖 For AI Assistants

When starting a new session:
1. Read `project-environment.md`
2. Check the "Last Updated" date
3. Follow instructions in `rules/environment-maintenance.mdc`
4. Update docs when you discover environment changes
5. Add entries to the Maintenance Log

## 📚 Learn More

- [Cursor Environment Docs System](https://github.com/u00dxk2/cursor-kooi-env-docs)
- Main project README: `../../README.md`
- Setup guides: `../../docs/SETUP-GUIDE.md`

---

**This directory is part of the Cursor Environment Docs system - helping AI assistants stay smart about your Python project!**
