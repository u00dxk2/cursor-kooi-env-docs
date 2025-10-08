# Team Collaboration Guide

Best practices for using Cursor Environment Docs across multi-platform teams.

---

## 🤝 The Team Collaboration Pattern

### Core Principle

**The `.cursor/project-environment.mdc` file is a SHARED team reference that documents ALL team members' environments, not just one person's.**

Think of it like a README for AI assistants - it should cover:
- ✅ Windows developers' setup
- ✅ macOS developers' setup  
- ✅ Linux developers' setup
- ✅ All platform-specific quirks

### Why This Works

**Benefits:**
1. **Single source of truth** - Everyone references the same documentation
2. **No platform wars** - All platforms coexist in the same document
3. **AI context for everyone** - Cursor knows which syntax to use for which platform
4. **Smoother onboarding** - New team members see all platforms at once
5. **Reveals cross-platform issues** - Forces team to be explicit about differences

---

## 📝 Documentation Pattern

### ✅ DO THIS: Document All Platforms

```markdown
## Shell Environment

**Team Setup:**
- Windows developers (3 people): PowerShell 7+
- macOS developers (2 people): Zsh (default)
- Linux developers (1 person): Bash

## Common Commands

### Start Development Server

**PowerShell (Windows):**
```powershell
npm run dev
```

**Bash/Zsh (macOS/Linux):**
```bash
npm run dev
```

### Build for Production

**PowerShell:**
```powershell
npm run build; npm run test
```

**Bash/Zsh:**
```bash
npm run build && npm run test
```

### Environment Variables

**PowerShell:**
```powershell
$env:NODE_ENV = "development"
$env:DATABASE_URL = "postgresql://localhost/mydb"
```

**Bash/Zsh:**
```bash
export NODE_ENV=development
export DATABASE_URL=postgresql://localhost/mydb
```
```

### ❌ DON'T DO THIS: Single Platform Only

```markdown
## Commands

Start server:
npm run dev

Build:
npm run build && npm test

Set env:
export NODE_ENV=development
```

**Problem:** Only covers Unix/Mac, Windows developers are lost.

---

## 🔄 Workflow for Team Updates

### When Starting a New Project

**First person (any platform):**
1. Run installer
2. Create initial `project-environment.mdc`
3. Document THEIR platform
4. **Note in doc:** "Other platforms TBD - please add your setup!"
5. Commit and push

**Second person (different platform):**
1. Pull latest code
2. Open `.cursor/project-environment.mdc`
3. **ADD** their platform's commands (don't replace!)
4. Update team setup section to list both platforms
5. Commit and push

**Third person and beyond:**
1. Pull latest
2. Add their platform if different
3. Or verify existing documentation works for them

### When Making Environment Changes

**Example: Adding a new npm script**

```markdown
## Common Commands

### Run Tests

**All Platforms:**
```bash
npm test
```

### Run Tests with Coverage

**All Platforms:**
```bash
npm run test:coverage
```
```

If command syntax is the same across platforms, just document once with "All Platforms" note.

### When Platform Differences Emerge

**Example: Windows requires different port because of firewall**

```markdown
## Development Server Ports

**macOS/Linux:**
- Frontend: http://localhost:3000
- Backend: http://localhost:4000

**Windows:**
- Frontend: http://localhost:3000
- Backend: http://localhost:5000 (4000 blocked by firewall on Windows)

## Environment Gotchas

### Windows Port Conflicts
Windows Defender often blocks port 4000. Use 5000 for backend instead.
Update `.env.local`:
```
BACKEND_PORT=5000
```
```

**This is valuable documentation that helps everyone understand the quirks!**

---

## 🎨 Maintenance Rules

### Update Triggers

**Everyone should update when:**
- ✅ New platform joins the team
- ✅ Discovering platform-specific gotcha
- ✅ Commands change
- ✅ New environment variables added
- ✅ Tech stack updated

**Who updates:**
- Person who discovered the issue/change
- Person who made the code change that affects environment
- Onboarding person for their platform

### Review Process

**Recommended:**
1. Updates to `.cursor/project-environment.mdc` should be in PRs (not direct commits)
2. At least one person from a DIFFERENT platform should review
3. Ensures cross-platform documentation stays accurate

**Example PR review:**
```
Title: Add PowerShell commands for new build script

Changes:
- Added PowerShell version of build:prod command
- Documented Windows-specific path gotcha

Reviewers: @mac-user @linux-user
```

---

## 🐛 Avoiding Common Pitfalls

### Pitfall 1: Platform-Specific Paths

**❌ Bad:**
```markdown
Project root: C:\Users\dave\Projects\myapp
```

**✅ Good:**
```markdown
## Directory Structure

Monorepo layout:
```
myapp/
├── frontend/
├── backend/
└── shared/
```

**Absolute paths vary by developer.**
- Windows: `C:\Users\<name>\Projects\myapp`
- macOS: `/Users/<name>/Projects/myapp`
- Linux: `/home/<name>/Projects/myapp`
```

### Pitfall 2: Overwriting Instead of Adding

**❌ Bad workflow:**
```bash
# Windows developer updates doc with ONLY Windows commands
# Removes all the Mac commands
git commit -m "Update commands for Windows"
```

**✅ Good workflow:**
```bash
# Windows developer ADDS Windows commands alongside Mac
# Both platforms documented side-by-side
git commit -m "Add Windows PowerShell commands alongside existing Bash"
```

### Pitfall 3: Assuming Same Shell Behavior

**Document the differences!**

```markdown
## Environment Gotchas

### Command Chaining Behavior

**PowerShell:**
- `;` (semicolon) runs all commands regardless of errors
- Example: `npm install; npm test` ← test runs even if install fails

**Bash/Zsh:**
- `&&` only continues if previous command succeeds
- `;` runs all commands (same as PowerShell)
- Example: `npm install && npm test` ← test only runs if install succeeds

**Recommendation:** Use error handling in both:
- PowerShell: `npm install && npm test` (PowerShell 7+ supports &&)
- Bash/Zsh: `npm install && npm test`
```

---

## 🎯 AI Assistant Benefits

### How Cursor Uses Multi-Platform Docs

When you document all platforms, Cursor becomes **smarter for everyone**:

**Windows developer asks:**
> "Run the tests"

**Cursor knows:**
```powershell
npm test
```

**Mac developer asks:**
> "Run the tests"

**Cursor knows:**
```bash
npm test
```

**Windows developer asks:**
> "Set NODE_ENV to production and run build"

**Cursor knows:**
```powershell
$env:NODE_ENV = "production"; npm run build
```

**Mac developer asks the same:**

**Cursor knows:**
```bash
export NODE_ENV=production && npm run build
```

**The AI reads the entire document and adapts to YOUR platform automatically.**

---

## 📋 Quick Reference: What Goes Where

### `.cursor/project-environment.mdc` (SHARED - All Platforms)
✅ Commands for ALL platforms
✅ Environment variables for ALL platforms
✅ Gotchas for ALL platforms
✅ Tech stack (same for everyone)
✅ Directory structure (logical, not absolute paths)

### `.cursor/check-env-docs.sh` (macOS/Linux ONLY)
✅ Staleness checker for Unix
✅ Not used by Windows team members

### `.cursor/check-env-docs.ps1` (Windows ONLY)
✅ Staleness checker for Windows
✅ Not used by Mac/Linux team members

### `.cursor/rules/*.mdc` (SHARED - Platform Agnostic)
✅ AI behavior rules
✅ Same for everyone
✅ Rarely needs platform-specific content

---

## 🚀 Real-World Example

### Scenario: 3-Person Team

**Team:**
- Alice: MacBook Pro, Zsh
- Bob: Windows 11, PowerShell 7
- Carol: Ubuntu 22.04, Bash

### Their `.cursor/project-environment.mdc`:

```markdown
# Project Environment Documentation

> **Last Updated:** 2025-10-04
> **Review Frequency:** Check every 7 days
> **Next Review:** 2025-10-11

## Team Setup

- **Alice (macOS):** Zsh, Node 20, Docker Desktop
- **Bob (Windows):** PowerShell 7, Node 20, Docker Desktop
- **Carol (Linux):** Bash, Node 20, native Docker

## Common Commands

### Install Dependencies

**All Platforms:**
```bash
npm install
```

### Start Development Server

**All Platforms:**
```bash
npm run dev
```

**Note:** Frontend starts on :3000, backend on :4000

### Run Tests

**PowerShell (Bob):**
```powershell
npm test; npm run lint
```

**Bash/Zsh (Alice, Carol):**
```bash
npm test && npm run lint
```

### Environment Variables

**PowerShell (Bob):**
```powershell
$env:NODE_ENV = "development"
$env:DATABASE_URL = "postgresql://localhost/mydb"
$env:API_KEY = "get-from-1password"
```

**Bash/Zsh (Alice, Carol):**
```bash
export NODE_ENV=development
export DATABASE_URL=postgresql://localhost/mydb
export API_KEY=get-from-1password
```

## Environment Gotchas

### Docker on Linux (Carol)
No Docker Desktop - uses native Docker. Commands are the same, but Carol doesn't need to start Docker Desktop app.

### Windows Firewall (Bob)
Port 4000 sometimes blocked. If backend won't start:
```powershell
# Check if port is blocked
Test-NetConnection -ComputerName localhost -Port 4000

# Use port 5000 instead in .env.local
# BACKEND_PORT=5000
```

### macOS Monterey (Alice)
AirPlay Receiver uses port 5000 by default. If conflicts, disable:
System Preferences → Sharing → Uncheck AirPlay Receiver

## Tech Stack

- **Frontend:** React 18, Vite
- **Backend:** Node.js 20, Express
- **Database:** PostgreSQL 14
- **Container:** Docker + docker-compose

## Development Workflow

1. **All:** `npm install`
2. **All:** `docker-compose up -d` (start database)
3. **All:** `npm run dev` (starts both frontend & backend)
4. **All:** Visit http://localhost:3000

## Maintenance Log

- **2025-10-04:** Added Carol's Linux-specific notes
- **2025-10-01:** Added Bob's Windows firewall gotcha
- **2025-09-28:** Initial setup (Alice)
```

**This works perfectly for all three team members!** ✅

---

## 💡 Pro Tips

### Tip 1: Use Comments for Platform Detection

```markdown
## Build Commands

### Production Build

**PowerShell:**
```powershell
# Set env and build (Windows)
$env:NODE_ENV="production"; npm run build
```

**Bash/Zsh:**
```bash
# Set env and build (macOS/Linux)
export NODE_ENV=production && npm run build
```
```

### Tip 2: Document Team Conventions

```markdown
## Team Conventions

**Platform Markers:**
- When adding commands, ALWAYS label with platform
- Use "All Platforms" if truly universal
- If adding platform-specific workaround, explain WHY

**Review Process:**
- PR reviews for .cursor/ changes
- At least one cross-platform reviewer
- Test commands before committing
```

### Tip 3: Use Maintenance Log for Big Changes

```markdown
## Maintenance Log

- **2025-10-04:** Migrated from Node 18 → 20 (all platforms tested)
- **2025-10-01:** Added PowerShell 7 requirement for Windows team
- **2025-09-28:** Initial setup
```

---

## 🎓 Summary

**Key Principles:**
1. 📚 **One Document, All Platforms** - Don't split by platform
2. ➕ **Add, Don't Replace** - New platform commands live alongside existing ones
3. 🏷️ **Label Everything** - Make platform requirements explicit
4. 💬 **Document Gotchas** - Platform differences help everyone
5. 👥 **Review Cross-Platform** - Different platform reviews catch issues

**Benefits:**
- ✅ No constant overwrites
- ✅ Everyone's environment documented
- ✅ AI works better for everyone
- ✅ New team members onboard faster
- ✅ Platform issues visible to all

**This transforms platform differences from a problem into valuable shared knowledge!** 🚀
