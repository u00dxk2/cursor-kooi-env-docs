# Validate Cursor Environment Docs Installation
# Run this script to verify your installation is complete and correct

Write-Host "`n🔍 Validating Cursor Environment Docs Installation...`n" -ForegroundColor Cyan

$errors = 0
$warnings = 0

# Helper function to check file exists
function Test-FileExists {
    param($path, $description)
    
    if (Test-Path $path) {
        Write-Host "  ✓ $description" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  ✗ $description - NOT FOUND" -ForegroundColor Red
        $script:errors++
        return $false
    }
}

# Helper function for optional files
function Test-OptionalFile {
    param($path, $description)
    
    if (Test-Path $path) {
        Write-Host "  ✓ $description" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ $description - Not found (optional)" -ForegroundColor Yellow
        $script:warnings++
    }
}

# 1. Check required files
Write-Host "[Required Files]" -ForegroundColor Cyan
Test-FileExists ".cursor/rules/project-environment.mdc" "project-environment.mdc"
Test-FileExists ".cursor/rules/environment-maintenance.mdc" "environment-maintenance.mdc"

# 2. Check optional but recommended files
Write-Host "`n[Recommended Files]" -ForegroundColor Cyan
Test-OptionalFile ".cursor/quick-prompt.txt" "quick-prompt.txt"
Test-OptionalFile ".cursor/check-env-docs.ps1" "check-env-docs.ps1"
Test-OptionalFile ".cursor/check-env-docs.sh" "check-env-docs.sh"
Test-OptionalFile ".cursor/README.md" "README.md"

# 3. Validate project-environment.mdc format
Write-Host "`n[Document Format]" -ForegroundColor Cyan

if (Test-Path ".cursor/rules/project-environment.mdc") {
    $content = Get-Content ".cursor/rules/project-environment.mdc" -Raw
    
    # Check for Last Updated
    if ($content -match '>\s*\*\*Last Updated:\*\*\s*\d{4}-\d{2}-\d{2}') {
        Write-Host "  ✓ 'Last Updated' date format correct" -ForegroundColor Green
        
        # Extract and check date
        if ($content -match '>\s*\*\*Last Updated:\*\*\s*(\d{4}-\d{2}-\d{2})') {
            $lastUpdatedStr = $matches[1]
            $lastUpdated = [DateTime]::Parse($lastUpdatedStr)
            $today = Get-Date
            $daysSince = ($today - $lastUpdated).Days
            
            if ($daysSince -le 7) {
                Write-Host "  ✓ Documentation is current ($daysSince days old)" -ForegroundColor Green
            } elseif ($daysSince -le 14) {
                Write-Host "  ⚠ Documentation needs review ($daysSince days old)" -ForegroundColor Yellow
                $warnings++
            } else {
                Write-Host "  ⚠ Documentation is stale ($daysSince days old)" -ForegroundColor Yellow
                $warnings++
            }
        }
    } else {
        Write-Host "  ✗ 'Last Updated' date missing or incorrect format" -ForegroundColor Red
        Write-Host "    Expected: > **Last Updated:** YYYY-MM-DD" -ForegroundColor Yellow
        $errors++
    }
    
    # Check for Next Review
    if ($content -match '>\s*\*\*Next Review:\*\*\s*\d{4}-\d{2}-\d{2}') {
        Write-Host "  ✓ 'Next Review' date present" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ 'Next Review' date missing" -ForegroundColor Yellow
        $warnings++
    }
    
    # Check for Maintenance Log
    if ($content -match 'Maintenance Log') {
        Write-Host "  ✓ Maintenance Log section present" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Maintenance Log section missing" -ForegroundColor Yellow
        $warnings++
    }
}

# 4. Check git integration
Write-Host "`n[Git Integration]" -ForegroundColor Cyan

if (Test-Path ".git") {
    Write-Host "  ✓ Git repository detected" -ForegroundColor Green
    
    # Check if .cursor/ is tracked
    $gitStatus = git status --porcelain .cursor/ 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ .cursor/ directory is in git repository" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ .cursor/ directory not tracked by git" -ForegroundColor Yellow
        Write-Host "    Run: git add .cursor/" -ForegroundColor Yellow
        $warnings++
    }
} else {
    Write-Host "  ⚠ Not a git repository" -ForegroundColor Yellow
    Write-Host "    This system works best with git version control" -ForegroundColor Yellow
    $warnings++
}

# 5. Check script executability
Write-Host "`n[Scripts]" -ForegroundColor Cyan

if (Test-Path ".cursor/check-env-docs.ps1") {
    Write-Host "  ✓ PowerShell check script present" -ForegroundColor Green
    
    # Try to run it
    try {
        $checkOutput = & .\.cursor\check-env-docs.ps1 2>&1
        Write-Host "  ✓ PowerShell check script is executable" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠ PowerShell check script may have execution issues" -ForegroundColor Yellow
        $warnings++
    }
}

# 6. Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Validation Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($errors -eq 0 -and $warnings -eq 0) {
    Write-Host "✅ EXCELLENT! Installation is complete and correct." -ForegroundColor Green
    Write-Host "`nYour environment documentation system is ready to use!" -ForegroundColor Green
} elseif ($errors -eq 0) {
    Write-Host "✅ GOOD! Installation is functional with $warnings warning(s)." -ForegroundColor Yellow
    Write-Host "`nThe system will work, but consider addressing the warnings above." -ForegroundColor Yellow
} else {
    Write-Host "❌ ISSUES FOUND: $errors error(s), $warnings warning(s)" -ForegroundColor Red
    Write-Host "`nPlease fix the errors above before using the system." -ForegroundColor Red
    Write-Host "See docs/TROUBLESHOOTING.md for help." -ForegroundColor Yellow
}

Write-Host "`n📚 Next Steps:" -ForegroundColor Cyan
if ($errors -eq 0) {
    Write-Host "  1. Commit .cursor/ to git: git add .cursor/ && git commit" -ForegroundColor White
    Write-Host "  2. Start using AI with your project" -ForegroundColor White
    Write-Host "  3. Check staleness anytime: .\.cursor\check-env-docs.ps1" -ForegroundColor White
} else {
    Write-Host "  1. Fix errors listed above" -ForegroundColor White
    Write-Host "  2. Run validation again: .\.cursor\validate-install.ps1" -ForegroundColor White
    Write-Host "  3. See docs/TROUBLESHOOTING.md for help" -ForegroundColor White
}

Write-Host "`n"
exit $errors

