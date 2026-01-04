# Cursor Environment Docs System - Installer (Windows)
# https://github.com/u00dxk2/cursor-kooi-env-docs
# Version: 1.2.1
# Updated: 2026-01-04

# Parse command line arguments
$forceInstall = $args -contains "--force"

Write-Host "`n[INFO] Installing Cursor Environment Docs System...`n" -ForegroundColor Cyan

# Git is optional. We warn if it looks like you're not in a git repository root, but we do not block installation.
if (-not (Test-Path ".git")) {
    Write-Host "[WARN] Not in a git repository root (.git not found in current directory)" -ForegroundColor Yellow
    Write-Host "       This system works best when committed to version control, but it can still be used locally." -ForegroundColor Yellow
    Write-Host "       Tip: If you want git here later, run: git init" -ForegroundColor Yellow
}

# Create .cursor directory structure
Write-Host "[INFO] Creating directory structure..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path ".cursor\rules" | Out-Null

# Base URL for downloading files
$baseUrl = "https://raw.githubusercontent.com/u00dxk2/cursor-kooi-env-docs/main/template"

# Arrays to track installation results
$installedFiles = @()
$skippedFiles = @()
$failedDownloads = 0

# Check if .cursor/ directory has existing files
if ((Test-Path ".cursor") -and ((Get-ChildItem ".cursor" -Force -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0)) {
    if (-not $forceInstall) {
        Write-Host "[WARN] Existing .cursor\ setup detected" -ForegroundColor Yellow
        Write-Host "       Existing files will be preserved (use --force to overwrite)" -ForegroundColor Yellow
        Write-Host ""
    }
    else {
        Write-Host "[WARN] Existing .cursor\ setup detected" -ForegroundColor Yellow
        Write-Host "       --force flag detected: will overwrite existing files" -ForegroundColor Yellow
        Write-Host ""
    }
}

# Download template files
Write-Host "[INFO] Downloading template files..." -ForegroundColor Cyan

function Download-File {
    param($url, $dest)
    $filename = Split-Path $dest -Leaf
    
    # Check if file exists and we're not in force mode
    if ((Test-Path $dest) -and (-not $forceInstall)) {
        Write-Host "  [WARN] $filename (exists - skipped)" -ForegroundColor Yellow
        $script:skippedFiles += $filename
        return $true
    }
    
    # Download the file
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -ErrorAction Stop
        Write-Host "  [OK] $filename" -ForegroundColor Green
        $script:installedFiles += $filename
        return $true
    }
    catch {
        Write-Host "  [ERR] Failed to download $filename" -ForegroundColor Red
        return $false
    }
}

if (!(Download-File "$baseUrl/quick-prompt.txt" ".cursor\quick-prompt.txt")) { $failedDownloads++ }
if (!(Download-File "$baseUrl/rules/environment-maintenance.mdc" ".cursor\rules\environment-maintenance.mdc")) { $failedDownloads++ }
if (!(Download-File "$baseUrl/check-env-docs.ps1" ".cursor\check-env-docs.ps1")) { $failedDownloads++ }
if (!(Download-File "$baseUrl/README.md" ".cursor\README.md")) { $failedDownloads++ }
if (!(Download-File "$baseUrl/validate-install.ps1" ".cursor\validate-install.ps1")) { $failedDownloads++ }

# Check if any critical files failed
if ($failedDownloads -gt 0) {
    Write-Host "`n[ERR] Installation failed: $failedDownloads file(s) could not be downloaded" -ForegroundColor Red
    Write-Host "Please check your internet connection and try again." -ForegroundColor Yellow
    exit 1
}

Write-Host "`n[OK] Template files installed successfully!" -ForegroundColor Green
Write-Host ""

# Show summary
if ($installedFiles.Count -gt 0 -or $skippedFiles.Count -gt 0) {
    Write-Host "[INFO] Summary:" -ForegroundColor Cyan
    if ($installedFiles.Count -gt 0) {
        Write-Host "  [OK] Installed: $($installedFiles.Count) file(s)" -ForegroundColor Green
    }
    if ($skippedFiles.Count -gt 0) {
        Write-Host "  [WARN] Skipped: $($skippedFiles.Count) existing file(s)" -ForegroundColor Yellow
        Write-Host "    Tip: Use 'irm ... | iex' with --force to overwrite existing files" -ForegroundColor Yellow
        Write-Host "    Or download and run: .\install.ps1 --force" -ForegroundColor Yellow
    }
    Write-Host ""
}

Write-Host "[WARN] IMPORTANT: Installation requires one more critical step!" -ForegroundColor Yellow
Write-Host "You must create the project-environment.mdc file to complete setup.`n" -ForegroundColor Yellow

Write-Host "[INFO] Next steps to complete installation:" -ForegroundColor Cyan
Write-Host "1. View the quick prompt:"
Write-Host "   Get-Content .cursor\quick-prompt.txt" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Ensure you're in your PROJECT ROOT directory (not home directory):"
Write-Host "   pwd   # Should show your project path" -ForegroundColor Yellow
Write-Host ""
Write-Host "3. Open this project with Cursor"
Write-Host "4. Ask Cursor to create .cursor\rules\project-environment.mdc using the prompt"
Write-Host "5. (Optional) Commit documentation files to git (recommended for teams):"
Write-Host "   git add .cursor\ ; git commit -m 'feat: Add environment documentation system'" -ForegroundColor Yellow
Write-Host ""
Write-Host "   Note: .sh files don't exist on Windows-only projects - that's normal." -ForegroundColor Cyan
Write-Host "   IMPORTANT: Commit the .cursor\ documentation files (not personal IDE state)." -ForegroundColor Yellow
Write-Host "   Do NOT add .cursor\ to .gitignore - it's shared team documentation!" -ForegroundColor Yellow
Write-Host ""
Write-Host "[INFO] Check documentation status anytime:" -ForegroundColor Cyan
Write-Host "   .\.cursor\check-env-docs.ps1" -ForegroundColor Yellow
Write-Host ""
Write-Host "[INFO] Learn more: https://github.com/u00dxk2/cursor-kooi-env-docs" -ForegroundColor Cyan
Write-Host ""

