# .cursor Directory

This directory contains documentation and rules that help AI assistants work more effectively with this project.

## 📁 Files Overview

### Rules (Auto-loaded by AI)
- **`rules/project-environment.mdc`** - ⭐ Core environment context (shell, paths, tech stack, gotchas)
  - 🔄 **Automatically loaded** at every session start via `alwaysApply: true`
  - 📅 Review every 7 days
  - ✅ Update when environment changes
  
- **`rules/environment-maintenance.mdc`** - Instructions for keeping environment docs current

### Templates (For Other Projects)
- **`quick-prompt.txt`** - Copy-paste prompt for quick setup in other projects

### Utilities
- **`check-env-docs.ps1`** / **`check-env-docs.sh`** - Scripts to check if environment docs are stale
- **`validate-install.ps1`** / **`validate-install.sh`** - Scripts to validate the installation

## 🔄 How It Works

### Automatic Loading (New!)
1. **At Session Start:** `project-environment.mdc` is **automatically ingested** into AI context
   - Uses `alwaysApply: true` in frontmatter
   - No manual reading required
   - Guaranteed to be available from first message

2. **Automatic Checks:** AI checks "Last Updated" date in loaded content
   - **If >7 days old:** AI offers to review and update
   - **If >14 days old:** AI strongly recommends immediate review

3. **During Work:** AI updates when discovering environment changes

### Why `.mdc` Format?

**Previous approach (deprecated):**
- ❌ Plain `.md` file in `.cursor/` directory
- ❌ Required agent to manually read the file using tools
- ❌ Depended on agent following instructions to read it
- ❌ Could be skipped or forgotten

**New approach (current):**
- ✅ `.mdc` rule file in `.cursor/rules/` directory
- ✅ Automatically loaded by Cursor at session start
- ✅ Uses `alwaysApply: true` for guaranteed ingestion
- ✅ No dependency on agent behavior

**Key Insight from Research:**
> "Only `.mdc` files in `.cursor/rules/` are automatically loaded as rules. Plain `.md` files in `.cursor/` are NOT automatically ingested into AI context."

### Manual Check
Run the staleness check script:

**PowerShell:**
```powershell
.\.cursor\check-env-docs.ps1
```

**Bash/Zsh:**
```bash
./.cursor/check-env-docs.sh
```

Output:
- ✅ **CURRENT** - No action needed
- 🟡 **WARNING** - Review recommended (7+ days)
- 🔴 **CRITICAL** - Update immediately (14+ days)

## 📝 When to Update Environment Docs

Update **immediately** when:
- Shell or OS changes
- Major dependency upgrades
- New external services added
- Development workflow changes
- You discover a new gotcha or common mistake
- Directory structure changes

Review **periodically**:
- Every 7 days to check for drift
- Before starting a major feature
- After onboarding new tools/services

## 🚀 Using Templates for Other Projects

To set up environment docs on another project:

1. **Quick setup:** Copy content from `quick-prompt.txt` and send to AI assistant
2. **Copy the rules:** Copy both rule files to the new project's `.cursor/rules/` directory
   - `environment-maintenance.mdc`
   - Use `project-environment.mdc` as a template

The installer script handles this automatically:
```powershell
# PowerShell
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.ps1 | iex

# Bash/Zsh
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh | bash
```

## 🎯 Benefits

- ✅ AI assistants **automatically** have project context from session start
- ✅ No time wasted on syntax errors (PowerShell vs Bash, etc.)
- ✅ Consistent behavior across different AI sessions and agents
- ✅ Documents "gotchas" so you don't hit them twice
- ✅ Always up-to-date with automatic staleness checking
- ✅ Easy to replicate across projects via installer
- ✅ **Guaranteed context** - no dependency on agent reading instructions

## 📊 Maintenance Log Location

View recent changes to environment docs:
- Open `rules/project-environment.mdc`
- See "Maintenance Log" table at the top
- Shows date, change description, and who updated it

## 🤖 For AI Assistants

**Good news!** If you're reading this, you should already have `project-environment.mdc` loaded in your context due to `alwaysApply: true`.

When starting a new session:
1. ✅ Environment docs are **automatically loaded** (no manual reading needed)
2. Check the "Last Updated" date in the loaded content
3. Follow instructions in `rules/environment-maintenance.mdc`
4. Update docs when you discover environment changes
5. Add entries to the Maintenance Log

## 📚 Migration Notes

**If you have an old `.cursor/project-environment.md` file:**

The file has been migrated to `.cursor/rules/project-environment.mdc` with proper frontmatter:
```yaml
---
title: Project Environment Context
description: Core project environment information
alwaysApply: true
---
```

The old `.md` file can be safely deleted after confirming the new `.mdc` file is working.
