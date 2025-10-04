# Troubleshooting Guide

Solutions to common problems with the Cursor Environment Docs system.

---

## 📋 Table of Contents

- [Installation Issues](#installation-issues)
- [Script Execution Problems](#script-execution-problems)
- [AI Integration Issues](#ai-integration-issues)
- [Git & Version Control](#git--version-control)
- [Platform-Specific Issues](#platform-specific-issues)
- [Documentation Issues](#documentation-issues)

---

## Installation Issues

### Problem: Installer fails with "command not found"

**Symptoms:**
```bash
bash: curl: command not found
# or
irm : The term 'irm' is not recognized
```

**Solutions:**

**For Unix/macOS (missing curl):**
```bash
# Install curl
sudo apt install curl         # Debian/Ubuntu
sudo yum install curl          # RHEL/CentOS
brew install curl              # macOS

# Or use wget instead
wget -O- https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh | bash
```

**For Windows (not PowerShell):**
- Make sure you're using PowerShell, not Command Prompt
- `irm` is a PowerShell alias, won't work in cmd.exe

---

### Problem: "Cannot download files from GitHub"

**Symptoms:**
```
Failed to download quick-prompt.txt
Failed to download environment-maintenance.mdc
```

**Possible Causes & Solutions:**

1. **No internet connection**
   - Check your network connection
   - Try: `ping github.com`

2. **Corporate firewall blocking GitHub**
   - Check with IT department
   - Use manual installation (see below)

3. **SSL/TLS certificate issues**
   ```bash
   # Unix/macOS - temporarily skip SSL verification (not recommended)
   curl -k -fsSL https://...
   
   # Windows PowerShell
   [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
   ```

4. **GitHub rate limiting**
   - Wait a few minutes and try again
   - Use manual installation

**Manual Installation Workaround:**
```bash
# 1. Download the repo as ZIP from GitHub
# 2. Extract it
# 3. Copy template/ folder contents to your project's .cursor/ folder
cp -r path/to/extracted/template/* .cursor/
```

---

### Problem: "Permission denied" during installation

**Symptoms:**
```bash
mkdir: cannot create directory '.cursor': Permission denied
```

**Solutions:**

1. **Check you're in the right directory**
   ```bash
   pwd  # Should be your project root
   cd /path/to/your/project
   ```

2. **Check directory permissions**
   ```bash
   ls -la
   # Should show you own the directory
   ```

3. **If directory is owned by root/another user**
   ```bash
   sudo chown -R $USER:$USER .
   ```

---

## Script Execution Problems

### Problem: PowerShell "execution policy" error

**Symptoms:**
```powershell
.\.cursor\check-env-docs.ps1 : File cannot be loaded because running scripts 
is disabled on this system.
```

**Solution:**

**Option 1: Set execution policy for current user (recommended)**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Option 2: Bypass for single execution**
```powershell
PowerShell -ExecutionPolicy Bypass -File .\.cursor\check-env-docs.ps1
```

**Option 3: Unblock the specific file**
```powershell
Unblock-File .\.cursor\check-env-docs.ps1
```

**To check current policy:**
```powershell
Get-ExecutionPolicy -List
```

---

### Problem: Bash script "permission denied"

**Symptoms:**
```bash
bash: ./.cursor/check-env-docs.sh: Permission denied
```

**Solution:**

**Make script executable:**
```bash
chmod +x .cursor/check-env-docs.sh
```

**Then run:**
```bash
./.cursor/check-env-docs.sh
```

**Alternative - run with bash explicitly:**
```bash
bash .cursor/check-env-docs.sh
```

---

### Problem: Check script reports "command not found: date"

**Symptoms:**
```bash
./.cursor/check-env-docs.sh: line 23: date: command not found
```

**Solution:**

This is rare, but on minimal systems:

**For Linux:**
```bash
sudo apt install coreutils  # Debian/Ubuntu
sudo yum install coreutils  # RHEL/CentOS
```

**For macOS:**
`date` should be built-in. If missing, reinstall Command Line Tools:
```bash
xcode-select --install
```

---

### Problem: Date parsing fails on macOS

**Symptoms:**
```bash
date: illegal option -- -
```

**Cause:**
macOS uses BSD date, not GNU date. Script has different syntax.

**Solution:**
The provided `check-env-docs.sh` handles both. If you modified the script, use this conditional:

```bash
if date --version >/dev/null 2>&1; then
    # GNU date (Linux)
    LAST_UPDATED_SECONDS=$(date -d "$LAST_UPDATED" +%s)
else
    # BSD date (macOS)
    LAST_UPDATED_SECONDS=$(date -j -f "%Y-%m-%d" "$LAST_UPDATED" +%s)
fi
```

---

## AI Integration Issues

### Problem: AI doesn't offer to update documentation

**Symptoms:**
- Documentation is >7 days old
- AI never mentions updating it
- No automatic checking behavior

**Possible Causes & Solutions:**

**1. Rule file missing**
```bash
# Check if it exists
ls -la .cursor/rules/environment-maintenance.mdc

# If missing, copy from template
cp template/rules/environment-maintenance.mdc .cursor/rules/
```

**2. Date format incorrect**

Must be exactly: `> **Last Updated:** 2025-10-04`

❌ Wrong:
```markdown
Last Updated: 2025-10-04
**Last Updated:** 2025-10-04
> Last Updated: 2025-10-04
```

✅ Correct:
```markdown
> **Last Updated:** 2025-10-04  
> **Review Frequency:** Check every 7 days  
> **Next Review:** 2025-10-11
```

**3. Need fresh AI session**
- AI rules are loaded at session start
- Close and restart your AI conversation
- In Cursor: Start a new conversation in a new tab

**4. File not in expected location**
```bash
# Must be at:
.cursor/project-environment.md

# Not:
.cursor/docs/project-environment.md
cursor/project-environment.md
```

---

### Problem: Cursor doesn't read `.cursor/` directory

**Symptoms:**
- AI seems unaware of environment docs
- Acts like files don't exist

**Solutions:**

**1. Verify files exist**
```bash
ls -la .cursor/
# Should show:
# - project-environment.md
# - rules/environment-maintenance.mdc
```

**2. Check you're in project root**
```bash
pwd
# Should be your project's root directory where .cursor/ lives
```

**3. Restart Cursor**
- Completely quit Cursor
- Reopen your project

**4. Check Cursor settings**
- Ensure `.cursor/` isn't in `.cursorignore`
- Check workspace trust settings

---

### Note: Using with Other AI Tools (Claude, ChatGPT, etc.)

**This tool is designed specifically for Cursor.** The automatic date checking and maintenance system relies on Cursor's built-in support for the `.cursor/` directory and `.mdc` rule files.

**If you want to use the documentation with other AI tools:**
- You'll need to manually upload or paste the `project-environment.md` file each session
- The automatic "check if >7 days old" feature won't work
- You'll need to manually remind the AI to check and update the documentation
- It becomes a static reference document rather than an auto-maintaining system

**For automatic maintenance, use Cursor.** That's what this tool was built for.

---

## Git & Version Control

### Problem: Should I add .cursor/ to .gitignore?

**NO! Do NOT add `.cursor/` to `.gitignore`!**

**Common Mistake:**
Some people think `.cursor/` is like `.vscode/settings.json` (personal IDE settings) and should be ignored. **This is wrong for our system!**

**Correct Approach:**
```bash
# Commit the entire .cursor/ directory
git add .cursor/
git commit -m "feat: Add environment documentation system"
git push
```

**Why commit it:**
- This is **shared project documentation**, not personal settings
- Team members need these files for consistent AI behavior
- Documentation should be version-controlled
- Scripts and rules should be shared

**What's in `.cursor/` that should be shared:**
- `project-environment.md` - Project documentation
- `rules/*.mdc` - AI behavior rules
- `check-env-docs.ps1/.sh` - Utility scripts
- `validate-install.ps1/.sh` - Validation scripts
- `quick-prompt.txt` - Template
- `README.md` - System overview

**Exception:** If Cursor adds personal settings later (like cache files), you can selectively ignore those:
```gitignore
# Ignore personal Cursor settings (if they appear)
.cursor/cache/
.cursor/.local

# Keep our documentation system (everything else)
```

But **by default, commit everything in `.cursor/`** for this system to work properly.

---

### Problem: Git tracking `.env` file

**Symptoms:**
```bash
git status
# Shows: .env (should be ignored)
```

**Solution:**

**Add to .gitignore:**
```bash
echo ".env" >> .gitignore
```

**If already committed:**
```bash
# Remove from git but keep local file
git rm --cached .env
git commit -m "fix: stop tracking .env file"
```

---

### Problem: `node_modules/` or `venv/` being committed

**Symptoms:**
Repo is huge (100s of MB), slow to push/pull

**Solution:**

**Add to .gitignore:**
```bash
echo "node_modules/" >> .gitignore  # For Node.js
echo "venv/" >> .gitignore          # For Python
```

**If already committed:**
```bash
# Remove from git but keep local
git rm -r --cached node_modules/  # or venv/
git commit -m "fix: stop tracking dependencies"
```

---

### Problem: Line ending issues (CRLF vs LF)

**Symptoms:**
```
warning: CRLF will be replaced by LF
```

**Background:**
- Windows uses CRLF (`\r\n`)
- Unix/Mac uses LF (`\n`)
- Can cause script failures

**Solution:**

**Windows (normalize to CRLF):**
```bash
git config --global core.autocrlf true
```

**Unix/macOS (normalize to LF):**
```bash
git config --global core.autocrlf input
```

**Force LF for shell scripts (.gitattributes):**
```bash
# Create .gitattributes
echo "*.sh text eol=lf" >> .gitattributes
```

---

## Platform-Specific Issues

### Windows Issues

#### Problem: Path with spaces breaks commands

**Symptoms:**
```powershell
cd C:\My Projects\app  # Fails
```

**Solution:**
```powershell
cd "C:\My Projects\app"  # Use quotes
```

#### Problem: Can't run `.sh` files on Windows

**Solution:**
- Use `.ps1` versions instead
- Or install Git Bash / WSL

---

### macOS Issues

#### Problem: Python 3 not found

**Symptoms:**
```bash
python: command not found
```

**Cause:**
macOS comes with Python 2 (deprecated). Python 3 must be installed separately.

**Solution:**
```bash
# Install with Homebrew
brew install python3

# Use python3 command
python3 --version
```

#### Problem: "xcrun: error: invalid active developer path"

**Cause:**
Command Line Tools not installed

**Solution:**
```bash
xcode-select --install
```

---

### Linux Issues

#### Problem: `python3-venv` not found

**Symptoms:**
```bash
The virtual environment was not created successfully because ensurepip is not available
```

**Solution:**
```bash
# Debian/Ubuntu
sudo apt update
sudo apt install python3-venv python3-pip

# RHEL/CentOS
sudo yum install python3-virtualenv
```

---

## Documentation Issues

### Problem: "Last Updated" date not found by check script

**Symptoms:**
```
WARNING: Could not find 'Last Updated' date in the document
```

**Solution:**

**Check format exactly matches:**
```markdown
> **Last Updated:** 2025-10-04
```

**Common mistakes:**
- Missing `>` prefix
- Missing `**` around "Last Updated"
- Missing colon `:`
- Wrong date format (must be `YYYY-MM-DD`)
- Extra spaces

**Use this exact template:**
```markdown
> **Last Updated:** YYYY-MM-DD  
> **Review Frequency:** Check every 7 days  
> **Next Review:** YYYY-MM-DD
```

---

### Problem: Documentation file doesn't exist

**Symptoms:**
```
ERROR: Environment documentation not found at .cursor/project-environment.md
```

**Solution:**

You need to generate it. Two options:

**Option 1: Use AI assistant**
```bash
# Show the prompt
cat .cursor/quick-prompt.txt

# Copy and paste to your AI assistant
# AI will generate project-environment.md
```

**Option 2: Copy template**
```bash
cp template/project-environment.md .cursor/project-environment.md
# Edit to match your project
```

---

### Problem: Check script always says "CRITICAL"

**Symptoms:**
Even after updating, status shows CRITICAL

**Possible Causes:**

**1. Date not actually updated**
```bash
# Check the file
head -10 .cursor/project-environment.md
# Should show today's date
```

**2. Date format wrong**
Must be `YYYY-MM-DD` (ISO 8601)

❌ Wrong: `10-04-2025`, `2025/10/04`, `Oct 4, 2025`  
✅ Correct: `2025-10-04`

**3. Cached file content**
```bash
# Force re-read
cat .cursor/project-environment.md | grep "Last Updated"
```

---

## Still Having Issues?

### Check Basics
1. ✅ Are you in the project root directory?
2. ✅ Does `.cursor/project-environment.md` exist?
3. ✅ Does `.cursor/rules/environment-maintenance.mdc` exist?
4. ✅ Is the "Last Updated" format correct?
5. ✅ Have you restarted your AI session?

### Get Help
- 📖 [Read the FAQ](FAQ.md)
- 🐛 [Search existing issues](https://github.com/u00dxk2/cursor-kooi-env-docs/issues)
- 💬 [Ask in discussions](https://github.com/u00dxk2/cursor-kooi-env-docs/discussions)
- 🆕 [Open a new issue](https://github.com/u00dxk2/cursor-kooi-env-docs/issues/new)

### When Opening an Issue
Include:
- **Operating System**: Windows 10, macOS 14, Ubuntu 22.04, etc.
- **Shell**: PowerShell, Bash, Zsh, etc.
- **Command run**: Exact command you executed
- **Error message**: Full error output
- **Steps to reproduce**: What you did before the error
- **Expected behavior**: What you thought would happen
- **Actual behavior**: What actually happened

---

**Last Updated:** 2025-10-04

