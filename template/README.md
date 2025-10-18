# .cursor Directory

This directory contains documentation and rules that help AI assistants work more effectively with this project.

> **⚠️ IMPORTANT:** The **documentation files** in this directory should be committed to Git and shared with your team.  
> **Do NOT add `.cursor/rules/` or documentation files to `.gitignore`** - they benefit all team members.  
> **DO add `.cursor/extensions/` and IDE state files to `.gitignore`** - see Version Control Guidelines below.

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

### Version Control Guidelines

**✅ Commit these files:**
- `rules/project-environment.mdc` - Environment documentation
- `rules/environment-maintenance.mdc` - Maintenance instructions
- `check-env-docs.ps1` / `check-env-docs.sh` - Staleness check scripts
- `validate-install.ps1` / `validate-install.sh` - Validation scripts
- `README.md` - This file

**❌ Do NOT commit (add to `.gitignore`):**
- `extensions/` - IDE-managed extensions (hundreds of MB, auto-downloaded)
- `ide_state.json` - User-specific IDE state
- `workspace_state.db` - User-specific workspace state
- `quick-prompt.txt` - Optional (your copy of the template from root)

**Why?** Documentation files are **project-wide** and benefit all team members. IDE state and extensions are **user-specific** and should not be shared.

**Recommendation:** Add this to your project's `.gitignore`:
```gitignore
# Cursor IDE (exclude auto-managed files)
.cursor/extensions/
.cursor/ide_state.json
.cursor/workspace_state.db
.cursor/quick-prompt.txt
```

## 🔄 How It Works

### Automatic Loading
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

**Key Insight:**
> Only `.mdc` files in `.cursor/rules/` are automatically loaded as rules. Plain `.md` files in `.cursor/` are NOT automatically ingested into AI context.

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

## 🎯 Benefits

- ✅ AI assistants **automatically** have project context from session start
- ✅ No time wasted on syntax errors (PowerShell vs Bash, etc.)
- ✅ Consistent behavior across different AI sessions and agents
- ✅ Documents "gotchas" so you don't hit them twice
- ✅ Always up-to-date with automatic staleness checking
- ✅ Easy to replicate across projects
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

## 🚀 Installation

This `.cursor` directory was installed using the [Cursor Environment Docs System](https://github.com/u00dxk2/cursor-kooi-env-docs).

To set up on another project, run the installer:

**PowerShell:**
```powershell
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.ps1 | iex
```

**Bash/Zsh:**
```bash
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh | bash
```
