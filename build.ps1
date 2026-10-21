# build.ps1 - Windows build harness for A Simple Method
# Finds ml64/link via vswhere (or PATH), builds .asm files to an output directory.
# When dot-sourced, only functions are defined — no param() block, so caller
# variables such as $OutDir are not overwritten.

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Test-NonEmptyPath {
    param(
        [string]$Value,
        [string]$Name
    )
    if ([string]::IsNullOrWhiteSpace($Value)) {
        throw "$Name is an empty path"
    }
}

function Read-NativeLog {
    param([string]$Path)
    if ([string]::IsNullOrWhiteSpace($Path) -or -not (Test-Path -LiteralPath $Path)) {
        return ""
    }
    $raw = Get-Content -LiteralPath $Path -Raw -ErrorAction SilentlyContinue
    if ($null -eq $raw) {
        return ""
    }
    return [string]$raw
}

function Find-MSVC {
    $ml64 = Get-Command ml64.exe -ErrorAction SilentlyContinue
    $link = Get-Command link.exe -ErrorAction SilentlyContinue
    if ($ml64 -and $link) {
        Write-Host "Using ml64 and link from PATH"
        return
    }

    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    if (-not (Test-Path -LiteralPath $vswhere)) {
        throw "Visual Studio not found. Please run from 'x64 Native Tools Command Prompt' or install Visual Studio with C++ tools."
    }

    $vsPath = & $vswhere -latest -products * `
        -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
        -property installationPath 2>$null
    if ([string]::IsNullOrWhiteSpace($vsPath)) {
        throw "Visual Studio installation not found with required C++ tools"
    }

    $vcvarsPath = Join-Path $vsPath "Common7\Tools\VsDevCmd.bat"
    if (-not (Test-Path -LiteralPath $vcvarsPath)) {
        throw "VsDevCmd.bat not found at $vcvarsPath"
    }

    Write-Host "Found Visual Studio at: $vsPath"
    Write-Host "Setting up environment from VsDevCmd.bat..."

    $tempFile = [System.IO.Path]::GetTempFileName()
    try {
        cmd /c "`"$vcvarsPath`" -arch=x64 && set" > $tempFile
        Get-Content -LiteralPath $tempFile | ForEach-Object {
            if ($_ -match "^(.*?)=(.*)$") {
                Set-Item -Path "env:$($matches[1])" -Value $matches[2] | Out-Null
            }
        }
    } finally {
        Remove-Item -LiteralPath $tempFile -ErrorAction SilentlyContinue
    }

    $ml64 = Get-Command ml64.exe -ErrorAction SilentlyContinue
    $link = Get-Command link.exe -ErrorAction SilentlyContinue
    if (-not $ml64 -or -not $link) {
        throw "ml64.exe or link.exe not found after setting up environment"
    }

    Write-Host "ml64: $($ml64.Source)"
    Write-Host "link: $($link.Source)"
}

function Invoke-NativeTool {
    param(
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$Label,
        [Parameter(Mandatory = $true)][string]$WorkDir
    )

    Test-NonEmptyPath -Value $FilePath -Name $Label
    Test-NonEmptyPath -Value $WorkDir -Name "WorkDir"

    $resolved = $FilePath
    $cmd = Get-Command $FilePath -ErrorAction SilentlyContinue
    if ($cmd -and -not [string]::IsNullOrWhiteSpace($cmd.Source)) {
        $resolved = [string]$cmd.Source
    }

    $stdoutFile = Join-Path $WorkDir "_$Label.stdout.txt"
    $stderrFile = Join-Path $WorkDir "_$Label.stderr.txt"
    Test-NonEmptyPath -Value $stdoutFile -Name "native stdout"
    Test-NonEmptyPath -Value $stderrFile -Name "native stderr"

    $process = Start-Process -FilePath $resolved -ArgumentList $Arguments `
        -WorkingDirectory $WorkDir -NoNewWindow -Wait -PassThru `
        -RedirectStandardOutput $stdoutFile `
        -RedirectStandardError $stderrFile

    $text = ((Read-NativeLog $stdoutFile) + "`n" + (Read-NativeLog $stderrFile)).Trim()
    if (-not [string]::IsNullOrWhiteSpace($text)) {
        [void]($text | Out-Host)
    }

    Remove-Item -LiteralPath $stdoutFile -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $stderrFile -ErrorAction SilentlyContinue

    return @{
        Code   = [int]$process.ExitCode
        Output = $text
    }
}

function Build-Asm {
    param(
        [Parameter(Mandatory = $true)][string]$AsmPath,
        [Parameter(Mandatory = $true)][string]$OutputDir
    )

    Test-NonEmptyPath -Value $AsmPath -Name "AsmPath"
    Test-NonEmptyPath -Value $OutputDir -Name "OutputDir"

    if (-not (Test-Path -LiteralPath $AsmPath)) {
        throw "Source file not found: $AsmPath"
    }

    $name = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    if ([string]::IsNullOrWhiteSpace($name)) {
        throw "Could not derive object name from $AsmPath"
    }

    if (-not (Test-Path -LiteralPath $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir | Out-Null
    }

    $objName = "$name.obj"
    $exeName = "$name.exe"
    $objPath = Join-Path $OutputDir $objName
    $exePath = Join-Path $OutputDir $exeName
    Test-NonEmptyPath -Value $objPath -Name "objPath"
    Test-NonEmptyPath -Value $exePath -Name "exePath"

    # /Fo must be a bare filename. /FoD:\... is parsed as option FoD plus a drive path.
    $mlArgs = @("/c", "/nologo", "/Zi", "/Fo$objName", $AsmPath)
    Write-Host "ml64 $($mlArgs -join ' ')"
    $ml = Invoke-NativeTool -FilePath "ml64.exe" -Arguments $mlArgs -Label "ml64" -WorkDir $OutputDir
    if ($ml.Code -ne 0) {
        throw "ml64 failed for $AsmPath (exit code $($ml.Code)): $($ml.Output)"
    }
    if (-not (Test-Path -LiteralPath $objPath)) {
        throw "ml64 reported success but did not create $objPath : $($ml.Output)"
    }

    $linkArgs = @(
        "/nologo",
        "/OUT:$exeName",
        "/ENTRY:main",
        "/SUBSYSTEM:CONSOLE",
        "/DEBUG",
        $objName,
        "kernel32.lib"
    )
    Write-Host "link $($linkArgs -join ' ')"
    $link = Invoke-NativeTool -FilePath "link.exe" -Arguments $linkArgs -Label "link" -WorkDir $OutputDir
    if ($link.Code -ne 0) {
        throw "link failed for $name (exit code $($link.Code)): $($link.Output)"
    }
    if ([string]::IsNullOrWhiteSpace($exePath)) {
        throw "Build-Asm produced an empty exe path for $AsmPath"
    }
    if (-not (Test-Path -LiteralPath $exePath)) {
        throw "link reported success but did not create $exePath : $($link.Output)"
    }

    return [string]$exePath
}

if ($MyInvocation.InvocationName -ne '.') {
    $cliFile = $null
    $cliOutDir = "out"
    for ($i = 0; $i -lt $args.Count; $i++) {
        switch -Regex ($args[$i]) {
            '^-File$' { $cliFile = $args[$i + 1]; $i++; continue }
            '^-OutDir$' { $cliOutDir = $args[$i + 1]; $i++; continue }
            '^-Verbose$' { $VerbosePreference = "Continue"; continue }
        }
    }

    Find-MSVC
    if ($cliFile) {
        $built = Build-Asm -AsmPath $cliFile -OutputDir $cliOutDir
        Write-Host "Built: $built"
    } else {
        Write-Host "Usage: .\build.ps1 -File <path-to-asm> [-OutDir <directory>] [-Verbose]"
        Write-Host "Example: .\build.ps1 -File lessons\00-tools-registers-mov-syscall\solutions\01-exit-zero.asm"
    }
}
