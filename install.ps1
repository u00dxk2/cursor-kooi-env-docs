# Cursor Environment Docs System - Installer (Windows)
# https://github.com/u00dxk2/cursor-kooi-env-docs
# Version: 1.0.1
# Updated: 2025-10-05

# Parse command line arguments
$forceInstall = $args -contains "--force"

Write-Host "`n🚀 Installing Cursor Environment Docs System...`n" -ForegroundColor Cyan

# Check if in a git repo (warning, not error)
if (-not (Test-Path ".git")) {
    Write-Host "⚠️  Warning: Not in a git repository root" -ForegroundColor Yellow
    Write-Host "This tool works best in the root of a git project."
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        Write-Host "Installation cancelled."
        exit 1
    }
}

# Create .cursor directory structure
Write-Host "📁 Creating directory structure..." -ForegroundColor Cyan
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
        Write-Host "⚠️  Existing .cursor\ setup detected" -ForegroundColor Yellow
        Write-Host "Existing files will be preserved (use --force to overwrite)" -ForegroundColor Yellow
        Write-Host ""
    }
    else {
        Write-Host "⚠️  Existing .cursor\ setup detected" -ForegroundColor Yellow
        Write-Host "--force flag detected: will overwrite existing files" -ForegroundColor Yellow
        Write-Host ""
    }
}

# Download template files
Write-Host "📥 Downloading template files..." -ForegroundColor Cyan

function Download-File {
    param($url, $dest)
    $filename = Split-Path $dest -Leaf
    
    # Check if file exists and we're not in force mode
    if ((Test-Path $dest) -and (-not $forceInstall)) {
        Write-Host "  ⚠ $filename (exists - skipped)" -ForegroundColor Yellow
        $script:skippedFiles += $filename
        return $true
    }
    
    # Download the file
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -ErrorAction Stop
        Write-Host "  ✓ $filename" -ForegroundColor Green
        $script:installedFiles += $filename
        return $true
    }
    catch {
        Write-Host "  ✗ Failed to download $filename" -ForegroundColor Red
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
    Write-Host "`n❌ Installation failed: $failedDownloads file(s) could not be downloaded" -ForegroundColor Red
    Write-Host "Please check your internet connection and try again." -ForegroundColor Yellow
    exit 1
}

Write-Host "`n✅ Template files installed successfully!" -ForegroundColor Green
Write-Host ""

# Show summary
if ($installedFiles.Count -gt 0 -or $skippedFiles.Count -gt 0) {
    Write-Host "📊 Summary:" -ForegroundColor Cyan
    if ($installedFiles.Count -gt 0) {
        Write-Host "  ✓ Installed: $($installedFiles.Count) file(s)" -ForegroundColor Green
    }
    if ($skippedFiles.Count -gt 0) {
        Write-Host "  ⚠ Skipped: $($skippedFiles.Count) existing file(s)" -ForegroundColor Yellow
        Write-Host "    Tip: Use 'irm ... | iex' with --force to overwrite existing files" -ForegroundColor Yellow
        Write-Host "    Or download and run: .\install.ps1 --force" -ForegroundColor Yellow
    }
    Write-Host ""
}

Write-Host "⚠️  IMPORTANT: Installation requires one more critical step!" -ForegroundColor Red
Write-Host "You must create the project-environment.mdc file to complete setup.`n" -ForegroundColor Yellow

Write-Host "📝 Next steps to complete installation:" -ForegroundColor Cyan
Write-Host "1. View the quick prompt:"
Write-Host "   Get-Content .cursor\quick-prompt.txt" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Open this project with Cursor"
Write-Host "3. Ask Cursor to create .cursor\rules\project-environment.mdc using the prompt"
Write-Host "4. Commit ALL .cursor/ files to Git:"
Write-Host "   git add .cursor\" -ForegroundColor Yellow
Write-Host "   git commit -m 'feat: Add environment documentation system'" -ForegroundColor Yellow
Write-Host ""
Write-Host "   ⚠️  IMPORTANT: Commit the ENTIRE .cursor\ directory." -ForegroundColor Yellow
Write-Host "   Do NOT add .cursor\ to .gitignore - it's shared team documentation!" -ForegroundColor Yellow
Write-Host ""
Write-Host "📊 Check documentation status anytime:" -ForegroundColor Cyan
Write-Host "   .\.cursor\check-env-docs.ps1" -ForegroundColor Yellow
Write-Host ""
Write-Host "📚 Learn more: https://github.com/u00dxk2/cursor-kooi-env-docs" -ForegroundColor Cyan
Write-Host ""

