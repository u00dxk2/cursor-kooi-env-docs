# Teaching Cursor to Remember
### Introducing Cursor Kooi Environment Docs

**Go here if you want to get right to it:**
[https://github.com/u00dxk2/cursor-kooi-env-docs](https://github.com/u00dxk2/cursor-kooi-env-docs)

### The Problem: Context Amnesia
Cursor is powerful, but every new chat starts with a blank slate. The agent doesn’t remember your shell, your OS’s quirks, the correct entry points to your stack, your localhost ports, or the "gotchas" you tripped over last week.

That amnesia resets trust, wastes minutes, burns tokens, and breaks flow. **Cursor Kooi Environment Docs** fixes that by auto‑loading your project’s reality into every conversation, making the assistant behave like a teammate who’s already onboarded.

### What It Is
This is an open‑source, zero‑dependency documentation system that lives in your repo under `.cursor/rules/`. It is built on a specific architecture designed for long-term maintainability: **Separation of Concerns**.

1.  **The Brain (Passive Context):** `project-environment.mdc`
    This file is pure data. It holds your paths, commands, tech stack, and known issues. No instructions, just facts.
2.  **The Guardian (Active Rule):** `environment-maintenance.mdc`
    This file is pure logic. It runs silently in the background, monitoring "The Brain." If the documentation gets stale or files change, *this* rule prompts the AI to update the docs.

Because these files use YAML frontmatter with `alwaysApply: true`, Cursor reads them automatically at the start of every conversation. No pasting. No pinning. No rituals. Just context that sticks.

### What It Does
*   **Auto‑ingests reality:** Shell, OS, paths, ports, and boot steps are injected into the context window immediately.
*   **Captures "Gotchas":** When you trip on something non‑obvious, you write it down once. The AI reads it forever.
*   **Self‑Healing:** The Active Rule watches your project. If `package.json` changes or the docs haven't been updated in 7 days, the AI proactively offers to refresh the environment file.
*   **Validates Itself:** Simple PowerShell/Bash scripts verify that the docs are present, parseable, and current.

The payoff: fewer wrong turns, more first‑try correctness, and the end of saying, "No, not like that; we’re on PowerShell."

### Why I Built It
I was tired of the Groundhog Day routine:

1.  **Me:** "Install dependencies."
2.  **Cursor:** Suggests `npm install && npm start`
3.  **Me:** *Sighs.* "I'm on Windows PowerShell. It chokes on `&&`."
4.  **Cursor:** "Apologies. Here is the corrected command..."
5.  *New chat next week… repeat steps 1-4.*

The assistant wasn’t failing; I was failing to give it a Single Source of Truth. I needed a repeatable, opinionated way to store environment reality where Cursor *always* looks—and a way to teach the assistant to keep that reality fresh.

### How It Works
No runtimes, no background services—just text and shell. The system is Markdown (`.mdc`) plus a couple of scripts.

The installers are genuine one‑liners that handle the cross-platform nuances (like ensuring `CRLF` line endings for PowerShell and `LF` for Bash):

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.ps1 | iex
```

**macOS/Linux (Bash):**
```bash
curl -fsSL https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/install.sh | bash
```

**The Shape of the Install:**
```text
your-project/
└── .cursor/
    ├── rules/
    │   ├── project-environment.mdc      # The Data (Context)
    │   └── environment-maintenance.mdc  # The Logic (Rule)
    ├── check-env-docs.ps1 / .sh         # Staleness checkers
    ├── validate-install.ps1 / .sh       # Integrity validators
    └── quick-prompt.txt                 # Setup prompt
```

### The "Environment-First" Workflow
1.  **Install:** Run the one-liner.
2.  **Generate:** Use the `quick-prompt.txt` to have Cursor write your initial `project-environment.mdc`.
3.  **Commit:** Check `.cursor/` into git so your whole team shares the brain.
4.  **Work:** Open a new chat. The doc is already in context. Give tasks as if the assistant just finished onboarding.
5.  **Maintain:** When you change a library, the Active Rule will notice and ask: *"I see package.json changed. Should I update project-environment.mdc?"*

### Before vs. After

**Before:**
> **You:** “Install dependencies.”
> **Cursor:** `npm install && npm start`
> **Terminal:** *Error: The token '&&' is not a valid statement separator in this version.*
> **You:** *Fixes it manually.* Next week: Same mistake.

**After (v1.1.3):**
> **You:** “Install dependencies.”
> **Cursor (Reads Context):** *User is on Windows 11 using PowerShell 7. Syntax requires `;`.*
> **Cursor:** `npm install; npm start`
> **Terminal:** *Success.*

### Security & Practicality
*   **Plain Text:** Everything lives in your repo. No black boxes.
*   **Zero Elevation:** Installers run in user-space. No admin rights needed.
*   **No Secrets:** The templates explicitly warn you not to store API keys in these files (use `.env` as usual).
*   **Opt-In:** If you have sensitive internal paths, you can `.gitignore` the folder; it works just as well as a local-only tool.

### Try It (Under 60 Seconds)
Go to a project where you constantly have to correct the AI. Run the installer. Start a new chat. Ask it to do that thing it usually gets wrong.

Watch it "just know."

Then capture a fresh gotcha in the doc, and let tomorrow’s chat benefit from today’s pain. That’s the compounding effect of **Cursor Kooi Environment Docs**.

[**Get it on GitHub**](https://github.com/u00dxk2/cursor-kooi-env-docs)


