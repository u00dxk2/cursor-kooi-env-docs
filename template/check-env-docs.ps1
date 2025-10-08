# Check Environment Documentation Staleness
# Run this script to see if .cursor/project-environment.mdc needs review

$envDocPath = ".cursor/project-environment.mdc"
$warningDays = 7
$criticalDays = 14

if (-not (Test-Path $envDocPath)) {
    Write-Host "ERROR: Environment documentation not found at $envDocPath" -ForegroundColor Red
    Write-Host "Consider creating it using the prompt in .cursor/quick-prompt.txt" -ForegroundColor Yellow
    exit 1
}

# Read the file and extract the Last Updated date
$content = Get-Content $envDocPath -Raw
if ($content -match '>\s*\*\*Last Updated:\*\*\s*(\d{4}-\d{2}-\d{2})') {
    $lastUpdatedStr = $matches[1]
    $lastUpdated = [DateTime]::Parse($lastUpdatedStr)
    $today = Get-Date
    $daysSince = ($today - $lastUpdated).Days
    
    Write-Host "`n[Environment Documentation Status]" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Last Updated: $lastUpdatedStr ($daysSince days ago)"
    
    if ($daysSince -ge $criticalDays) {
        Write-Host "Status: CRITICAL - Review needed immediately!" -ForegroundColor Red
        Write-Host "`nThe documentation is significantly out of date." -ForegroundColor Red
        Write-Host "Ask your AI assistant to review and update it." -ForegroundColor Yellow
    }
    elseif ($daysSince -ge $warningDays) {
        Write-Host "Status: WARNING - Review recommended" -ForegroundColor Yellow
        Write-Host "`nThe documentation may be out of date." -ForegroundColor Yellow
        Write-Host "Consider asking your AI assistant to review it." -ForegroundColor Yellow
    }
    else {
        Write-Host "Status: CURRENT - No action needed" -ForegroundColor Green
        Write-Host "`nThe documentation is up to date." -ForegroundColor Green
    }
    
    Write-Host "========================================`n" -ForegroundColor Cyan
}
else {
    Write-Host "WARNING: Could not find 'Last Updated' date in the document" -ForegroundColor Yellow
    Write-Host "The document may need to be reformatted." -ForegroundColor Yellow
}

