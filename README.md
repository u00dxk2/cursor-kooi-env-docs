# Cursor Environment Docs 📚

> Auto-updating environment documentation that keeps Cursor smart about your project.

Stop wasting time explaining your environment setup to Cursor in every conversation. This system automatically maintains fresh documentation about your development environment, ensuring Cursor always has the context it needs.

## ✨ Features

- 🤖 **Auto-updating**: AI checks every conversation, updates in real-time as you develop
- 📝 **Self-documenting**: Captures gotchas and mistakes automatically
- 🔄 **Cross-session**: Works across all Cursor conversations
- ⚡ **5-minute setup**: One command to install, minimal configuration
- 🔍 **Staleness checker**: Know when your docs need attention
- 🎯 **Framework agnostic**: Works with any tech stack
- 💾 **Git-friendly**: Version-controlled documentation

## 🚀 Quick Start

### One-Line Install

**macOS/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.ps1 | iex
```

> **Compatibility Note:** Works in **Windows PowerShell 5.1+** and **PowerShell 7+**.

> **Security Note:** The installer downloads and runs scripts from GitHub. You can review the installer scripts before running: [Windows installer](https://github.com/u00dxk2/cursor-kooi-env-docs/blob/main/install.ps1), [Unix/macOS installer](https://github.com/u00dxk2/cursor-kooi-env-docs/blob/main/install.sh). It only creates a `.cursor/` directory in your current project—no system-level changes, no admin/root privileges required.

> **⚠️ Existing .cursor/ Setup:** The installer **preserves existing files** by default. If you have an existing `.cursor/` directory, only missing files will be added. To overwrite everything (clean reinstall), download the installer and run with `--force` flag:
> ```bash
> # Unix/Mac
> curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh -o install.sh
> bash install.sh --force
> 
> # Windows
> irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.ps1 -OutFile install.ps1
> .\install.ps1 --force
> ```

### What It Does

1. Creates `.cursor/` directory in your project
2. Installs template files and AI rules
3. Sets up automatic documentation maintenance
4. Provides a staleness checker script

### Next Steps

After installation:

1. Open your project with an AI assistant
2. Ask it to create the environment documentation:
   ```
   Create .cursor/rules/project-environment.mdc following the template in .cursor/quick-prompt.txt
   ```
3. Commit the files:
   ```bash
   git add .cursor/
   git commit -m "feat: Add environment documentation system"
   git push
   ```

   If your folder is **not a git repo** (or you don't have git installed), you can skip this step. Git is recommended for team sharing/versioning, but not required for local use.

**Important:** Commit the entire `.cursor/` directory! This is shared project documentation, not personal IDE settings. Your team needs these files.

**Done!** 🎉 Your AI assistants will now have consistent, up-to-date context about your project.

## 🎯 Why You Need This

### The Problem

Working with AI assistants, you often encounter:
- ❌ Wasting time explaining the same environment details repeatedly
- ❌ AI suggesting commands that don't work in your shell (PowerShell vs Bash)
- ❌ Hitting the same environment gotchas across multiple sessions
- ❌ Inconsistent behavior between different AI conversations
- ❌ Documentation that gets stale and out of sync

### The Solution

This system:
- ✅ Documents your environment once, benefits forever
- ✅ AI automatically reads it at session start
- ✅ Self-updates when environment changes
- ✅ Captures mistakes so you never repeat them
- ✅ Works with any AI coding assistant
- ✅ Stays fresh with automatic staleness checking

## 📊 What Gets Documented

The system captures:

- **Directory Structure**: Absolute paths, workspace layout
- **Shell Environment**: PowerShell vs Bash syntax differences
- **Common Commands**: Git workflow, package managers, build/test commands
- **Tech Stack**: Framework versions, dependencies, external services
- **Environment Gotchas**: Mistakes to avoid, path issues, quirks
- **Development Workflow**: How to start dev server, run tests, deploy

## 🔄 How It Stays Current

### Automatic Updates (The Smart Way)

**Every new Cursor conversation:**
1. ✅ AI automatically loads `.cursor/rules/project-environment.mdc` (Passive Context)
2. ✅ AI loads `.cursor/rules/environment-maintenance.mdc` (Active Rule)
3. ✅ The Rule checks the Context's "Last Updated" date
4. ✅ Offers to review and update if stale

**During development:**
- ✅ AI updates **in real-time** when discovering changes:
  - New dependencies installed
  - Command syntax issues found
  - Environment gotchas discovered
  - Tech stack changes

**Staleness thresholds** (safety net for busy projects):
- **< 7 days**: Current, no action needed
- **7-14 days**: Review recommended
- **14+ days**: Update strongly recommended

### Manual Check

Want to check staleness yourself? Run anytime:
```bash
# Unix/Mac
./.cursor/check-env-docs.sh

# Windows
.\.cursor\check-env-docs.ps1
```

## 📁 File Structure

After installation, your project will have:

```
your-project/
└── .cursor/
    ├── quick-prompt.txt            # Template for AI to use
    ├── check-env-docs.sh/.ps1      # Staleness checker
    ├── validate-install.sh/.ps1    # Installation validator
    ├── README.md                   # System overview
    └── rules/
        ├── project-environment.mdc      # Your project's environment docs (AI-generated)
        └── environment-maintenance.mdc  # AI behavior rules
```

## 🤝 Team Collaboration

**Multi-platform teams?** No problem! The `.cursor/rules/project-environment.mdc` file should document ALL team members' platforms:

```markdown
## Shell Environment

**Team Setup:**
- Windows developers: PowerShell 7+
- macOS developers: Zsh (default)
- Linux developers: Bash

## Common Commands

### Start Dev Server

**PowerShell:**
```powershell
npm run dev
```

**Bash/Zsh:**
```bash
npm run dev
```
```

**Key principles:**
- 📚 **One document, all platforms** - Don't overwrite, add alongside
- 🏷️ **Label everything** - Make platform requirements explicit  
- ➕ **Add, don't replace** - Each platform's commands coexist
- 💬 **Document gotchas** - Platform differences help everyone

See [docs/TEAM-COLLABORATION.md](./docs/TEAM-COLLABORATION.md) for complete guide.

## 🎓 Examples

See the `/examples` directory for complete implementations:

- [Node.js + Express](./examples/nodejs-express/) ✅ - Complete working example
- [Python + Flask](./examples/python-flask/) ✅ - Complete working example
- More coming soon! (Contributions welcome)

## 🛠️ Usage

### Basic Workflow

1. **Setup** (once): Run installer in your project
2. **Generate** (once): Have AI create project-environment.mdc
3. **Use**: AI automatically loads it at every session start
4. **Update**: AI offers to update when stale

### How Cursor Uses It

**Automatic Integration:**
- Cursor automatically reads `.cursor/` directory at session start
- AI checks "Last Updated" date and offers to update if stale
- Maintenance rules are automatically applied
- No manual work required - it just works!

**Using with Other AI Tools:**
While designed for Cursor, you can manually share the `project-environment.mdc` file with other AI assistants (Claude, ChatGPT, etc.), but automatic date checking and maintenance won't work.

### Validation

Verify your installation is correct:

```bash
# Unix/Mac
./.cursor/validate-install.sh

# Windows
.\.cursor\validate-install.ps1
```

This checks:
- All required files exist
- Documentation format is correct
- Git integration is working
- Scripts are executable

### Customization

Edit `.cursor/rules/project-environment.mdc` to:
- Change review frequency (default: 7 days)
- Add project-specific sections
- Document unique gotchas
- Add team-specific conventions

See the [FAQ](./docs/FAQ.md) for common customization questions.

## 🤝 Contributing

Contributions welcome! Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

**Security:** This project uses branch protection, automated testing, and CODEOWNERS for secure collaboration. All contributions require PR review and passing CI tests.

Ways to contribute:
- 📚 Add examples for more frameworks
- 🐛 Report bugs or issues
- 💡 Suggest features
- 📝 Improve documentation
- 🔧 Submit PRs

## 📄 License

MIT License - see [LICENSE](./LICENSE) for details.

## 🙏 Acknowledgments

Born from real frustrations with AI pair programming workflows in [Cursor](https://cursor.sh/).

**Note:** This tool is specifically designed for Cursor, which automatically reads the `.cursor/` directory and applies maintenance rules. While you can manually share the documentation with other AI assistants, the automatic update system is Cursor-specific.

## ⭐ Show Your Support

If this tool helps your workflow:
- ⭐ Star this repo
- 🐦 Share on Twitter/X
- 📝 Write a blog post
- 💬 Tell your team

## 📞 Support & Documentation

### 📚 Documentation
- **[FAQ](./docs/FAQ.md)** - Frequently asked questions
- **[Troubleshooting Guide](./docs/TROUBLESHOOTING.md)** - Solutions to common problems
- **[Setup Guide](./docs/SETUP-GUIDE.md)** - Detailed installation instructions
- **[Quick Setup](./docs/QUICK-SETUP.md)** - Fast setup cheat sheet
- **[Contributing Guide](./CONTRIBUTING.md)** - How to contribute
- **[Changelog](./CHANGELOG.md)** - Version history

### 💬 Get Help
- 🐛 [Report bugs](https://github.com/u00dxk2/cursor-kooi-env-docs/issues)
- 💡 [Request features](https://github.com/u00dxk2/cursor-kooi-env-docs/issues)
- 💬 [Discussions](https://github.com/u00dxk2/cursor-kooi-env-docs/discussions)
- ❓ [FAQ](./docs/FAQ.md)

## 🗺️ Roadmap

### ✅ Completed (v1.1.0)
- [x] ⭐ Guaranteed auto-loading with `.mdc` format and `alwaysApply: true`
- [x] ⭐ Migrated to Cursor's official rule system
- [x] Basic system with auto-updates
- [x] Staleness checker script
- [x] Unix/Windows installers
- [x] Complete example projects (Node.js, Python)
- [x] Comprehensive documentation (FAQ, Troubleshooting)
- [x] Validation scripts
- [x] Contributing guidelines
- [x] CHANGELOG
- [x] Migration guide for v1.0.x users

### 🔄 In Progress
- [ ] GitHub Actions CI/CD
- [ ] Improved error handling in installers

### 📅 Planned
- [ ] NPM package version
- [ ] More framework examples (Rust, Go, Ruby, Java, etc.)
- [ ] VSCode extension
- [ ] Video tutorials
- [ ] Documentation website
- [ ] Homebrew/Chocolatey packages

---

**Made with ❤️ for developers tired of repeating themselves to AI assistants**

