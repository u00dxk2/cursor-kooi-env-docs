# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**cursor-kooi-env-docs** is a zero-dependency, cross-platform system that installs auto-updating environment documentation into Cursor AI projects. It consists of shell-based installers (`install.ps1`, `install.sh`), template files deployed to user projects, and Cursor `.mdc` rule files that enable automatic context loading.

There is no build step, no package manager, and no runtime. The entire project is Markdown, PowerShell, and Bash scripts.

## Repository Layout (Three `.cursor/` Contexts)

There are three distinct `.cursor/` directory contexts -- do not confuse them:

1. **Root `.cursor/`** -- Dogfooding setup for this repository itself
2. **`template/`** -- Source files that the installers download and deploy to user projects. Edits here affect all new installations.
3. **`examples/*/`** -- Complete working example projects (nodejs-express, python-flask) with their own `.cursor/` directories

When editing template content, always edit in `template/`. The root `.cursor/` is the project's own usage of the system.

## Testing

There are no unit tests or a test runner. Testing is manual + CI.

**CI (GitHub Actions):** `.github/workflows/test-installer.yml` runs on push/PR to `main`:
- Bash installer tests on ubuntu-latest and macos-latest
- PowerShell installer tests on windows-latest
- Line ending validation (LF for `.sh`, CRLF for `.ps1` via `.gitattributes`)

**Manual installer testing:**
```powershell
# Windows - test locally
.\install.ps1
.\install.ps1 --force

# Windows - test from GitHub (preferred, ensures correct line endings)
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.ps1 | iex
```
```bash
# Unix/Mac - test from GitHub
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh | bash
```

**Validation scripts** (run inside a project that has the system installed):
```bash
./.cursor/validate-install.sh    # Unix
.\.cursor\validate-install.ps1   # Windows
./.cursor/check-env-docs.sh      # Staleness check (Unix)
.\.cursor\check-env-docs.ps1     # Staleness check (Windows)
```

## Critical Constraints

### Line Endings

`.gitattributes` enforces `*.ps1` as CRLF and `*.sh` as LF. This is load-bearing -- PowerShell scripts with LF line endings produce parse errors. Never disable or weaken `.gitattributes` rules.

### PowerShell 5.1 Compatibility

All shipped `.ps1` files must work in Windows PowerShell 5.1+. This means:
- **No non-ASCII characters** (no emoji, no Unicode checkmarks) in any `.ps1` file under `template/` or at root. PS5.1 can misinterpret UTF-8 without BOM, corrupting characters and breaking the parser.
- **No `&&` operator** -- use `;` or separate statements instead (`&&` requires PS7+).
- Use `Write-Host` with `-ForegroundColor` for colored output (e.g., `[OK]`, `[ERR]`, `[WARN]` prefixes instead of emoji).

### Branch Protection

Direct pushes to `main` are blocked. All changes require a pull request with passing CI and maintainer (@u00dxk2) approval.

## Conventions

- **Commits:** Conventional Commits format (`feat:`, `fix:`, `docs:`, `chore:`, etc.)
- **PR titles:** Same conventional commit format, under 70 characters
- **Dual-platform scripts:** Every script exists in both `.ps1` and `.sh` variants. Changes to logic in one must be mirrored in the other.
- **Installer behavior:** Preserves existing files by default; `--force` flag overwrites. Installers must not require git, admin privileges, or interactive prompts.

## How the System Works (Architecture)

1. User runs the one-line installer (`curl | bash` or `irm | iex`)
2. Installer creates `.cursor/rules/` and downloads template files from GitHub raw URLs (`template/` directory is the source)
3. User asks Cursor to generate `.cursor/rules/project-environment.mdc` using the prompt in `quick-prompt.txt`
4. The `.mdc` file with `alwaysApply: true` frontmatter is automatically loaded by Cursor at every session start
5. `environment-maintenance.mdc` instructs the AI to check staleness (7-day warning, 14-day critical) and update the docs in real-time when environment changes are discovered
