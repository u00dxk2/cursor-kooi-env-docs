# Installer Safety Plan - Preventing Data Loss

## Problem Identified (2025-10-04)

**Critical:** Current installers can silently overwrite existing `.cursor/` files without user consent or backup.

## Proposed Solution

### Option 1: Skip Existing Files (Safest - RECOMMENDED)

**Behavior:**
- Detect all files that would be overwritten
- Show user what exists vs. what would be installed
- Skip existing files by default
- Only install missing files
- Show summary of what was skipped

**Example Output:**
```
🔍 Checking for existing files...

Found existing .cursor/ setup:
  ⚠️  .cursor/README.md (exists - will skip)
  ⚠️  .cursor/rules/environment-maintenance.mdc (exists - will skip)
  ✅  .cursor/quick-prompt.txt (missing - will install)
  ✅  .cursor/check-env-docs.sh (missing - will install)

📦 Installation plan:
  - Install: 3 new files
  - Skip: 2 existing files
  - Preserve: All existing content

Continue? (y/n)
```

### Option 2: Backup Then Overwrite

**Behavior:**
- Create `.cursor.backup-TIMESTAMP/` directory
- Copy existing files there
- Then install new files
- Show user where backup is

**Example Output:**
```
⚠️  Existing .cursor/ setup detected
📁 Creating backup: .cursor.backup-20251004-143022/
✅ Backup created
📥 Installing new files...
```

### Option 3: Interactive Mode (Most Flexible)

**Behavior:**
- Check each file
- Ask user what to do for each conflict
- Options: Skip, Overwrite, Backup, View Diff

**Example Output:**
```
File exists: .cursor/README.md
  [S]kip  [O]verwrite  [B]ackup  [V]iew  [Q]uit
Your choice:
```

## Recommended Implementation

### Phase 1: Quick Fix (Pre-Launch)

**Implement Option 1 (Skip Existing)** - Safest and simplest:

```bash
# Pseudo-code
check_existing_file() {
    if [ -f "$file" ]; then
        echo "⚠️  $file exists - skipping (use --force to overwrite)"
        skipped_files+=("$file")
        return 1
    fi
    return 0
}

# Only download if file doesn't exist
if check_existing_file ".cursor/README.md"; then
    download_file "$url" ".cursor/README.md"
fi
```

**Add --force flag** for clean installs:
```bash
bash install.sh --force  # Overwrites everything
```

### Phase 2: Future Enhancement (v1.1.0)

Add `--update` mode that:
- Intelligently updates system files
- Never touches user-created files (project-environment.mdc)
- Shows changelog of what's new
- Offers to merge changes

## Files That Need Protection

### USER FILES (never overwrite):
- ❌ `.cursor/project-environment.mdc` - User's documentation
- ❌ Any files not in our template

### SYSTEM FILES (ask before overwriting):
- ⚠️ `.cursor/README.md` - Could be customized
- ⚠️ `.cursor/rules/environment-maintenance.mdc` - Could be customized
- ⚠️ `.cursor/check-env-docs.sh/.ps1` - Could be modified
- ⚠️ `.cursor/quick-prompt.txt` - Could be customized
- ⚠️ `.cursor/validate-install.sh/.ps1` - Could be modified

## Testing Plan

Test scenarios:
1. ✅ Fresh install (no `.cursor/` directory)
2. ✅ Existing `.cursor/` with our files (update scenario)
3. ✅ Existing `.cursor/` with custom files (don't destroy)
4. ✅ Mixed scenario (some our files, some custom)
5. ✅ Empty `.cursor/` directory

## Implementation Priority

**BEFORE LAUNCH:**
- [ ] Implement skip-existing-files logic
- [ ] Add `--force` flag
- [ ] Test all scenarios
- [ ] Update documentation

**POST LAUNCH (v1.1.0):**
- [ ] Add backup option
- [ ] Add interactive mode
- [ ] Add `--update` command
- [ ] Smart file detection (ours vs. theirs)
