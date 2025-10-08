# Frequently Asked Questions (FAQ)

Common questions about the Cursor Environment Docs system.

---

## 📋 Table of Contents

- [General Questions](#general-questions)
- [Installation & Setup](#installation--setup)
- [Usage & Workflow](#usage--workflow)
- [Security & Best Practices](#security--best-practices)
- [Compatibility](#compatibility)
- [Troubleshooting](#troubleshooting)
- [Customization](#customization)
- [Contributing](#contributing)

---

## General Questions

### What is Cursor Environment Docs?

A system that maintains auto-updating documentation about your development environment for Cursor. It helps Cursor understand your shell syntax, tech stack, common commands, and project-specific gotchas without you having to explain them repeatedly.

### Why do I need this?

If you use Cursor for AI-assisted development, you've probably:
- Wasted time explaining the same environment details repeatedly in new conversations
- Had Cursor suggest commands that don't work in your shell (PowerShell vs Bash)
- Hit the same environment gotchas across multiple sessions
- Seen inconsistent behavior between different Cursor conversations

This system solves all of that.

### How is this different from just using README.md?

README.md is for humans and focuses on "what" and "why". Environment docs are for AI assistants and focus on "how" - specifically:
- Exact shell syntax that works in YOUR environment
- Platform-specific command differences
- Common mistakes and gotchas
- Maintenance tracking with automatic staleness checking
- AI-specific instructions for keeping docs current

### Does this work with other AI tools besides Cursor?

**Designed for Cursor specifically.** The automatic features only work in Cursor:
- Cursor automatically reads `.cursor/` directory at session start
- Cursor automatically checks the "Last Updated" date
- Cursor automatically applies the maintenance rules

**Manual use with other tools:** You can share the `project-environment.mdc` file with other AI assistants (Claude, ChatGPT, etc.) by uploading or pasting it, but the automatic date checking and update system won't work. You'd need to manually remind them to check and update.

### Why is this Cursor-specific?

Cursor has built-in support for reading the `.cursor/` directory and applying rules from `.cursor/rules/*.mdc` files. Other AI tools don't have this directory convention or rule system, so they can't automatically maintain the documentation the way Cursor does.

---

## Installation & Setup

### How do I install this?

**One-line install:**

macOS/Linux:
```bash
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/v1.1.0/install.sh | bash
```

Windows PowerShell:
```powershell
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/v1.1.0/install.ps1 | iex
```

**Manual install:**
Copy the `template/` directory contents to your project's `.cursor/` directory.

### What if I don't have a git repository?

The installer warns but allows you to continue. However, this system works best with git because:
- Documentation should be version controlled
- Team members benefit from shared environment docs
- Changes are tracked over time

You can use it without git, but you'll lose these benefits.

### Do I need to install anything on my system?

No system dependencies! The system consists of:
- Markdown files (documentation)
- Shell scripts (optional staleness checkers)
- AI rules (text files)

All are plain text files that work anywhere.

### Can I install this in multiple projects?

**Absolutely!** Install it in every project where you use AI assistants. Each project gets its own environment documentation tailored to that specific stack.

### How does this work for multi-platform teams?

**Perfect for teams!** The key is documenting ALL platforms in a single shared document.

**The Problem (if done wrong):**
- Mac user documents Mac commands → commits
- Windows user replaces with Windows commands → commits
- Constant overwrites → frustration

**The Solution (do it right):**
Document all platforms side-by-side in `.cursor/rules/project-environment.mdc`:

```markdown
## Shell Environment

**Team Setup:**
- Windows developers (2 people): PowerShell 7+
- macOS developers (3 people): Zsh
- Linux developers (1 person): Bash

## Common Commands

### Start Dev Server

**PowerShell (Windows):**
```powershell
npm run dev
```

**Bash/Zsh (macOS/Linux):**
```bash
npm run dev
```

### Set Environment Variables

**PowerShell:**
```powershell
$env:NODE_ENV = "production"
```

**Bash/Zsh:**
```bash
export NODE_ENV=production
```
```

**Benefits:**
- ✅ No overwrites - all platforms coexist
- ✅ AI knows which syntax to use for each person
- ✅ New team members see all platforms
- ✅ Platform differences become valuable documentation

**See the complete guide:** [docs/TEAM-COLLABORATION.md](./TEAM-COLLABORATION.md)

### What if I already have a .cursor/ directory?

**The installer is safe!** By default, it **preserves all existing files**:

✅ **What happens:**
- Installer detects existing `.cursor/` directory
- Checks each file before downloading
- Skips files that already exist
- Only installs missing files
- Shows summary of what was installed vs. skipped

**Example output:**
```
⚠️  Existing .cursor/ setup detected
Existing files will be preserved (use --force to overwrite)

📥 Downloading template files...
  ✓ quick-prompt.txt
  ⚠ README.md (exists - skipped)
  ✓ environment-maintenance.mdc
  ⚠ check-env-docs.sh (exists - skipped)

✅ Installation complete!
📊 Summary:
  ✓ Installed: 2 file(s)
  ⚠ Skipped: 2 existing file(s)
```

**Need a clean reinstall?** Use the `--force` flag:
```bash
# Download installer first
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/v1.1.0/install.sh -o install.sh

# Run with --force to overwrite everything
bash install.sh --force

# Or PowerShell:
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/v1.1.0/install.ps1 -OutFile install.ps1
.\install.ps1 --force
```

### Should I commit .cursor/ to git?

**YES! Commit the entire `.cursor/` directory.** This is project documentation, not personal IDE settings.

**What to commit:**
```bash
git add .cursor/
git commit -m "feat: Add environment documentation system"
git push
```

**Why commit it:**
- Team members need these files
- Documentation should be version-controlled
- Scripts should be shared
- AI rules should be consistent across team

**Common mistake:** Some people think `.cursor/` is personal IDE settings (like `.vscode/settings.json`). It's not! Our `.cursor/` directory contains shared project documentation that benefits the entire team.

**Note:** If Cursor ever adds personal settings to `.cursor/` in the future, you can selectively ignore those files. But our documentation system files should always be committed.

### How do I uninstall?

Simply delete the `.cursor/` directory:
```bash
rm -rf .cursor  # Unix/macOS
Remove-Item -Recurse .cursor  # PowerShell
```

---

## Usage & Workflow

### How do I generate the initial documentation?

After installation:
1. Open project with your AI assistant
2. Paste the content from `.cursor/quick-prompt.txt`
3. AI generates `project-environment.mdc` specific to your project
4. Review and commit: `git add .cursor && git commit -m "feat: add environment docs"`

### How often should I update the docs?

- **Automatically**: AI offers to update when >7 days old
- **Manually**: Update immediately when:
  - Major dependency changes
  - Environment/shell changes
  - New gotchas discovered
  - Development workflow changes

### Do I need to tell Cursor to read the docs?

**No!** Cursor automatically reads files in the `.cursor/` directory at the start of each conversation. The maintenance rules in `.cursor/rules/environment-maintenance.mdc` tell Cursor to check the date and offer updates automatically.  

### What if I forget to update the docs?

The AI assistant will:
- Check the "Last Updated" date at session start
- Offer to review if >7 days old
- Strongly recommend update if >14 days old

You can also run the check script manually: `.cursor/check-env-docs.sh` (or `.ps1`)

### Can I customize the review frequency?

Yes! In `project-environment.mdc`, change:
```markdown
> **Review Frequency:** Check every 7 days
```

Update to `3 days`, `14 days`, or whatever suits your project.

---

## Security & Best Practices

### Should I store API keys or secrets in the environment documentation?

**❌ NEVER store actual secret values in the documentation!**

The `project-environment.mdc` file is:
- Committed to git (visible to all team members)
- Read by Cursor and sent to AI model providers (OpenAI, Anthropic, etc.)
- Potentially included in AI conversation logs

**✅ DO THIS instead:**
```markdown
## Environment Variables

Required `.env` variables:
- `API_KEY` - Your API key (get from dashboard)
- `DATABASE_URL` - Database connection string
- `SECRET_TOKEN` - Authentication secret

⚠️ **Never commit `.env` file to git!**
```

**❌ DON'T DO THIS:**
```markdown
## Environment Variables

- API_KEY=sk-abc123xyz789  ← NEVER DO THIS!
- DATABASE_URL=postgres://user:password@host/db  ← NEVER DO THIS!
```

### What information is safe to document?

**✅ SAFE to document:**
- Shell type (PowerShell, Bash, Zsh)
- Framework versions (Node 18, Python 3.11)
- Directory structure and paths
- Common commands and workflows
- Environment gotchas and mistakes
- Package manager commands
- Development server ports

**❌ NOT SAFE to document:**
- API keys, tokens, passwords
- Database credentials
- Private URLs or endpoints
- Personal information
- Team member names or emails (unless public)

### Is the installer script safe to run?

**Yes, with these security considerations:**

✅ **What makes it safe:**
- Downloads from official GitHub repository
- Creates only a `.cursor/` directory (project-level)
- Requires no admin/root privileges
- No system-level modifications
- Source code is visible and reviewable
- Uses HTTPS for all downloads

🔍 **Review before running:**
- [Bash installer source](https://github.com/u00dxk2/cursor-kooi-env-docs/blob/v1.0.0/install.sh)
- [PowerShell installer source](https://github.com/u00dxk2/cursor-kooi-env-docs/blob/v1.0.0/install.ps1)

**For security-conscious environments:**
- Clone the repository and review all files
- Run installer from local copy
- Or manually copy `template/` files to `.cursor/`

### What data does this system send to AI providers?

**What gets sent:**
- Contents of `.cursor/rules/project-environment.mdc` (your environment docs)
- Contents of `.cursor/rules/*.mdc` (behavior rules for AI)

**What does NOT get sent:**
- Your actual code files (unless you share them separately)
- Your `.env` file
- Anything outside `.cursor/` directory

**Key point:** Treat `.cursor/` files like documentation - only include information you'd be comfortable in a public README.

---

## Compatibility

### Does this work on Windows?

**Yes!** Fully supported. The installer includes PowerShell versions of all scripts, and the documentation covers PowerShell-specific syntax.

### Does this work on macOS?

**Yes!** Works on both Intel and Apple Silicon Macs.

### Does this work on Linux?

**Yes!** Tested on Ubuntu, Debian, and other major distributions.

### Does this work with WSL (Windows Subsystem for Linux)?

**Yes!** WSL is treated as a Linux environment. Use the Bash installer and scripts.

### Does this work in Docker containers?

**Yes!** Install it in your project before containerizing. The `.cursor/` directory will be included in your container image.

### Does this work with monorepos?

**Yes!** Install in the monorepo root. You can also create project-specific docs in subdirectories:
```
monorepo/
├── .cursor/                    # Monorepo-level docs
├── packages/
│   ├── frontend/
│   │   └── .cursor/           # Frontend-specific docs
│   └── backend/
│       └── .cursor/            # Backend-specific docs
```

### What shells are supported?

- **Unix:** Bash, Zsh, Fish
- **Windows:** PowerShell, Command Prompt
- **Others:** Any shell - just document its specific syntax

### What programming languages does this support?

**All of them!** This system is language-agnostic. We have examples for:
- Node.js/JavaScript
- Python
- *(More coming)*

But it works with any language or framework.

---

## Troubleshooting

### The installer fails to download files

**Causes:**
- No internet connection
- GitHub is down
- Firewall blocking downloads
- SSL/TLS issues

**Solutions:**
1. Check internet connection
2. Try manual installation (copy `template/` files)
3. Check firewall settings
4. Use a VPN if needed

### PowerShell says "execution policy" error

**Error:**
```
cannot be loaded because running scripts is disabled on this system
```

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

This allows running scripts you've downloaded.

### Check script says "command not found"

**On Unix/macOS:**
```bash
chmod +x .cursor/check-env-docs.sh
./.cursor/check-env-docs.sh
```

Make sure the script is executable.

**On Windows:**
Run from PowerShell, not Command Prompt.

### AI doesn't offer to update the docs

**Possible causes:**
1. **Last Updated format wrong**: Must be `> **Last Updated:** YYYY-MM-DD`
2. **Doc is current**: Less than 7 days old
3. **Rule file missing**: Check `.cursor/rules/environment-maintenance.mdc` exists
4. **AI session restart needed**: Start a fresh conversation

### Date parsing fails on macOS

**Cause:** BSD date vs GNU date syntax  
**Solution:** The check script handles both. If you modified it, see `template/check-env-docs.sh` for the correct conditional logic.

### Documentation file not found

**Error:**
```
ERROR: Environment documentation not found at .cursor/rules/project-environment.mdc
```

**Solution:**
You haven't generated the docs yet. Run the quick-prompt to have AI create it, or create it manually based on the template.

---

## Customization

### Can I change the directory name from `.cursor`?

**Technically yes**, but not recommended because:
- Cursor automatically recognizes `.cursor/` directory
- Examples and docs assume this location
- Consistency helps with troubleshooting

If you must change it, update all paths in scripts and documentation.

### Can I add custom sections to the docs?

**Absolutely!** The `project-environment.mdc` is YOUR documentation. Add sections for:
- Deployment procedures
- Database migration steps
- API integration notes
- Team conventions
- Anything AI assistants should know

### Can I use this for non-code projects?

**Sure!** While designed for code projects, you could use it for:
- Documentation projects
- Configuration management
- Infrastructure as code
- Any project where environment context helps

### Can I create templates for specific frameworks?

**Yes!** See `template/rules/project-environment.mdc` for the generic template. You can create framework-specific templates:
- `template-nextjs.md`
- `template-django.md`
- `template-rust.md`

Share them with the community!

---

## Contributing

### How can I contribute?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines. Ways to help:
- Report bugs
- Suggest features
- Add example projects
- Improve documentation
- Submit pull requests

### Can I add examples for my favorite framework?

**Please do!** We need examples for more frameworks. See `examples/` directory for structure. Requirements:
- Complete `.cursor/` directory
- Working minimal code example
- Comprehensive `project-environment.mdc`
- Clear README explaining the example

### How do I report bugs?

Open an issue on GitHub: https://github.com/u00dxk2/cursor-kooi-env-docs/issues

Include:
- OS and shell
- Steps to reproduce
- Expected vs actual behavior
- Error messages

### Can I fork this and modify it?

**Yes!** MIT License - use however you want. If you make improvements, consider contributing back!

---

## Still Have Questions?

- 📖 [Read the main README](../README.md)
- 📝 [Check the Setup Guide](SETUP-GUIDE.md)
- 🐛 [Search existing issues](https://github.com/u00dxk2/cursor-kooi-env-docs/issues)
- 💬 [Start a discussion](https://github.com/u00dxk2/cursor-kooi-env-docs/discussions)

---

**Last Updated:** 2025-10-04

