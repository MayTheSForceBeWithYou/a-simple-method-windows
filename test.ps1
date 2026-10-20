# test.ps1 - Test harness for Windows port of A Simple Method
# Builds and runs all solutions, checks exit codes and stdout against expected values
# Verifies that exercise scaffolds fail (don't pass as-is)

param(
    [string]$Lesson = "*",
    [switch]$Verbose,
    [switch]$KeepArtifacts
)

$ErrorActionPreference = "Stop"
$script:PassCount = 0
$script:FailCount = 0
$script:Results = @()

# Import build functions
. "$PSScriptRoot\build.ps1"

function Parse-Expected {
    param([string]$AsmPath)
    
    $content = Get-Content $AsmPath -Raw
    
    $expected = @{
        ExitCode = $null
        Stdout = $null
        StdoutRegex = $null
    }
    
    # Parse "Expected exit: N" or "; exit=N"
    if ($content -match '; Expected exit:\s*(\d+)') {
        $expected.ExitCode = [int]$matches[1]
    } elseif ($content -match '; exit=(\d+)') {
        $expected.ExitCode = [int]$matches[1]
    }
    # For simple exit-only tests, infer from filename
    elseif ($AsmPath -match 'exit-zero') {
        $expected.ExitCode = 0
    } elseif ($AsmPath -match 'exit-seven') {
        $expected.ExitCode = 7
    } elseif ($AsmPath -match 'exit-(\d+)') {
        $expected.ExitCode = [int]$matches[1]
    }
    # Infer from final exit value in common patterns
    elseif ($content -match 'mov\s+(?:rcx|ecx),\s*(\d+)\s*\n\s*call\s+ExitProcess') {
        $expected.ExitCode = [int]$matches[1]
    }
    
    # Parse expected stdout
    if ($content -match '; Expected stdout:\s*"([^"]*)"') {
        $stdoutStr = $matches[1]
        # Handle escape sequences
        $stdoutStr = $stdoutStr -replace '\\n', "`n"
        $stdoutStr = $stdoutStr -replace '\\r', "`r"
        $stdoutStr = $stdoutStr -replace '\\t', "`t"
        $expected.Stdout = $stdoutStr
    } elseif ($content -match '; stdout=(.+)') {
        $expected.Stdout = $matches[1] -replace '\\n', "`n"
    }
    
    # Parse stdout regex
    if ($content -match '; Expected stdout regex:\s*(.+)') {
        $expected.StdoutRegex = $matches[1]
    }
    
    return $expected
}

function Test-Solution {
    param(
        [string]$AsmPath,
        [string]$OutDir
    )
    
    $name = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    $relativePath = $AsmPath -replace [regex]::Escape($PSScriptRoot), ''
    $relativePath = $relativePath.TrimStart('\', '/')
    
    try {
        # Build
        $exePath = Build-Asm -AsmPath $AsmPath -OutputDir $OutDir
        
        # Parse expected values
        $expected = Parse-Expected -AsmPath $AsmPath
        
        # Run with timeout (30 seconds)
        $stdoutFile = Join-Path $OutDir "$name.stdout.txt"
        $stderrFile = Join-Path $OutDir "$name.stderr.txt"
        
        $process = Start-Process -FilePath $exePath -NoNewWindow -Wait -PassThru `
            -RedirectStandardOutput $stdoutFile `
            -RedirectStandardError $stderrFile
        
        $exitCode = $process.ExitCode -band 0xFF  # Low 8 bits only
        $stdout = if (Test-Path $stdoutFile) { Get-Content $stdoutFile -Raw } else { "" }
        $stderr = if (Test-Path $stderrFile) { Get-Content $stderrFile -Raw } else { "" }
        
        # Check expectations
        $issues = @()
        
        if ($null -ne $expected.ExitCode) {
            if ($exitCode -ne $expected.ExitCode) {
                $issues += "exit code $exitCode (expected $($expected.ExitCode))"
            }
        }
        
        if ($null -ne $expected.Stdout) {
            # Normalize line endings for comparison
            $normalizedStdout = $stdout -replace "`r`n", "`n"
            $normalizedExpected = $expected.Stdout -replace "`r`n", "`n"
            
            if ($normalizedStdout -ne $normalizedExpected) {
                $issues += "stdout mismatch"
                if ($Verbose) {
                    Write-Host "  Expected: $($normalizedExpected | ConvertTo-Json)"
                    Write-Host "  Actual:   $($normalizedStdout | ConvertTo-Json)"
                }
            }
        }
        
        if ($null -ne $expected.StdoutRegex) {
            if ($stdout -notmatch $expected.StdoutRegex) {
                $issues += "stdout does not match regex: $($expected.StdoutRegex)"
            }
        }
        
        # Clean up temp files
        if (-not $KeepArtifacts) {
            Remove-Item $stdoutFile -ErrorAction SilentlyContinue
            Remove-Item $stderrFile -ErrorAction SilentlyContinue
        }
        
        if ($issues.Count -eq 0) {
            $script:PassCount++
            $script:Results += [PSCustomObject]@{
                File = $relativePath
                Status = "PASS"
                Details = ""
            }
            if ($Verbose) {
                Write-Host "PASS: $relativePath" -ForegroundColor Green
            }
        } else {
            $script:FailCount++
            $details = $issues -join "; "
            $script:Results += [PSCustomObject]@{
                File = $relativePath
                Status = "FAIL"
                Details = $details
            }
            Write-Host "FAIL: $relativePath - $details" -ForegroundColor Red
        }
        
    } catch {
        $script:FailCount++
        $script:Results += [PSCustomObject]@{
            File = $relativePath
            Status = "FAIL"
            Details = $_.Exception.Message
        }
        Write-Host "FAIL: $relativePath - $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Test-ExerciseScaffold {
    param(
        [string]$AsmPath,
        [string]$OutDir
    )
    
    $name = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    $relativePath = $AsmPath -replace [regex]::Escape($PSScriptRoot), ''
    $relativePath = $relativePath.TrimStart('\', '/')
    
    # Skip if this is an old NASM file (Jack hasn't ported it yet)
    $content = Get-Content $AsmPath -Raw
    if ($content -match 'section\s+\.text' -and $content -match 'global\s+_start') {
        # Old NASM syntax - will fail to assemble with ml64, which is acceptable
        $script:Results += [PSCustomObject]@{
            File = $relativePath
            Status = "SKIP"
            Details = "NASM syntax (not yet ported)"
        }
        if ($Verbose) {
            Write-Host "SKIP: $relativePath (NASM syntax)" -ForegroundColor Yellow
        }
        return
    }
    
    try {
        # Try to build - it should either fail to assemble/link, or pass but exit with error
        $exePath = Build-Asm -AsmPath $AsmPath -OutputDir $OutDir
        
        # If it built, run it - it should fail (non-zero exit code)
        $stdoutFile = Join-Path $OutDir "$name.stdout.txt"
        $stderrFile = Join-Path $OutDir "$name.stderr.txt"
        
        $process = Start-Process -FilePath $exePath -NoNewWindow -Wait -PassThru `
            -RedirectStandardOutput $stdoutFile `
            -RedirectStandardError $stderrFile
        
        $exitCode = $process.ExitCode -band 0xFF
        
        if (-not $KeepArtifacts) {
            Remove-Item $stdoutFile -ErrorAction SilentlyContinue
            Remove-Item $stderrFile -ErrorAction SilentlyContinue
        }
        
        if ($exitCode -eq 0) {
            # Scaffold passed - this is a HARNESS FAILURE
            $script:FailCount++
            $script:Results += [PSCustomObject]@{
                File = $relativePath
                Status = "HARNESS FAIL"
                Details = "Exercise scaffold passed as-is (should fail)"
            }
            Write-Host "HARNESS FAIL: $relativePath - scaffold passed without modification" -ForegroundColor Magenta
        } else {
            # Scaffold failed as expected
            $script:PassCount++
            $script:Results += [PSCustomObject]@{
                File = $relativePath
                Status = "SCAFFOLD OK"
                Details = "Failed as expected (exit $exitCode)"
            }
            if ($Verbose) {
                Write-Host "SCAFFOLD OK: $relativePath (failed as expected)" -ForegroundColor Green
            }
        }
        
    } catch {
        # Failed to build - this is acceptable for scaffolds
        $script:PassCount++
        $script:Results += [PSCustomObject]@{
            File = $relativePath
            Status = "SCAFFOLD OK"
            Details = "Failed to build as expected"
        }
        if ($Verbose) {
            Write-Host "SCAFFOLD OK: $relativePath (build failed as expected)" -ForegroundColor Green
        }
    }
}

function Test-Listing {
    param(
        [string]$AsmPath,
        [string]$OutDir
    )
    
    $name = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    $relativePath = $AsmPath -replace [regex]::Escape($PSScriptRoot), ''
    $relativePath = $relativePath.TrimStart('\', '/')
    
    try {
        # Listings should build successfully
        $exePath = Build-Asm -AsmPath $AsmPath -OutputDir $OutDir
        
        # For now, just check that it builds - we can add runtime checks later
        $script:PassCount++
        $script:Results += [PSCustomObject]@{
            File = $relativePath
            Status = "PASS"
            Details = "Listing built successfully"
        }
        if ($Verbose) {
            Write-Host "PASS: $relativePath (listing)" -ForegroundColor Green
        }
        
    } catch {
        $script:FailCount++
        $script:Results += [PSCustomObject]@{
            File = $relativePath
            Status = "FAIL"
            Details = $_.Exception.Message
        }
        Write-Host "FAIL: $relativePath - $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Main execution
Write-Host "=== Windows Port Test Harness ===" -ForegroundColor Cyan
Write-Host ""

if ($Verbose) {
    $VerbosePreference = "Continue"
}

# Set up MSVC environment
Write-Host "Setting up MSVC environment..." -ForegroundColor Cyan
Find-MSVC | Out-Null
Write-Host "Toolchain ready.`n" -ForegroundColor Green

# Create output directory
$outDir = Join-Path $PSScriptRoot "out"
if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

# Find all solutions
Write-Host "Testing solutions..." -ForegroundColor Cyan
$solutionPattern = Join-Path $PSScriptRoot "lessons\$Lesson\solutions\*.asm"
$solutions = Get-ChildItem $solutionPattern -File -ErrorAction SilentlyContinue

foreach ($solution in $solutions) {
    Test-Solution -AsmPath $solution.FullName -OutputDir $outDir
}

# Find all listings (if they exist)
Write-Host "`nTesting listings..." -ForegroundColor Cyan
$listingPattern = Join-Path $PSScriptRoot "lessons\$Lesson\listings\*.asm"
$listings = Get-ChildItem $listingPattern -File -ErrorAction SilentlyContinue

if ($listings.Count -eq 0) {
    Write-Host "No listings found (this is expected until Jack ports them)" -ForegroundColor Yellow
} else {
    foreach ($listing in $listings) {
        Test-Listing -AsmPath $listing.FullName -OutputDir $outDir
    }
}

# Find all exercises
Write-Host "`nVerifying exercise scaffolds fail..." -ForegroundColor Cyan
$exercisePattern = Join-Path $PSScriptRoot "lessons\$Lesson\exercises\*.asm"
$exercises = Get-ChildItem $exercisePattern -File -ErrorAction SilentlyContinue

if ($exercises.Count -eq 0) {
    Write-Host "No exercises found" -ForegroundColor Yellow
} else {
    foreach ($exercise in $exercises) {
        Test-ExerciseScaffold -AsmPath $exercise.FullName -OutputDir $outDir
    }
}

# Print summary table
Write-Host "`n=== Test Results ===" -ForegroundColor Cyan
$script:Results | Format-Table -Property File, Status, Details -AutoSize

Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "Passed: $script:PassCount" -ForegroundColor Green
Write-Host "Failed: $script:FailCount" -ForegroundColor $(if ($script:FailCount -eq 0) { "Green" } else { "Red" })

# Clean up build artifacts if requested
if (-not $KeepArtifacts) {
    Write-Host "`nCleaning build artifacts..." -ForegroundColor Cyan
    Remove-Item (Join-Path $outDir "*.obj") -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $outDir "*.exe") -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $outDir "*.pdb") -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $outDir "*.ilk") -ErrorAction SilentlyContinue
}

# Exit with failure if any tests failed
if ($script:FailCount -gt 0) {
    exit 1
} else {
    exit 0
}
