# Contributing to Cursor Environment Docs

First off, thank you for considering contributing to this project! 🎉

This tool exists to help developers work more efficiently with AI assistants, and community contributions are what make it better for everyone.

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Community](#community)

---

## 🤝 Code of Conduct

This project follows a simple principle: **Be respectful and professional.**

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

---

## 💡 How Can I Contribute?

### Reporting Bugs

Found a bug? Help us fix it!

**Before submitting a bug report:**
- Check the [existing issues](https://github.com/u00dxk2/cursor-kooi-env-docs/issues) to avoid duplicates
- Try the latest version to see if it's already fixed
- Gather as much detail as possible about the problem

**When submitting a bug report, include:**
- **Clear title**: Descriptive one-liner
- **Environment**: OS, shell (PowerShell/Bash/Zsh), version
- **Steps to reproduce**: Exact commands you ran
- **Expected behavior**: What you expected to happen
- **Actual behavior**: What actually happened
- **Screenshots/logs**: If applicable
- **Additional context**: Anything else that might help

**Example:**
```markdown
## Bug: Check script fails on macOS with BSD date

**Environment:**
- OS: macOS 14.2 (Sonoma)
- Shell: Zsh 5.9

**Steps to reproduce:**
1. Install using `curl -fsSL ... | bash`
2. Run `./.cursor/check-env-docs.sh`

**Expected:** Script shows staleness status
**Actual:** Error: "date: illegal option -- -"

**Cause:** BSD date vs GNU date syntax difference
```

### Suggesting Features

Have an idea for improvement?

**Before suggesting a feature:**
- Check [existing issues](https://github.com/u00dxk2/cursor-kooi-env-docs/issues) for similar suggestions
- Consider if it fits the project's scope (environment documentation for AI assistants)
- Think about how it would work across different platforms

**When suggesting a feature, include:**
- **Use case**: What problem does it solve?
- **Proposed solution**: How should it work?
- **Alternatives**: Other ways you considered
- **Examples**: How other tools handle this
- **Breaking changes**: Would this affect existing users?

### Adding Examples

One of the most valuable contributions! We need examples for various tech stacks.

**Good examples to add:**
- Different programming languages (Ruby, Go, Java, C#, etc.)
- Different frameworks (Ruby on Rails, Spring Boot, ASP.NET, etc.)
- Different project types (mobile apps, CLI tools, libraries, etc.)
- Unique environments (Docker, WSL, remote development, etc.)

**Example structure:**
```
examples/[framework-name]/
├── .cursor/
│   ├── project-environment.md  # Complete, realistic example
│   ├── quick-prompt.txt
│   ├── check-env-docs.sh
│   ├── check-env-docs.ps1
│   ├── README.md
│   └── rules/
│       └── environment-maintenance.mdc
├── src/                        # Minimal working code
├── [config files]              # package.json, requirements.txt, etc.
├── .gitignore
└── README.md                   # Explains the example
```

### Improving Documentation

Documentation improvements are always welcome:
- Fix typos or grammar
- Clarify confusing sections
- Add missing information
- Improve examples
- Add screenshots or GIFs
- Translate documentation (future)

### Writing Code

See [Development Setup](#development-setup) below.

---

## 🚀 Getting Started

### Quick Contribution Workflow

1. **Fork the repository**
   ```bash
   # Click "Fork" on GitHub, then:
   git clone https://github.com/YOUR-USERNAME/cursor-kooi-env-docs.git
   cd cursor-kooi-env-docs
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/bug-description
   ```

3. **Make your changes**
   - Write code
   - Add/update tests
   - Update documentation

4. **Test your changes**
   ```bash
   # Test installers
   ./install.sh    # or install.ps1 on Windows
   
   # Test check scripts
   ./.cursor/check-env-docs.sh
   
   # Manually verify on different platforms if possible
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add support for X"
   # See commit message guidelines below
   ```

6. **Push and create Pull Request**
   ```bash
   git push origin feature/your-feature-name
   # Then open PR on GitHub
   ```

---

## 🛠️ Development Setup

### Prerequisites

- **Git**: For version control
- **Shell access**: PowerShell (Windows) or Bash/Zsh (macOS/Linux)
- **Test environment**: Ability to test on at least one platform

### Local Development

1. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/cursor-kooi-env-docs.git
   cd cursor-kooi-env-docs
   ```

2. **Create a test project:**
   ```bash
   mkdir ../test-project
   cd ../test-project
   git init
   ```

3. **Test your changes:**
   ```bash
   # Test installer by copying files manually or running local install script
   # Then verify all functionality works
   ```

### Testing Checklist

Before submitting a PR, verify:

- [ ] Installer works on your platform
- [ ] Check script runs without errors
- [ ] All file paths are correct
- [ ] Documentation is updated
- [ ] No hardcoded paths (use variables/placeholders)
- [ ] Cross-platform compatibility considered
- [ ] Git workflow works (add, commit, push)
- [ ] Example projects (if added) are complete and work
- [ ] No sensitive information (API keys, personal paths)

---

## 📝 Pull Request Process

### Before Submitting

1. **Update documentation** for any changed functionality
2. **Add examples** if introducing new features
3. **Test thoroughly** on at least one platform
4. **Update CHANGELOG.md** with your changes (under "Unreleased")
5. **Ensure no merge conflicts** with main branch

### PR Title Format

Use conventional commit format:

```
feat: add support for Rust projects
fix: resolve date parsing issue on macOS
docs: improve installation instructions
chore: update dependencies
test: add installer validation tests
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting, no code change
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance tasks

### PR Description Template

```markdown
## Description
Brief description of what this PR does.

## Motivation
Why is this change needed? What problem does it solve?

## Changes
- Change 1
- Change 2
- Change 3

## Testing
How was this tested?
- [ ] Tested on Windows
- [ ] Tested on macOS
- [ ] Tested on Linux

## Screenshots/GIFs (if applicable)
[Add visuals if UI/output changed]

## Checklist
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Tests added/updated
- [ ] No breaking changes (or noted in description)
- [ ] Commit messages follow convention

## Related Issues
Closes #123
Relates to #456
```

### Review Process

1. **Automatic review request**: Our CODEOWNERS file automatically requests review from the maintainer
2. **Maintainer reviews** your PR (usually within 3-7 days)
3. **Automated tests run**: CI tests verify your changes work correctly
4. **Address feedback** if requested
5. **Approval**: Maintainer approves after tests pass and review is complete
6. **Merge**: Your changes are merged to main
7. **Celebration**: Your contribution is live! 🎉

**Note:** All PRs require:
- ✅ Passing CI tests (installer validation)
- ✅ Maintainer approval
- ✅ No force-pushes or deleted files

---

## 🎨 Style Guidelines

### Shell Scripts (Bash/PowerShell)

**General principles:**
- Use clear, descriptive variable names
- Add comments for complex logic
- Handle errors gracefully
- Provide user-friendly output
- Test on multiple platforms

**Bash example:**
```bash
#!/bin/bash
set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo -e "${RED}Error: File not found${NC}"
    exit 1
fi

echo -e "${GREEN}Success!${NC}"
```

**PowerShell example:**
```powershell
# Use approved verbs
function Test-Installation {
    param($Path)
    
    if (-not (Test-Path $Path)) {
        Write-Host "Error: Path not found" -ForegroundColor Red
        return $false
    }
    
    Write-Host "Success!" -ForegroundColor Green
    return $true
}
```

### Markdown Documentation

- Use clear headings (H1 for title, H2 for sections)
- Include examples for complex concepts
- Use emojis sparingly but effectively (✅, ❌, 🚀, etc.)
- Keep line length reasonable (~120 chars max)
- Use code blocks with language specified
- Add links to related documentation

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): short description

Longer description if needed. Explain WHY, not just WHAT.

Closes #123
```

**Examples:**
```
feat(installer): add support for custom installation directory
fix(check-script): handle missing date command on minimal systems
docs(readme): add troubleshooting section for PowerShell execution policy
```

---

## 🧪 Testing Guidelines

### Manual Testing

**Installer testing:**
```bash
# Test fresh install
cd /tmp/test-project-1
git init
bash /path/to/install.sh

# Test with existing .cursor/
cd /tmp/test-project-2
mkdir .cursor
bash /path/to/install.sh

# Test without git
cd /tmp/test-project-3
bash /path/to/install.sh  # Should warn but allow continuation
```

**Check script testing:**
```bash
# Test current status (< 7 days)
# Manually set date to today in project-environment.md
./.cursor/check-env-docs.sh

# Test warning status (7-13 days)
# Set date to 10 days ago
./.cursor/check-env-docs.sh

# Test critical status (14+ days)
# Set date to 20 days ago
./.cursor/check-env-docs.sh

# Test missing file
rm .cursor/project-environment.md
./.cursor/check-env-docs.sh
```

### Automated Testing (Future)

We're working on automated tests. If you can help with this, it's very welcome!

---

## 🌍 Community

### Get Help

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and ideas
- **README.md**: For documentation

### Stay Updated

- Watch the repository for updates
- Star the project if you find it useful
- Share with others who might benefit

### Spread the Word

Help others discover this tool:
- ⭐ Star the repository
- 🐦 Share on social media
- 📝 Write a blog post about your experience
- 💬 Tell your team/community
- 🎥 Create a video tutorial

---

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the MIT License (same as the project).

---

## ❓ Questions?

Not sure about something? That's okay!

- Open a [GitHub Discussion](https://github.com/u00dxk2/cursor-kooi-env-docs/discussions)
- Open an issue with the `question` label
- Check existing issues and discussions

**No question is too small!** We'd rather you ask than struggle.

---

## 🙏 Thank You!

Every contribution, no matter how small, makes this project better. We appreciate:
- Bug reports that help us improve
- Feature suggestions that expand possibilities
- Code contributions that add functionality
- Documentation improvements that help users
- Examples that show real-world usage
- Community support that helps others

**Thank you for being part of making AI-assisted development better for everyone!** ❤️

---

**Happy Contributing!** 🚀

