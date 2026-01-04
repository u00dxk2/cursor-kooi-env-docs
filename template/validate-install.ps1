# Validate Cursor Environment Docs Installation
# Run this script to verify your installation is complete and correct

Write-Host "`n[INFO] Validating Cursor Environment Docs Installation...`n" -ForegroundColor Cyan

# Resolve paths relative to the script location so this works even when invoked from another directory.
# This script lives in: <project>/.cursor/validate-install.ps1
$cursorDir = $PSScriptRoot
$projectRoot = Split-Path -Parent $cursorDir

$errors = 0
$warnings = 0

# Helper function to check file exists
function Test-FileExists {
    param($path, $description)
    
    if (Test-Path $path) {
        Write-Host "  [OK] $description" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  [ERR] $description - NOT FOUND" -ForegroundColor Red
        $script:errors++
        return $false
    }
}

# Helper function for optional files
function Test-OptionalFile {
    param($path, $description)
    
    if (Test-Path $path) {
        Write-Host "  [OK] $description" -ForegroundColor Green
    } else {
        Write-Host "  [WARN] $description - Not found (optional)" -ForegroundColor Yellow
        $script:warnings++
    }
}

# 1. Check required files
Write-Host "[Required Files]" -ForegroundColor Cyan
Test-FileExists (Join-Path $cursorDir "rules\\project-environment.mdc") "project-environment.mdc"
Test-FileExists (Join-Path $cursorDir "rules\\environment-maintenance.mdc") "environment-maintenance.mdc"

# 2. Check optional but recommended files
Write-Host "`n[Recommended Files]" -ForegroundColor Cyan
Test-OptionalFile (Join-Path $cursorDir "quick-prompt.txt") "quick-prompt.txt"
Test-OptionalFile (Join-Path $cursorDir "check-env-docs.ps1") "check-env-docs.ps1"
Test-OptionalFile (Join-Path $cursorDir "check-env-docs.sh") "check-env-docs.sh"
Test-OptionalFile (Join-Path $cursorDir "README.md") "README.md"

# 3. Validate project-environment.mdc format
Write-Host "`n[Document Format]" -ForegroundColor Cyan

if (Test-Path ".cursor/rules/project-environment.mdc") {
$envDocPath = Join-Path $cursorDir "rules\\project-environment.mdc"
if (Test-Path $envDocPath) {
    $content = Get-Content $envDocPath -Raw
    
    # Check for Last Updated
    if ($content -match '>\s*\*\*Last Updated:\*\*\s*\d{4}-\d{2}-\d{2}') {
        Write-Host "  [OK] 'Last Updated' date format correct" -ForegroundColor Green
        
        # Extract and check date
        if ($content -match '>\s*\*\*Last Updated:\*\*\s*(\d{4}-\d{2}-\d{2})') {
            $lastUpdatedStr = $matches[1]
            $lastUpdated = [DateTime]::Parse($lastUpdatedStr)
            $today = Get-Date
            $daysSince = ($today - $lastUpdated).Days
            
            if ($daysSince -le 7) {
                Write-Host "  [OK] Documentation is current ($daysSince days old)" -ForegroundColor Green
            } elseif ($daysSince -le 14) {
                Write-Host "  [WARN] Documentation needs review ($daysSince days old)" -ForegroundColor Yellow
                $warnings++
            } else {
                Write-Host "  [WARN] Documentation is stale ($daysSince days old)" -ForegroundColor Yellow
                $warnings++
            }
        }
    } else {
        Write-Host "  [ERR] 'Last Updated' date missing or incorrect format" -ForegroundColor Red
        Write-Host "    Expected: > **Last Updated:** YYYY-MM-DD" -ForegroundColor Yellow
        $errors++
    }
    
    # Check for Next Review
    if ($content -match '>\s*\*\*Next Review:\*\*\s*\d{4}-\d{2}-\d{2}') {
        Write-Host "  [OK] 'Next Review' date present" -ForegroundColor Green
    } else {
        Write-Host "  [WARN] 'Next Review' date missing" -ForegroundColor Yellow
        $warnings++
    }
    
    # Check for Maintenance Log
    if ($content -match 'Maintenance Log') {
        Write-Host "  [OK] Maintenance Log section present" -ForegroundColor Green
    } else {
        Write-Host "  [WARN] Maintenance Log section missing" -ForegroundColor Yellow
        $warnings++
    }
}

# 4. Check git integration
Write-Host "`n[Git Integration]" -ForegroundColor Cyan

$gitCmd = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitCmd) {
    Write-Host "  [WARN] Git is not installed or not on PATH (git command not found)" -ForegroundColor Yellow
    Write-Host "         This system still works locally, but shared docs are best committed to a repo." -ForegroundColor Yellow
    $warnings++
} else {
    $isInsideWorkTree = $false
    try {
        $inside = (git rev-parse --is-inside-work-tree 2>$null)
        if ($LASTEXITCODE -eq 0 -and $inside -eq "true") { $isInsideWorkTree = $true }
    } catch {
        $isInsideWorkTree = $false
    }

    if ($isInsideWorkTree) {
        Write-Host "  [OK] Git repository detected" -ForegroundColor Green

        # Check whether any .cursor files are tracked (not just whether git is functioning)
        $tracked = @(git ls-files -- ".cursor" 2>$null)
        if ($tracked.Count -gt 0) {
            Write-Host "  [OK] .cursor/ has tracked file(s) in git" -ForegroundColor Green
        } else {
            # If .cursor exists but has no tracked files, it's either untracked or ignored
            $ignored = $false
            try {
                git check-ignore -q ".cursor" 2>$null
                if ($LASTEXITCODE -eq 0) { $ignored = $true }
            } catch {
                $ignored = $false
            }

            if ($ignored) {
                Write-Host "  [WARN] .cursor/ appears to be ignored by git" -ForegroundColor Yellow
                Write-Host "         Remove it from .gitignore so the rules/docs can be shared." -ForegroundColor Yellow
                $warnings++
            } else {
                Write-Host "  [WARN] .cursor/ is not tracked by git yet" -ForegroundColor Yellow
                Write-Host "         Run: git add .cursor/" -ForegroundColor Yellow
                $warnings++
            }
        }
    } else {
        Write-Host "  [WARN] Not a git repository" -ForegroundColor Yellow
        Write-Host "         This system works locally; git is recommended for team sharing." -ForegroundColor Yellow
        $warnings++
    }
}

# 5. Check script executability
Write-Host "`n[Scripts]" -ForegroundColor Cyan

if (Test-Path (Join-Path $cursorDir "check-env-docs.ps1")) {
    Write-Host "  [OK] PowerShell check script present" -ForegroundColor Green
    
    # Try to run it
    try {
        $checkOutput = & (Join-Path $cursorDir "check-env-docs.ps1") 2>&1
        Write-Host "  [OK] PowerShell check script is executable" -ForegroundColor Green
    } catch {
        Write-Host "  [WARN] PowerShell check script may have execution issues" -ForegroundColor Yellow
        $warnings++
    }
}

# 6. Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Validation Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($errors -eq 0 -and $warnings -eq 0) {
    Write-Host "[OK] EXCELLENT! Installation is complete and correct." -ForegroundColor Green
    Write-Host "`nYour environment documentation system is ready to use!" -ForegroundColor Green
} elseif ($errors -eq 0) {
    Write-Host "[OK] GOOD! Installation is functional with $warnings warning(s)." -ForegroundColor Yellow
    Write-Host "`nThe system will work, but consider addressing the warnings above." -ForegroundColor Yellow
} else {
    Write-Host "[ERR] ISSUES FOUND: $errors error(s), $warnings warning(s)" -ForegroundColor Red
    Write-Host "`nPlease fix the errors above before using the system." -ForegroundColor Red
    Write-Host "See docs/TROUBLESHOOTING.md for help." -ForegroundColor Yellow
}

Write-Host "`n[Next Steps]" -ForegroundColor Cyan
if ($errors -eq 0) {
    Write-Host "  1. (Optional) Commit .cursor/ to git: git add .cursor/ ; git commit" -ForegroundColor White
    Write-Host "  2. Start using AI with your project" -ForegroundColor White
    Write-Host "  3. Check staleness anytime: .\.cursor\check-env-docs.ps1" -ForegroundColor White
} else {
    Write-Host "  1. Fix errors listed above" -ForegroundColor White
    Write-Host "  2. Run validation again: .\.cursor\validate-install.ps1" -ForegroundColor White
    Write-Host "  3. See docs/TROUBLESHOOTING.md for help" -ForegroundColor White
}

Write-Host "`n"
exit $errors

