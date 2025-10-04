# Cursor Environment Docs 📚

> Auto-updating environment documentation that keeps AI assistants smart about your project.

Stop wasting time explaining your environment setup to AI assistants in every conversation. This system automatically maintains fresh documentation about your development environment, ensuring AI tools always have the context they need.

## ✨ Features

- 🤖 **Auto-updating**: AI checks and updates documentation every 7 days
- 📝 **Self-documenting**: Captures gotchas and mistakes automatically
- 🔄 **Cross-session**: Works across all AI conversations (Cursor, Claude, GitHub Copilot, ChatGPT)
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
   Create .cursor/project-environment.md following the template in .cursor/quick-prompt.txt
   ```
3. Commit the files:
   ```bash
   git add .cursor/
   git commit -m "feat: Add environment documentation system"
   ```

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

### Automatic Updates

1. **At Session Start**: AI checks the "Last Updated" date
2. **If >7 days old**: AI offers to review and update
3. **If >14 days old**: AI strongly recommends update
4. **During Work**: AI updates when discovering environment changes

### Manual Check

Run anytime to see status:
```bash
# Unix/Mac
./.cursor/check-env-docs.sh

# Windows
.\.cursor\check-env-docs.ps1
```

Output:
- ✅ **CURRENT** - No action needed (< 7 days)
- ⚠️ **WARNING** - Review recommended (7-13 days)
- 🔴 **CRITICAL** - Update immediately (14+ days)

## 📁 File Structure

After installation, your project will have:

```
your-project/
└── .cursor/
    ├── project-environment.md      # Your project's environment docs (AI-generated)
    ├── quick-prompt.txt            # Template for AI to use
    ├── check-env-docs.sh/.ps1      # Staleness checker
    ├── README.md                   # System overview
    └── rules/
        └── environment-maintenance.mdc  # AI behavior rules
```

## 🎓 Examples

See the `/examples` directory for complete implementations:

- [Next.js + TypeScript](./examples/nextjs/)
- [Python + Django](./examples/python-django/)
- [React + Vite](./examples/react/)
- [Node.js + Express](./examples/nodejs/)

## 🛠️ Usage

### Basic Workflow

1. **Setup** (once): Run installer in your project
2. **Generate** (once): Have AI create project-environment.md
3. **Use**: AI automatically reads it in every session
4. **Update**: AI offers to update when stale

### With Different AI Tools

**Cursor:**
- System reads `.cursor/` directory automatically
- AI checks docs at conversation start

**Claude / ChatGPT:**
- Upload `.cursor/project-environment.md` to conversation
- Reference it when asking questions

**GitHub Copilot:**
- Documentation improves code suggestions
- Better context for inline completions

### Customization

Edit `.cursor/project-environment.md` to:
- Change review frequency (default: 7 days)
- Add project-specific sections
- Document unique gotchas
- Add team-specific conventions

## 🤝 Contributing

Contributions welcome! Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

Ways to contribute:
- 📚 Add examples for more frameworks
- 🐛 Report bugs or issues
- 💡 Suggest features
- 📝 Improve documentation
- 🔧 Submit PRs

## 📄 License

MIT License - see [LICENSE](./LICENSE) for details.

## 🙏 Acknowledgments

Born from real frustrations with AI pair programming workflows. Designed to work with:
- [Cursor](https://cursor.sh/)
- [GitHub Copilot](https://github.com/features/copilot)
- [Claude](https://claude.ai/)
- [ChatGPT](https://chat.openai.com/)

## ⭐ Show Your Support

If this tool helps your workflow:
- ⭐ Star this repo
- 🐦 Share on Twitter/X
- 📝 Write a blog post
- 💬 Tell your team

## 📞 Support

- 🐛 [Report bugs](https://github.com/u00dxk2/cursor-kooi-env-docs/issues)
- 💡 [Request features](https://github.com/u00dxk2/cursor-kooi-env-docs/issues)
- 💬 [Discussions](https://github.com/u00dxk2/cursor-kooi-env-docs/discussions)

## 🗺️ Roadmap

- [x] Basic system with auto-updates
- [x] Staleness checker script
- [x] Unix/Windows installers
- [ ] NPM package version
- [ ] VSCode extension
- [ ] GitHub Action for CI integration
- [ ] More framework examples
- [ ] Video tutorials
- [ ] Documentation website

---

**Made with ❤️ for developers tired of repeating themselves to AI assistants**

