# Node.js + Express Project Environment

> **Last Updated:** 2025-10-04  
> **Review Frequency:** Check every 7 days or after major changes  
> **Next Review:** 2025-10-11

This document provides environment context for AI assistants working with this Node.js/Express project.

## 📋 Maintenance Log

| Date | Change | Updated By |
|------|--------|------------|
| 2025-10-04 | Initial environment documentation | AI Assistant |

---

## 1. Directory Structure

**Project Root:** `/path/to/your/nodejs-express` (Unix) or `C:\path\to\your\nodejs-express` (Windows)

```
nodejs-express/
├── .cursor/                    # Environment documentation system
├── src/
│   └── index.js               # Express server entry point
├── node_modules/              # npm dependencies (git-ignored)
├── package.json               # Project dependencies
├── package-lock.json          # Dependency lock file
├── .env                       # Environment variables (git-ignored)
├── .env.example               # Environment variable template
├── .gitignore                 # Git ignore rules
└── README.md                  # Project documentation
```

**Important:**
- Always run commands from project root
- `node_modules/` can be large (100s of MB) - is git-ignored
- `.env` contains secrets - never commit it

---

## 2. Shell Environment

**Shell Type:** Varies by platform
- **Unix/macOS:** Bash or Zsh
- **Windows:** PowerShell or Command Prompt

### Critical Shell Syntax Differences

#### PowerShell (Windows)

❌ **DON'T USE:** Bash-style command chaining
```powershell
cd src && node index.js  # FAILS in PowerShell
npm install && npm start  # FAILS in PowerShell
```

✅ **DO USE:** PowerShell semicolon separator or separate commands
```powershell
cd src; node index.js
# or
npm install
npm start
```

**Other PowerShell Tips:**
- Use quotes around paths with spaces: `cd "C:\My Projects\app"`
- Environment variables: `$env:NODE_ENV = "production"`
- Cannot use `&&` for conditional execution

#### Bash/Zsh (Unix/macOS)

✅ **Standard Unix conventions work:**
```bash
cd src && node index.js        # Works
npm install && npm start       # Works
export NODE_ENV=production     # Set env var
```

---

## 3. Common Commands

### npm Package Management

```bash
# Install all dependencies
npm install

# Install a specific package
npm install express
npm install --save-dev nodemon

# Remove a package
npm uninstall package-name

# Update dependencies
npm update

# Audit for vulnerabilities
npm audit
npm audit fix
```

### Development

```bash
# Start development server
npm start

# Start with automatic reload (if nodemon installed)
npm run dev

# Run with environment variables
NODE_ENV=development npm start  # Unix
$env:NODE_ENV="development"; npm start  # PowerShell
```

### Git Workflow

```bash
# Check status
git status

# Stage changes
git add .
git add src/index.js

# Commit
git commit -m "feat: add health check endpoint"

# Push
git push origin main
```

---

## 4. Tech Stack

### Core Technologies
- **Runtime:** Node.js v18+ (LTS)
- **Framework:** Express.js v4.18+
- **Language:** JavaScript (ES6+)
- **Package Manager:** npm v9+

### Key Dependencies
- **express** - Web framework
- **dotenv** - Environment variable management
- *(Add others as project grows)*

### Development Dependencies
- **nodemon** (optional) - Auto-restart on file changes
- **eslint** (optional) - Code linting
- **jest** (optional) - Testing framework

### External Services
*(None in this simple example)*

### Required Environment Variables
See `.env.example` for template. Key variables:
- `PORT` - Server port (default: 3000)
- `NODE_ENV` - Environment mode (development/production)

---

## 5. Environment Gotchas

### ❌ Common Mistakes to Avoid

**Mistake #1: Not Installing Dependencies**
- **Problem:** Running `node src/index.js` without `npm install` fails with "Cannot find module 'express'"
- **Solution:** Always run `npm install` first when cloning or pulling changes

**Mistake #2: Port Already in Use**
- **Problem:** Error: `EADDRINUSE :::3000` when starting server
- **Solution:** 
  ```bash
  # Find process using port
  lsof -i :3000  # Unix/macOS
  netstat -ano | findstr :3000  # Windows
  
  # Kill the process or change PORT in .env
  ```

**Mistake #3: Missing .env File**
- **Problem:** App starts but uses unexpected defaults
- **Solution:** Copy `.env.example` to `.env` and configure

**Mistake #4: Committing node_modules/**
- **Problem:** Repo becomes huge (100s of MB)
- **Solution:** Ensure `.gitignore` includes `node_modules/`

**Mistake #5: Wrong Node Version**
- **Problem:** Syntax errors or package incompatibilities
- **Solution:** Use Node 18+ (check with `node --version`)

### Platform-Specific Issues

**Windows:**
- Line endings: Git may convert LF to CRLF - configure with:
  ```bash
  git config --global core.autocrlf true
  ```
- Path separators: Use forward slashes `/` in code, backslashes `\` in terminal

**macOS:**
- May need to allow connections through firewall when running server
- Use Homebrew to install Node: `brew install node`

---

## 6. Development Workflow

### First Time Setup

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd nodejs-express
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

4. **Start development server**
   ```bash
   npm start
   ```

5. **Visit app**
   - Open browser to http://localhost:3000
   - You should see the welcome JSON response

### Daily Development

```bash
# Start server
npm start

# Make code changes
# Server automatically restarts if using nodemon

# Test changes
curl http://localhost:3000
curl http://localhost:3000/health

# Commit changes
git add .
git commit -m "feat: add new endpoint"
git push
```

### Adding New Dependencies

```bash
# Install package
npm install package-name

# Commit the package.json and package-lock.json
git add package.json package-lock.json
git commit -m "deps: add package-name"
```

### Troubleshooting

```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json  # Unix
Remove-Item -Recurse node_modules, package-lock.json  # PowerShell
npm install

# Check for outdated packages
npm outdated

# Verify Node/npm versions
node --version
npm --version
```

---

## 7. IDE/Editor Setup

### Recommended Extensions (VS Code)
- **ESLint** - JavaScript linting
- **Prettier** - Code formatting
- **REST Client** - Test endpoints
- **Path Intellisense** - Path autocomplete

### Configuration
- Tab size: 2 spaces (JavaScript convention)
- Format on save: Recommended
- Debugger: Use VS Code's built-in Node debugger

---

## 8. Testing

*(Not implemented in basic example)*

If adding tests:
```bash
# Install Jest
npm install --save-dev jest

# Run tests
npm test

# Run with coverage
npm test -- --coverage
```

---

## 9. Additional Resources

### Related Documentation
- [Express.js Documentation](https://expressjs.com/)
- [Node.js Documentation](https://nodejs.org/docs/)
- [npm Documentation](https://docs.npmjs.com/)

### Project Links
- Environment docs system: `.cursor/README.md`
- AI maintenance rules: `.cursor/rules/environment-maintenance.mdc`

---

## 🔄 When to Update This Document

### Update Immediately When:
- ✅ Node/npm version requirements change
- ✅ New dependencies added to package.json
- ✅ New environment variables required
- ✅ Development workflow changes
- ✅ New gotcha or common mistake discovered
- ✅ Deploy process added

### Review Periodically:
- 📅 Every 7 days to check for drift
- 📅 Before major releases
- 📅 After dependency upgrades

---

## 🤖 AI Assistant Instructions

When starting a new session:
1. **Read this document** to understand the environment
2. **Check "Last Updated"** date at top
3. **If >7 days old:** Offer to review and update
4. **If >14 days old:** Strongly recommend immediate update
5. **During work:** Update when discovering environment changes
6. **Add entries** to Maintenance Log when making changes

### Update Process
1. Review recent package.json changes
2. Check if documented commands are still correct
3. Update relevant sections
4. Update "Last Updated" and "Next Review" dates
5. Add Maintenance Log entry
6. Commit with message like: `docs: update environment docs`

---

**Generated using:** [Cursor Environment Docs System](https://github.com/u00dxk2/cursor-kooi-env-docs)

