# Cursor Environment Docs System - Installer (Windows)
# https://github.com/u00dxk2/cursor-kooi-env-docs

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

# Check if files already exist
if (Test-Path ".cursor\project-environment.md") {
    Write-Host "⚠️  .cursor\project-environment.md already exists" -ForegroundColor Yellow
    $overwrite = Read-Host "Overwrite? (y/n)"
    if ($overwrite -ne "y") {
        Write-Host "Skipping overwrite. Installation cancelled."
        exit 1
    }
}

# Download template files
Write-Host "📥 Downloading template files..." -ForegroundColor Cyan

function Download-File {
    param($url, $dest)
    $filename = Split-Path $dest -Leaf
    
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -ErrorAction Stop
        Write-Host "  ✓ $filename" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "  ⚠ Failed to download $filename" -ForegroundColor Yellow
        return $false
    }
}

$null = Download-File "$baseUrl/quick-prompt.txt" ".cursor\quick-prompt.txt"
$null = Download-File "$baseUrl/rules/environment-maintenance.mdc" ".cursor\rules\environment-maintenance.mdc"
$null = Download-File "$baseUrl/check-env-docs.ps1" ".cursor\check-env-docs.ps1"
$null = Download-File "$baseUrl/README.md" ".cursor\README.md"
$null = Download-File "$baseUrl/validate-install.ps1" ".cursor\validate-install.ps1"

Write-Host "`n✅ Installation complete!" -ForegroundColor Green
Write-Host "`n📝 Next steps:" -ForegroundColor Cyan
Write-Host "1. Verify installation (optional):"
Write-Host "   .\.cursor\validate-install.ps1" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. View the quick prompt:"
Write-Host "   Get-Content .cursor\quick-prompt.txt" -ForegroundColor Yellow
Write-Host ""
Write-Host "3. Open this project with Cursor"
Write-Host "4. Ask Cursor to create .cursor\project-environment.md using the prompt"
Write-Host "5. Commit the files:"
Write-Host "   git add .cursor\" -ForegroundColor Yellow
Write-Host "   git commit -m 'feat: Add environment documentation system'" -ForegroundColor Yellow
Write-Host ""
Write-Host "📊 Check documentation status anytime:" -ForegroundColor Cyan
Write-Host "   .\.cursor\check-env-docs.ps1" -ForegroundColor Yellow
Write-Host ""
Write-Host "📚 Learn more: https://github.com/u00dxk2/cursor-kooi-env-docs" -ForegroundColor Cyan
Write-Host ""

