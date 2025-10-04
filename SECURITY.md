# Security Policy

## 🔒 Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability in this project, please report it responsibly.

### How to Report

**For sensitive security issues:**
1. **Email**: Contact the maintainer via GitHub profile (do not create a public issue)
2. **GitHub Security Advisory**: Use GitHub's "Report a vulnerability" feature (preferred)
   - Go to the [Security tab](https://github.com/u00dxk2/cursor-kooi-env-docs/security)
   - Click "Report a vulnerability"

**For non-sensitive issues:**
- Open a regular [GitHub issue](https://github.com/u00dxk2/cursor-kooi-env-docs/issues) with the `security` label

### What to Include

To help us address the vulnerability quickly, please provide:

- **Description**: Clear explanation of the vulnerability
- **Impact**: What an attacker could accomplish
- **Steps to Reproduce**: Detailed reproduction steps
- **Affected Versions**: Which versions are affected (if known)
- **Suggested Fix**: If you have a solution or mitigation (optional)
- **Proof of Concept**: Code or commands demonstrating the issue (if applicable)

---

## ⏱️ Response Timeline

We aim to:
- **Acknowledge** your report within **48 hours**
- Provide a **detailed response** within **7 days**
- Release a **security patch** as soon as safely possible (usually within 14 days)

For critical vulnerabilities, we'll prioritize an emergency release.

---

## 🛡️ Security Best Practices for Users

### What the Installer Does

The installation scripts (`install.ps1`, `install.sh`):
- ✅ Only create a `.cursor/` directory in your current project
- ✅ Download template files from GitHub
- ✅ **No system-level changes**
- ✅ **No admin/root privileges required**
- ✅ **No network calls** except downloading from GitHub

### Review Before Running

**Always review scripts before executing:**
- [Bash installer source](https://github.com/u00dxk2/cursor-kooi-env-docs/blob/v1.0.0/install.sh)
- [PowerShell installer source](https://github.com/u00dxk2/cursor-kooi-env-docs/blob/v1.0.0/install.ps1)

### Don't Commit Secrets

**⚠️ Important:** The `.cursor/project-environment.md` file may contain:
- Environment variable names
- Command examples
- Directory paths

**Never include:**
- Real API keys or passwords
- Production credentials
- Sensitive URLs or endpoints

**Always add to .gitignore if needed:**
```
.env
.env.local
*.key
*.pem
secrets/
```

### Secure Your Repository

If using this in a private/commercial project:
- ✅ Use GitHub's private repositories
- ✅ Review access permissions regularly
- ✅ Enable branch protection rules
- ✅ Use GitHub's secret scanning (detects committed credentials)

---

## 🔍 Known Security Considerations

### Installer Security

**One-line installer pattern (`curl | bash` or `irm | iex`):**
- **Risk**: Executes remote code immediately
- **Mitigation**: 
  - We use GitHub (trusted source)
  - Scripts are open source and reviewable
  - No elevation of privileges required
  - Alternative: Download first, review, then execute

**Example of safer installation:**
```bash
# Download first
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/v1.0.0/install.sh -o install.sh

# Review the script
cat install.sh
# or open in editor

# Run after review
bash install.sh
```

### Line Endings

Our `.gitattributes` enforces correct line endings:
- `.ps1` files → CRLF (Windows)
- `.sh` files → LF (Unix/Mac)

**Why this matters:** Incorrect line endings can cause PowerShell parse errors that might obscure malicious code. Our enforcement prevents this.

### AI Context in `.cursor/` Files

The `.cursor/` directory contains instructions for Cursor AI. These files:
- Are plain text (Markdown, YAML)
- Contain no executable code
- Are read by Cursor's AI to provide context
- Should be treated like documentation (reviewable, no secrets)

---

## 📋 Supported Versions

| Version | Supported          | Status |
| ------- | ------------------ | ------ |
| 1.0.x   | ✅ Yes            | Current stable release |
| < 1.0   | ❌ No             | Pre-release versions |

**Recommendation:** Always use the latest release for security updates.

---

## 🔐 Maintainer Security Practices

We follow these practices to keep the project secure:

- ✅ **Two-factor authentication** enabled on GitHub
- ✅ **Branch protection** on main branch (prevents force-push, requires review)
- ✅ **Signed commits** (in progress)
- ✅ **Dependabot alerts** enabled (for future dependencies)
- ✅ **Code review** for all pull requests
- ✅ **No third-party dependencies** in core scripts (reduces supply chain risk)

---

## 📜 Vulnerability Disclosure Policy

**Responsible Disclosure:**
- We appreciate security researchers who report vulnerabilities responsibly
- We will not pursue legal action against security researchers who:
  - Report vulnerabilities in good faith
  - Make a good faith effort to avoid privacy violations and data destruction
  - Give us reasonable time to address the issue before public disclosure

**Public Disclosure:**
- After a fix is released, we'll publish a security advisory (GitHub Security Advisory)
- We'll credit the reporter (unless they prefer anonymity)
- We'll document the vulnerability and fix in the CHANGELOG

---

## ❓ Questions?

If you have questions about security that aren't covered here:
- Open a [GitHub Discussion](https://github.com/u00dxk2/cursor-kooi-env-docs/discussions)
- Check our [FAQ](./docs/FAQ.md)
- Contact the maintainer via GitHub profile

---

**Thank you for helping keep this project and its users secure!** 🙏
