# Node.js + Express Example

This is a complete example of a Node.js/Express project using the Cursor Environment Docs system.

## What This Example Shows

- ✅ Proper `.cursor/` directory structure
- ✅ Real `project-environment.md` for a Node.js project
- ✅ Shell-specific command examples (both Unix and Windows)
- ✅ npm package management documentation
- ✅ Common Node.js development gotchas
- ✅ Environment variable handling
- ✅ Testing and linting workflows

## Project Structure

```
nodejs-express/
├── .cursor/                    # Environment docs system
│   ├── project-environment.md  # Complete Node.js environment docs
│   ├── quick-prompt.txt
│   ├── check-env-docs.sh
│   ├── check-env-docs.ps1
│   ├── README.md
│   └── rules/
│       └── environment-maintenance.mdc
├── src/
│   └── index.js               # Simple Express server
├── package.json               # Node.js dependencies
├── .gitignore
├── .env.example               # Environment variable template
└── README.md                  # This file
```

## Quick Start

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Set up environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

3. **Run the server:**
   ```bash
   npm start
   ```

4. **Visit:** http://localhost:3000

## What's Documented

The `.cursor/project-environment.md` file demonstrates how to document:

- **Directory structure** with absolute paths
- **Shell differences** (PowerShell vs Bash)
- **npm commands** with correct syntax
- **Environment variables** and `.env` setup
- **Common gotchas** like `node_modules` issues, port conflicts
- **Git workflow** for this project
- **Testing commands** with Jest
- **Linting** with ESLint
- **Development vs production** modes

## Using This Example

### Option 1: Copy for Your Project

Copy the `.cursor/` directory to your own Node.js project:

```bash
cp -r examples/nodejs-express/.cursor /path/to/your-project/
```

Then customize `project-environment.md` for your specific setup.

### Option 2: Use as Reference

Open `.cursor/project-environment.md` to see:
- What information to include
- How to format it
- Examples of good documentation
- How to document shell-specific commands

### Option 3: Generate Your Own

Use the quick-prompt.txt to have your AI assistant generate docs specific to your project:

```bash
cat .cursor/quick-prompt.txt
# Copy output and paste to your AI assistant
```

## Key Takeaways

This example shows:

1. **Be specific about paths** - Document absolute paths, show Windows vs Unix differences
2. **Show command examples** - Don't just list commands, show correct syntax for each shell
3. **Document gotchas** - Include common mistakes and how to fix them
4. **Keep it current** - Use the auto-update system to keep docs fresh
5. **Make it practical** - Focus on commands you actually use daily

## Learn More

- [Main Documentation](../../README.md)
- [Setup Guide](../../docs/SETUP-GUIDE.md)
- [Quick Setup](../../docs/QUICK-SETUP.md)

---

**This is a working example!** You can actually run this Express server and see it work.

