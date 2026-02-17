#Requires -RunAsAdministrator
# dotfiles install script
# Creates symbolic links from dotfiles to their expected locations.
# Run: powershell -ExecutionPolicy Bypass -File install.ps1

$DotfilesDir = $PSScriptRoot

$links = @{
    # source (dotfiles)          => target (system location)
    "$DotfilesDir\nvim"          = "$env:LOCALAPPDATA\nvim"
    "$DotfilesDir\wezterm"       = "$HOME\.config\wezterm"
    "$DotfilesDir\yazi"          = "$env:APPDATA\yazi\config"
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

# Set YAZI_FILE_ONE environment variable (required for MIME type detection on Windows)
$fileExe = "C:\Program Files\Git\usr\bin\file.exe"
if (Test-Path $fileExe) {
    $current = [Environment]::GetEnvironmentVariable("YAZI_FILE_ONE", "User")
    if ($current -ne $fileExe) {
        [Environment]::SetEnvironmentVariable("YAZI_FILE_ONE", $fileExe, "User")
        Write-Host "[ok]   YAZI_FILE_ONE = $fileExe" -ForegroundColor Green
    } else {
        Write-Host "[skip] YAZI_FILE_ONE (already set)" -ForegroundColor Yellow
    }
} else {
    Write-Host "[warn] file.exe not found at $fileExe — set YAZI_FILE_ONE manually" -ForegroundColor Red
}

Write-Host "`nDone!" -ForegroundColor Cyan
