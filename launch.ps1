# launch.ps1 - Bootstrap script for remote execution
$repo = "cmendez1-dev/Stanford-ization"
$branch = "main"
$installDir = Join-Path $env:TEMP "OneClickInstall"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  OneClickInstall - Downloading...          " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Clean previous download
if (Test-Path $installDir) { Remove-Item $installDir -Recurse -Force }

# Download repo as ZIP
$zipUrl = "https://github.com/$repo/archive/refs/heads/$branch.zip"
$zipFile = Join-Path $env:TEMP "OneClickInstall.zip"

Write-Host "Downloading from GitHub..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile -UseBasicParsing

# Extract
Write-Host "Extracting..." -ForegroundColor Yellow
Expand-Archive -Path $zipFile -DestinationPath $installDir -Force
Remove-Item $zipFile -Force

# Find the extracted folder (GitHub adds branch name to folder)
$extractedFolder = Get-ChildItem -Path $installDir -Directory | Select-Object -First 1

# Run the main script
Write-Host "Launching OneClickInstall..." -ForegroundColor Green
Set-Location $extractedFolder.FullName
& ".\OneClickInstall.ps1"
