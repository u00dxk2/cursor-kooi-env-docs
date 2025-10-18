# Changelog

All notable changes to the Cursor Environment Docs project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

_No unreleased changes yet._

---

## [1.1.1] - 2025-10-18

### 🐛 Bug Fixes
- **Fixed quick-prompt workflow**: Prevented `.cursor/extensions/` from being staged during setup
  - Quick-prompt instructions now provide **specific file list** instead of "commit ALL .cursor/ files"
  - Added `.gitignore` entries to exclude IDE-managed files (extensions, ide_state.json, workspace_state.db)
  - Updated template/README.md with clear "Version Control Guidelines" (✅ commit / ❌ don't commit)
  
### 📚 Documentation
- **Added comprehensive analysis**: `docs/QUICK-PROMPT-IMPROVEMENT-ANALYSIS.md` (347 lines)
  - Root cause analysis of extension staging issue
  - Detailed testing plan for future validation
  - Priority-based implementation roadmap
- **Added implementation summary**: `docs/IMPLEMENTATION-SUMMARY-QUICK-PROMPT-FIX.md`

### Impact
- Users will no longer accidentally stage 600+ IDE extension files
- Clean git workflow with no confusing line ending warnings
- Clear documentation prevents future issues

### Files Changed
```
.gitignore                                |   5 +
docs/QUICK-PROMPT-IMPROVEMENT-ANALYSIS.md | 347 +++++++++++++++
template/.gitignore                       |  23 ++
template/README.md                        |  31 ++-
template/quick-prompt.txt                 |  18 +-
```

**⚡ Immediately available**: This fix is available on `main` branch - installer pulls latest template files automatically.

---

## [1.1.0] - 2025-10-08

### 🚨 Breaking Changes
- **File structure change**: Environment documentation moved from `.cursor/project-environment.md` to `.cursor/rules/project-environment.mdc`
- **New format required**: Files now use `.mdc` extension with YAML frontmatter instead of plain markdown
- **Users on v1.0.x must migrate**: See migration guide in `docs/MDC-FORMAT-MIGRATION.md`

### 🎯 Major Improvements
- **Guaranteed auto-loading** ([research-driven](./docs/AGENT-CONTEXT-RESEARCH-RESPONSE.md)): Environment docs now use Cursor's `.mdc` rule format with `alwaysApply: true` frontmatter, ensuring **100% reliable** automatic loading at session start
  - **Before (v1.0.x)**: Plain `.md` file that agents had to manually read (fragile, ~70% reliability)
  - **After (v1.1.0)**: Proper `.mdc` rule file with automatic ingestion (robust, ~100% reliability)
- **Zero agent dependency**: No longer relies on agents following instructions to read files
- **Immediate context availability**: Environment information available from first message in every session

### Added
- **New file format**: `.cursor/rules/project-environment.mdc` with YAML frontmatter
- **Comprehensive migration guide**: `docs/MDC-FORMAT-MIGRATION.md` (377 lines) explaining the change
- **Research validation**: `docs/AGENT-CONTEXT-RESEARCH-RESPONSE.md` (437 lines) documenting research findings
- **Migration verification**: `docs/MIGRATION-VERIFICATION.md` (252 lines) with complete checklist
- **Frontmatter support**: All rule files now use proper YAML frontmatter with `alwaysApply: true`

### Changed
- **File location**: Moved from `.cursor/project-environment.md` to `.cursor/rules/project-environment.mdc`
- **File format**: Added YAML frontmatter to all environment documentation files
- **Template structure**: Updated template directory to use new `.mdc` format
- **Example projects**: Both Node.js and Python examples migrated to new format
- **All documentation**: Updated README, FAQ, troubleshooting guides to reference new structure
- **Installer messaging**: Updated to reflect new `.mdc` file format

### Fixed
- **Unreliable context loading**: Environment docs are now **guaranteed** to load automatically
- **Agent-dependent behavior**: Removed dependency on agents reading files manually
- **Session start context**: Environment information now available from conversation start

### Technical Details
- Uses Cursor's official `.mdc` rule system
- Leverages `alwaysApply: true` flag for guaranteed loading
- Files in `.cursor/rules/` are automatically discovered and loaded
- No manual `read_file` tool usage required
- Proper YAML frontmatter format with title, description, and alwaysApply fields

### Migration Path
Users upgrading from v1.0.x should:
1. Review migration guide: `docs/MDC-FORMAT-MIGRATION.md`
2. Create new `.cursor/rules/project-environment.mdc` with frontmatter
3. Copy content from old `.cursor/project-environment.md`
4. Update references in `.cursor/rules/environment-maintenance.mdc`
5. Delete old `.cursor/project-environment.md` file
6. Reindex Cursor (Command Palette → "Reindex Codebase")
7. Verify automatic loading in new session

### Documentation
- 📚 [Migration Guide](./docs/MDC-FORMAT-MIGRATION.md) - How to upgrade from v1.0.x
- 🔬 [Research Response](./docs/AGENT-CONTEXT-RESEARCH-RESPONSE.md) - Why this change was necessary
- ✅ [Verification Report](./docs/MIGRATION-VERIFICATION.md) - Migration checklist and validation

---

## [1.0.1] - 2025-10-05

### Fixed
- **Installer messaging clarity** ([#2](https://github.com/u00dxk2/cursor-kooi-env-docs/pull/2)): Changed "Installation complete!" to "Template files installed successfully!" to prevent users from thinking they're done when they still need to create `project-environment.md`
- **Git commit guidance**: Added explicit warnings in installers, quick-prompt.txt, and template README to prevent confusion about committing the `.cursor/` directory
  - Fixed ambiguous wording that led AI agents to suggest gitignoring `.cursor/` or treating it as partially tracked
  - Now explicitly states: "Commit the ENTIRE .cursor/ directory to Git. Do NOT add it to .gitignore."

### Changed
- Installer success message is now more accurate about completion status
- Git commit instructions emphasize committing ALL `.cursor/` files, not just `project-environment.md`

---

## [1.0.0] - 2025-10-04

### Added
- Initial release of Cursor Environment Docs system
- One-line installers for Windows (PowerShell) and Unix/Linux (Bash)
- Template files for environment documentation
- `project-environment.md` template for AI assistants
- `quick-prompt.txt` for rapid documentation generation
- `check-env-docs` scripts (PowerShell and Bash) for staleness checking
- `environment-maintenance.mdc` rule file for AI assistant behavior
- Automatic documentation update system (7-day review cycle)
- Cross-platform support (Windows, macOS, Linux)
- Git integration for version-controlled documentation
- MIT License
- Comprehensive README with usage instructions
- Setup guides (QUICK-SETUP.md, SETUP-GUIDE.md)

### Features
- 🤖 Auto-updating environment docs (checks every conversation, updates in real-time)
- 📝 Self-documenting system that captures gotchas
- 🔄 Cross-session consistency across Cursor conversations
- ⚡ 5-minute setup process
- 🔍 Staleness checker scripts
- 🎯 Framework-agnostic design
- 💾 Git-friendly version control

### Documentation
- Complete README.md with features, installation, and usage
- Quick setup cheat sheet
- Detailed setup guide
- Template system for new projects

---

## Release Notes

### [1.0.0] - Initial Public Release

This is the first public release of Cursor Environment Docs, a system designed to maintain fresh, accurate environment documentation for AI coding assistants.

**Key Highlights:**
- Solves the problem of repeatedly explaining environment setup to Cursor
- Designed specifically for Cursor with automatic directory reading and rule application
- Automatic staleness checking and update prompts
- Simple one-line installation
- Cross-platform compatibility (Windows, macOS, Linux)

**Quick Start:**
```bash
# macOS/Linux
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh | bash

# Windows PowerShell
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.ps1 | iex
```

**What's Next:**
- Additional example projects for various frameworks
- Automated testing and CI/CD
- Enhanced error handling
- Configuration file support
- NPM package version
- VSCode extension

---

## Version History

- **1.1.0** (2025-10-08) - Major reliability improvement (.mdc format migration)
- **1.0.1** (2025-10-05) - Bug fix release (installer messaging, git guidance)
- **1.0.0** (2025-10-04) - Initial public release
- **Unreleased** - Current development version

---

## How to Contribute

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

---

## Links

- **Repository**: https://github.com/u00dxk2/cursor-kooi-env-docs
- **Issues**: https://github.com/u00dxk2/cursor-kooi-env-docs/issues
- **Discussions**: https://github.com/u00dxk2/cursor-kooi-env-docs/discussions

---

[Unreleased]: https://github.com/u00dxk2/cursor-kooi-env-docs/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/u00dxk2/cursor-kooi-env-docs/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/u00dxk2/cursor-kooi-env-docs/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/u00dxk2/cursor-kooi-env-docs/releases/tag/v1.0.0

