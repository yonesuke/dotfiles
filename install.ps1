#Requires -RunAsAdministrator
# dotfiles install script
# Creates symbolic links from dotfiles to their expected locations.
# Run: powershell -ExecutionPolicy Bypass -File install.ps1

$DotfilesDir = $PSScriptRoot

$links = @{
    # source (dotfiles)          => target (system location)
    "$DotfilesDir\nvim"          = "$env:LOCALAPPDATA\nvim"
}

foreach ($src in $links.Keys) {
    $dest = $links[$src]

    if (Test-Path $dest) {
        $item = Get-Item $dest -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            Write-Host "[skip] $dest (symlink already exists)" -ForegroundColor Yellow
            continue
        }
        Write-Host "[warn] $dest already exists and is not a symlink. Back it up manually." -ForegroundColor Red
        continue
    }

    $parentDir = Split-Path $dest -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    New-Item -ItemType SymbolicLink -Path $dest -Target $src | Out-Null
    Write-Host "[ok]   $dest -> $src" -ForegroundColor Green
}

# Install scoop packages from scoopfile.json
$scoopfile = Join-Path $DotfilesDir "scoopfile.json"
if (Test-Path $scoopfile) {
    Write-Host "`nInstalling Scoop packages..." -ForegroundColor Cyan
    scoop import $scoopfile
}

Write-Host "`nDone!" -ForegroundColor Cyan
