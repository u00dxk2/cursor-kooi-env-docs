# Python + Flask Example

This is a complete example of a Python/Flask project using the Cursor Environment Docs system.

## What This Example Shows

- ✅ Proper `.cursor/` directory structure for Python projects
- ✅ Real `project-environment.md` for a Flask application
- ✅ Shell-specific command examples (Unix and Windows)
- ✅ pip/venv package management documentation
- ✅ Common Python development gotchas
- ✅ Virtual environment handling
- ✅ Testing with pytest

## Project Structure

```
python-flask/
├── .cursor/                    # Environment docs system
│   ├── project-environment.md  # Complete Python/Flask environment docs
│   ├── quick-prompt.txt
│   ├── check-env-docs.sh
│   ├── check-env-docs.ps1
│   ├── README.md
│   └── rules/
│       └── environment-maintenance.mdc
├── app/
│   └── app.py                 # Simple Flask application
├── venv/                      # Virtual environment (git-ignored)
├── requirements.txt           # Python dependencies
├── .gitignore
├── .env.example               # Environment variable template
└── README.md                  # This file
```

## Quick Start

1. **Create virtual environment:**
   ```bash
   # Unix/macOS
   python3 -m venv venv
   source venv/bin/activate
   
   # Windows
   python -m venv venv
   .\venv\Scripts\Activate.ps1
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Set up environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

4. **Run the application:**
   ```bash
   python app/app.py
   # or
   flask run
   ```

5. **Visit:** http://localhost:5000

## What's Documented

The `.cursor/project-environment.md` file demonstrates how to document:

- **Virtual environment** setup and activation
- **Shell differences** (PowerShell vs Bash) for Python
- **pip commands** with correct syntax
- **Environment variables** and `.env` setup
- **Common gotchas** like venv activation, import errors
- **Git workflow** for Python projects
- **Testing commands** with pytest
- **Linting** with flake8/black
- **Development vs production** configurations

## Using This Example

### Option 1: Copy for Your Project

Copy the `.cursor/` directory to your own Python project:

```bash
cp -r examples/python-flask/.cursor /path/to/your-project/
```

Then customize `project-environment.md` for your specific setup.

### Option 2: Use as Reference

Open `.cursor/project-environment.md` to see how Python-specific documentation should look.

### Option 3: Generate Your Own

Use the quick-prompt.txt to have your AI assistant generate docs for your project.

## Key Takeaways

This example shows Python-specific considerations:

1. **Virtual environments** - Critical for Python, document activation commands
2. **requirements.txt** - Track dependencies, pin versions
3. **Import paths** - Document how modules are organized
4. **Shell activation** - Different commands for different shells/OSes
5. **Common Python errors** - ImportError, venv not activated, etc.

## Learn More

- [Main Documentation](../../README.md)
- [Setup Guide](../../docs/SETUP-GUIDE.md)
- [Quick Setup](../../docs/QUICK-SETUP.md)

---

**This is a working example!** You can actually run this Flask app and see it work.

