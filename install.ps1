# Safe console title modification
try {
    $Host.UI.RawUI.WindowTitle = "LNTHGLfan2025 RoleMods - PowerShell Installer"
} catch {
    # Non-standard host environment; suppress title modification
}

Write-Host "===================================================" -ForegroundColor Yellow
Write-Host "         LNTHGLfan2025 RoleMods CLI Installer         " -ForegroundColor Yellow
Write-Host "===================================================" -ForegroundColor Yellow
Write-Host ""

# Define Target Paths relative to the script location
$InstallDir = "$env:LOCALAPPDATA\LNTHGLfan2025\RoleModsCLI"
$SourcePath = Join-Path $PSScriptRoot "rolemods.bat"

# Step 1: Verify source file exists relative to this installer script
if (-not (Test-Path $SourcePath)) {
    Write-Host "[Error] Source file 'rolemods.bat' not found in this folder." -ForegroundColor Red
    Write-Host "Expected path: $SourcePath" -ForegroundColor DarkGray
    Write-Host "Please ensure 'rolemods.bat' is in the same directory as this script."
    Write-Host ""
    Read-Host "Press Enter to exit..."
    return
}

# Step 2: Create target directory if it does not exist
Write-Host "[1/4] Creating application directory..." -ForegroundColor DarkGray
if (-not (Test-Path $InstallDir)) {
    try {
        New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    } catch {
        Write-Host "[Error] Failed to create directory: $InstallDir" -ForegroundColor Red
        Read-Host "Press Enter to exit..."
        return
    }
}
Start-Sleep -Seconds 1

# Step 3: Copy main CLI file to local app data
Write-Host "[2/4] Copying files to destination..." -ForegroundColor DarkGray
try {
    Copy-Item -Path $SourcePath -Destination $InstallDir -Force
} catch {
    Write-Host "[Error] Failed to copy files to target directory." -ForegroundColor Red
    Read-Host "Press Enter to exit..."
    return
}
Start-Sleep -Seconds 1

# Step 4: Register PATH environment variable safely for the user environment
Write-Host "[3/4] Adding command to user PATH..." -ForegroundColor DarkGray
$UserPath = [Environment]::GetEnvironmentVariable("PATH", "User")

if ([string]::IsNullOrEmpty($UserPath)) {
    [Environment]::SetEnvironmentVariable("PATH", $InstallDir, "User")
} elseif ($UserPath -notlike "*LNTHGLfan2025\RoleModsCLI*") {
    [Environment]::SetEnvironmentVariable("PATH", "$UserPath;$InstallDir", "User")
}
Start-Sleep -Seconds 1

# Step 5: Create Desktop Shortcut using Windows Script Host COM object
Write-Host "[4/4] Creating desktop shortcut..." -ForegroundColor DarkGray
try {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\LNTHGLfan2025 RoleMods.lnk")
    $Shortcut.TargetPath = Join-Path $InstallDir "rolemods.bat"
    $Shortcut.WorkingDirectory = $InstallDir
    $Shortcut.Save()
} catch {
    Write-Host "[Warning] Could not create desktop shortcut automatically." -ForegroundColor Yellow
}
Start-Sleep -Seconds 1

Write-Host ""
Write-Host "[Success] Installation completed successfully." -ForegroundColor Green
Write-Host ""
Write-Host "You can now run the tool by double-clicking the desktop shortcut,"
Write-Host "or by opening a new Command Prompt / PowerShell window and typing:"
Write-Host "  rolemods" -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to exit..."