# Migration Prompt for v1.0.x → v1.1.0

**Copy and paste this entire prompt into any project using Cursor Environment Docs v1.0.x to migrate to v1.1.0:**

---

I need to migrate this project's Cursor environment documentation from v1.0.x to v1.1.0.

## BACKGROUND:
- v1.0.x used `.cursor/project-environment.md` (plain markdown)
- v1.1.0 uses `.cursor/rules/project-environment.mdc` (with YAML frontmatter and `alwaysApply: true`)
- The new format **guarantees automatic loading** by Cursor at session start (100% reliability vs ~70% in v1.0.x)
- This uses Cursor's official rule system properly

## MIGRATION STEPS:

### 1. READ the current environment documentation
- Read `.cursor/project-environment.md`
- Note all the sections and content we need to preserve

### 2. CREATE the new .mdc file with frontmatter
- Create `.cursor/rules/project-environment.mdc`
- Add this YAML frontmatter at the **very top** of the file:

```yaml
---
title: Project Environment Context
description: Core project environment information - shell, paths, tech stack, and development workflow
alwaysApply: true
---
```

- Below the frontmatter, add the heading and metadata:

```markdown
# Project Environment Documentation

> **Last Updated:** 2025-10-08  
> **Review Frequency:** Check every conversation, update when environment changes  
> **Next Review:** 2025-10-15
```

- Copy **ALL content** from the old `.cursor/project-environment.md` file below this
- Update the "Last Updated" date to **today's date** (format: YYYY-MM-DD)
- In the Maintenance Log table, add a new entry:
  - Date: Today's date (2025-10-08 or current)
  - Change: "Migrated to .mdc format for guaranteed auto-loading"
  - Updated By: "AI Assistant"

### 3. UPDATE the environment-maintenance.mdc file
- Read `.cursor/rules/environment-maintenance.mdc`
- Find all references to `project-environment.md` and change them to `rules/project-environment.mdc`
- Key places to update:
  - The description of what file to maintain
  - Any instructions about reading or updating the file
  - Example paths or file references

### 4. VERIFY the migration
Before proceeding, confirm:
- [ ] `.cursor/rules/project-environment.mdc` exists
- [ ] It has the YAML frontmatter with `alwaysApply: true`
- [ ] It has the markdown heading and metadata section
- [ ] All content from the old file is preserved
- [ ] "Last Updated" date is today
- [ ] Maintenance Log has migration entry
- [ ] `.cursor/rules/environment-maintenance.mdc` references are updated

### 5. DELETE the old file
- Delete `.cursor/project-environment.md` (the old location)
- This file is no longer needed and will cause confusion

### 6. COMMIT the changes
```bash
git add .cursor/
git commit -m "feat: Migrate to v1.1.0 .mdc format with guaranteed auto-loading"
git push
```

### 7. REPORT what you did
Please show me:
- ✅ Confirmation that `.cursor/rules/project-environment.mdc` was created
- ✅ The first 20 lines of the new `.mdc` file (to verify frontmatter)
- ✅ Confirmation that the old `.cursor/project-environment.md` was deleted
- ✅ List of changes made to `environment-maintenance.mdc`
- ✅ Git commit hash and confirmation of push

---

## WHY THIS MIGRATION?

The v1.1.0 format:
- ✅ **Guarantees automatic loading** - uses Cursor's `alwaysApply: true` flag
- ✅ **100% reliability** - no dependency on agent behavior
- ✅ **Proper integration** - uses Cursor's official `.mdc` rule system
- ✅ **Context from first message** - loaded at session start, not manually read

The v1.0.x format was fragile because:
- ❌ Plain `.md` files aren't auto-loaded by Cursor
- ❌ Depended on agents following maintenance rule instructions
- ❌ Required manual `read_file` tool usage
- ❌ Could be skipped if agent didn't prioritize it

---

**Please proceed with the migration now.**

