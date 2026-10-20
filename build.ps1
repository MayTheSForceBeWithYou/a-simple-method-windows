# build.ps1 - Windows build harness for A Simple Method
# Finds ml64/link via vswhere, builds .asm files to out/ directory

param(
    [string]$File,
    [string]$OutDir = "out",
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

function Find-MSVC {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    
    if (-not (Test-Path $vswhere)) {
        # Try to find ml64/link in PATH (already in VS command prompt)
        $ml64 = Get-Command ml64.exe -ErrorAction SilentlyContinue
        $link = Get-Command link.exe -ErrorAction SilentlyContinue
        
        if ($ml64 -and $link) {
            if ($Verbose) {
                Write-Host "Using ml64 and link from PATH"
            }
            return $true
        }
        
        throw "Visual Studio not found. Please run from 'x64 Native Tools Command Prompt' or install Visual Studio with C++ tools."
    }
    
    $vsPath = & $vswhere -latest -products * `
        -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
        -property installationPath 2>$null
    
    if (-not $vsPath) {
        throw "Visual Studio installation not found with required C++ tools"
    }
    
    $vcvarsPath = "$vsPath\Common7\Tools\VsDevCmd.bat"
    if (-not (Test-Path $vcvarsPath)) {
        throw "VsDevCmd.bat not found at $vcvarsPath"
    }
    
    if ($Verbose) {
        Write-Host "Found Visual Studio at: $vsPath"
        Write-Host "Setting up environment from VsDevCmd.bat..."
    }
    
    # Source VsDevCmd.bat to set environment variables
    $tempFile = [System.IO.Path]::GetTempFileName()
    cmd /c "`"$vcvarsPath`" -arch=x64 && set" > $tempFile
    
    Get-Content $tempFile | ForEach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            $name = $matches[1]
            $value = $matches[2]
            Set-Item "env:\$name" $value
        }
    }
    
    Remove-Item $tempFile
    
    # Verify ml64 and link are now available
    $ml64 = Get-Command ml64.exe -ErrorAction SilentlyContinue
    $link = Get-Command link.exe -ErrorAction SilentlyContinue
    
    if (-not $ml64 -or -not $link) {
        throw "ml64.exe or link.exe not found after setting up environment"
    }
    
    if ($Verbose) {
        Write-Host "ml64: $($ml64.Source)"
        Write-Host "link: $($link.Source)"
    }
    
    return $true
}

function Build-Asm {
    param(
        [string]$AsmPath,
        [string]$OutputDir
    )
    
    $name = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    $dir = Split-Path -Parent $AsmPath
    
    if (-not (Test-Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir | Out-Null
    }
    
    $objPath = Join-Path $OutputDir "$name.obj"
    $exePath = Join-Path $OutputDir "$name.exe"
    
    # Assemble
    $mlArgs = @("/c", "/nologo", "/Zi", $AsmPath, "/Fo:$objPath")
    if ($Verbose) {
        Write-Host "ml64 $($mlArgs -join ' ')"
    }
    
    & ml64.exe $mlArgs 2>&1 | Out-String | Write-Verbose
    if ($LASTEXITCODE -ne 0) {
        throw "ml64 failed for $AsmPath (exit code $LASTEXITCODE)"
    }
    
    # Link
    $linkArgs = @(
        "/nologo",
        "/OUT:$exePath",
        "/ENTRY:main",
        "/SUBSYSTEM:CONSOLE",
        "/DEBUG",
        $objPath,
        "kernel32.lib"
    )
    
    if ($Verbose) {
        Write-Host "link $($linkArgs -join ' ')"
    }
    
    & link.exe $linkArgs 2>&1 | Out-String | Write-Verbose
    if ($LASTEXITCODE -ne 0) {
        throw "link failed for $name (exit code $LASTEXITCODE)"
    }
    
    return $exePath
}

# Main execution
if ($Verbose) {
    $VerbosePreference = "Continue"
}

Find-MSVC | Out-Null

if ($File) {
    $exePath = Build-Asm -AsmPath $File -OutputDir $OutDir
    Write-Host "Built: $exePath"
} else {
    Write-Host "Usage: .\build.ps1 -File <path-to-asm> [-OutDir <directory>] [-Verbose]"
    Write-Host "Example: .\build.ps1 -File lessons\00-tools-registers-mov-syscall\solutions\01-exit-zero.asm"
}
