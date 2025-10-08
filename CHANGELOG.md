# Changelog

All notable changes to the Cursor Environment Docs project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

_No unreleased changes yet._

---

## [1.0.1] - 2025-10-05

### Fixed
- **Installer messaging clarity** ([#2](https://github.com/u00dxk2/cursor-kooi-env-docs/pull/2)): Changed "Installation complete!" to "Template files installed successfully!" to prevent users from thinking they're done when they still need to create `project-environment.mdc`
- **Git commit guidance**: Added explicit warnings in installers, quick-prompt.txt, and template README to prevent confusion about committing the `.cursor/` directory
  - Fixed ambiguous wording that led AI agents to suggest gitignoring `.cursor/` or treating it as partially tracked
  - Now explicitly states: "Commit the ENTIRE .cursor/ directory to Git. Do NOT add it to .gitignore."

### Changed
- Installer success message is now more accurate about completion status
- Git commit instructions emphasize committing ALL `.cursor/` files, not just `project-environment.mdc`

---

## [1.0.0] - 2025-10-04

### Added
- Initial release of Cursor Environment Docs system
- One-line installers for Windows (PowerShell) and Unix/Linux (Bash)
- Template files for environment documentation
- `project-environment.mdc` template for AI assistants
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

[Unreleased]: https://github.com/u00dxk2/cursor-kooi-env-docs/compare/v1.0.1...HEAD
[1.0.1]: https://github.com/u00dxk2/cursor-kooi-env-docs/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/u00dxk2/cursor-kooi-env-docs/releases/tag/v1.0.0

