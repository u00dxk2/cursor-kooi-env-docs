# Quick Setup Cheat Sheet

## 🔧 EXISTING PROJECT (3 Steps)

```
Step 1: Copy Files
─────────────────
📁 Copy to your project's .cursor/ directory:
   ✓ quick-prompt.txt
   ✓ rules/environment-maintenance.mdc
   ✓ check-env-docs.ps1 (or .sh for Mac/Linux)

Step 2: Generate Docs
──────────────────────
Open the project with Cursor and paste:
   ✓ Content from .cursor/quick-prompt.txt

Step 3: Commit
──────────────
   ✓ git add .cursor/
   ✓ git commit -m "feat: Add environment docs system"
   ✓ git push
```

**Total time:** ~5 minutes

---

## 🆕 NEW PROJECT (2 Steps)

```
Step 1: Copy Entire Directory
──────────────────────────────
cp -r /path/to/decomposer/.cursor ./your-new-project/

Step 2: Generate Docs
──────────────────────
Open with Cursor and paste prompt from quick-prompt.txt
```

**Total time:** ~3 minutes

---

## 📋 Files You Need

### Required:
- ✅ `.cursor/project-environment.md` (AI generates this)
- ✅ `.cursor/rules/environment-maintenance.mdc` (copy from here)

### Helpful:
- 📄 `.cursor/quick-prompt.txt` (for generating docs)
- 🔍 `.cursor/check-env-docs.ps1` (to check staleness)
- 📖 `.cursor/README.md` (explains the system)

---

## ✨ What You Get

✅ Cursor knows your environment immediately  
✅ No time wasted on syntax errors  
✅ Auto-updated every 7 days  
✅ Documents gotchas so you never repeat them  
✅ Works across all Cursor sessions  

---

## 🚀 One-Liner Setup

**Copy system files to another project:**
```powershell
# Windows
Copy-Item ".cursor\quick-prompt.txt", ".cursor\rules\environment-maintenance.mdc", ".cursor\check-env-docs.ps1" -Destination "C:\path\to\other-project\.cursor\" -Force

# Mac/Linux
cp .cursor/{quick-prompt.txt,check-env-docs.sh} .cursor/rules/environment-maintenance.mdc /path/to/other-project/.cursor/
```

Then have AI generate the `project-environment.md` file.

**Done!** 🎉

