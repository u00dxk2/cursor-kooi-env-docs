# Environment Documentation Setup Guide

Quick guide for adding the auto-updating environment documentation system to your projects.

---

## 📦 For EXISTING Projects

### Step 1: Copy the System Files

Copy these files from this project to your target project:

```
Source (this project)                    → Destination (your project)
─────────────────────────────────────────────────────────────────────
.cursor/quick-prompt.txt                 → .cursor/quick-prompt.txt
.cursor/rules/environment-maintenance.mdc → .cursor/rules/environment-maintenance.mdc
.cursor/check-env-docs.ps1 or .sh        → .cursor/check-env-docs.ps1 or .sh
.cursor/README.md                        → .cursor/README.md (optional)
```

**Quick copy commands:**

**Windows (PowerShell):**
```powershell
# From this project directory
$source = "C:\path\to\decomposer\.cursor"
$dest = "C:\path\to\your-project\.cursor"

# Create destination directory if needed
New-Item -ItemType Directory -Force -Path "$dest\rules"

# Copy files
Copy-Item "$source\quick-prompt.txt" -Destination "$dest\"
Copy-Item "$source\rules\environment-maintenance.mdc" -Destination "$dest\rules\"
Copy-Item "$source\check-env-docs.ps1" -Destination "$dest\"
Copy-Item "$source\README.md" -Destination "$dest\" # optional
```

**macOS/Linux (Bash):**
```bash
# From this project directory
source="/path/to/decomposer/.cursor"
dest="/path/to/your-project/.cursor"

# Create destination directory if needed
mkdir -p "$dest/rules"

# Copy files
cp "$source/quick-prompt.txt" "$dest/"
cp "$source/rules/environment-maintenance.mdc" "$dest/rules/"
cp "$source/check-env-docs.sh" "$dest/"  # if you create a bash version
cp "$source/README.md" "$dest/"  # optional
```

### Step 2: Generate Project-Specific Documentation

Open your target project in Cursor and paste this prompt:

```
Please create a `.cursor/rules/project-environment.mdc` file documenting this development environment. Include:

1. **Directory Structure** - Absolute project root path and path format (Windows/Unix)

2. **Shell Environment** - Shell type (PowerShell/Bash/Zsh) and critical syntax differences
   - Show examples of commands that fail vs work (e.g., `&&` vs `;` in PowerShell)
   
3. **Common Commands** - Git workflow, package manager, build/test/dev commands with correct syntax for this shell

4. **Tech Stack** - Framework, language versions, key dependencies, databases, external APIs

5. **Environment Gotchas** - Mistakes to avoid, line endings, path issues, quirks you've encountered

6. **Development Workflow** - How to start dev server, run tests, build, lint/format

Optional: API keys needed (no values!), external services, IDE recommendations, links to other `.cursor/rules/` docs

Use ✅/❌ to show correct vs incorrect approaches. Keep it concise but practical.

**IMPORTANT: Add maintenance tracking at the top:**
```
> **Last Updated:** YYYY-MM-DD  
> **Review Frequency:** Check every 7 days  
> **Next Review:** YYYY-MM-DD

## 📋 Maintenance Log
| Date | Change | Updated By |
```

**Add AI instructions at the bottom:**
```
## 🤖 AI Assistant Instructions
When starting a new session:
1. Check the "Last Updated" date at the top
2. If >7 days old, offer to review and update
3. Update this doc when you discover environment changes
```

After creating it, commit the file to the repository so it's preserved for future sessions.
```

### Step 3: Commit Everything

```bash
git add .cursor/
git commit -m "feat: Add auto-updating environment documentation system"
git push
```

### Step 4: Test It

Run the check script:
```powershell
# Windows
.\.cursor\check-env-docs.ps1

# macOS/Linux
./.cursor/check-env-docs.sh
```

You should see: **Status: CURRENT - No action needed**

---

## 🆕 For NEW Projects

### Option A: Copy During Project Creation

When setting up a new project from scratch:

1. **Create the project structure**
   ```bash
   mkdir my-new-project
   cd my-new-project
   git init
   ```

2. **Copy the `.cursor` directory** from this project:
   ```powershell
   # Windows
   Copy-Item "C:\path\to\decomposer\.cursor" -Destination "." -Recurse
   
   # macOS/Linux
   cp -r /path/to/decomposer/.cursor ./
   ```

3. **Have AI generate the documentation** using the same prompt from Step 2 above

4. **Commit it**
   ```bash
   git add .cursor/
   git commit -m "feat: Add environment documentation system"
   ```

### Option B: Use as a Template

Create a **project template** repository:

1. **Create a new GitHub repo** called `project-template` or similar

2. **Add just the `.cursor` directory** with all the system files:
   ```
   project-template/
   └── .cursor/
       ├── README.md
       ├── quick-prompt.txt
       ├── check-env-docs.ps1
       ├── rules/
      │   ├── environment-maintenance.mdc
      │   └── project-environment.mdc (template version)
   ```

3. **When starting a new project:**
   ```bash
   # Clone or copy from template
   git clone https://github.com/you/project-template my-new-project
   cd my-new-project
   
   # Remove template git history
   rm -rf .git
   git init
   
   # Update project-environment.mdc for this specific project
   # (or have AI regenerate it)
   
   # Start building your project
   ```

### Option C: Package Manager (Future Enhancement)

You could create an npm package or similar:
```bash
npx create-cursor-docs
# or
npm install -g cursor-env-docs
cursor-env-docs init
```

*(Not implemented yet, but a good future improvement!)*

---

## ✅ Verification Checklist

After setup, verify everything works:

- [ ] `.cursor/rules/project-environment.mdc` exists with current date
- [ ] `.cursor/rules/environment-maintenance.mdc` exists
- [ ] Check script runs without errors
- [ ] Cursor reads the doc at session start
- [ ] Cursor offers to update when doc is >7 days old
- [ ] All files are committed to git

---

## 🔄 Ongoing Maintenance

**For You:**
- Run `.cursor/check-env-docs.ps1` occasionally to check staleness
- When you discover new gotchas, ask AI to update the doc

**For AI:**
- AI automatically checks at each session start
- AI updates proactively when discovering environment changes
- AI adds entries to the Maintenance Log

---

## 💡 Pro Tips

1. **Customize the review period** - Change 7 days to whatever makes sense:
   - Fast-moving projects: 3-5 days
   - Stable projects: 14 days

2. **Add project-specific rules** - Create additional `.cursor/rules/*.mdc` files for:
   - Code style guidelines
   - API integration patterns
   - Deployment procedures

3. **Share with team** - The `.cursor` directory benefits everyone:
   - Human developers using Cursor
   - All team members' Cursor instances
   - New team members onboarding

4. **Keep it updated** - The system only works if you let AI update it:
   - Don't decline every update offer
   - Update immediately when major changes happen
   - Review it before starting big features

---

## 🆘 Troubleshooting

**"AI doesn't offer to update the doc"**
- Check that `.cursor/rules/environment-maintenance.mdc` exists
- Verify the "Last Updated" format in the doc is correct
- Try starting a completely new conversation thread

**"Check script fails"**
- Make sure you're running from project root
- Check that `.cursor/rules/project-environment.mdc` exists
- Verify the "Last Updated" line format matches the regex

**"Doc is always marked as current even when old"**
- Check the date format: must be `YYYY-MM-DD`
- Verify it's in the right format: `> **Last Updated:** 2025-10-04`

---

## 📚 Related Files

- **Full guide:** `.cursor/create-environment-docs-prompt.md`
- **Quick prompt:** `.cursor/quick-prompt.txt`  
- **AI rules:** `.cursor/rules/environment-maintenance.mdc`
- **This project's example:** `.cursor/rules/project-environment.mdc`

