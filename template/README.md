# .cursor Directory

This directory contains documentation and rules that help AI assistants work more effectively with this project.

> **⚠️ IMPORTANT:** This entire directory should be committed to Git and shared with your team.  
> **Do NOT add `.cursor/` to `.gitignore`** - it contains project documentation, not personal preferences.

## 📁 Files Overview

### Documentation
- **`project-environment.mdc`** - Current environment setup, shell syntax, common commands, tech stack
  - 🔄 Auto-checked by AI at session start
  - 📅 Review every 7 days
  - ✅ Update when environment changes

### Rules (Auto-loaded by AI)
- **`rules/posthog-integration.mdc`** - PostHog analytics integration guidelines
- **`rules/environment-maintenance.mdc`** - Instructions for keeping environment docs current

### Templates (For Other Projects)
- **`create-environment-docs-prompt.md`** - Comprehensive guide for creating environment docs
- **`quick-prompt.txt`** - Copy-paste prompt for quick setup

### Utilities
- **`check-env-docs.ps1`** - PowerShell script to check if environment docs are stale

## 🔄 How It Works

### Automatic Updates
1. **At Session Start:** AI checks `project-environment.mdc` "Last Updated" date
2. **If >7 days old:** AI offers to review and update
3. **If >14 days old:** AI strongly recommends immediate review
4. **During Work:** AI updates when discovering environment changes

### Manual Check
Run the staleness check script:
```powershell
.\.cursor\check-env-docs.ps1
```

Output:
- ✅ **CURRENT** - No action needed
- 🟡 **WARNING** - Review recommended (7+ days)
- 🔴 **CRITICAL** - Update immediately (14+ days)

## 📝 When to Update Environment Docs

Update **immediately** when:
- Shell or OS changes
- Major dependency upgrades (Next.js, TypeScript, etc.)
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
2. **Detailed setup:** Share `create-environment-docs-prompt.md` with AI assistant
3. **Copy the rule:** Copy `rules/environment-maintenance.mdc` to the new project

## 🎯 Benefits

- ✅ AI assistants immediately understand your environment
- ✅ No time wasted on syntax errors (PowerShell vs Bash, etc.)
- ✅ Consistent behavior across different AI sessions
- ✅ Documents "gotchas" so you don't hit them twice
- ✅ Always up-to-date with automatic staleness checking
- ✅ Easy to replicate across projects

## 📊 Maintenance Log Location

View recent changes to environment docs:
- Open `project-environment.mdc`
- See "Maintenance Log" table at the top
- Shows date, change description, and who updated it

## 🤖 For AI Assistants

When starting a new session:
1. Read `project-environment.mdc` 
2. Check the "Last Updated" date
3. Follow instructions in `rules/environment-maintenance.mdc`
4. Update docs when you discover environment changes
5. Add entries to the Maintenance Log

