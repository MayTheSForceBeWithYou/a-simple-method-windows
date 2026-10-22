# test.ps1 - Test harness for Windows port of A Simple Method
# Builds and runs solutions and listings against ; Expected exit / stdout headers.
# Untouched exercise scaffolds must fail to assemble, link, or match — that is success.

[CmdletBinding()]
param(
    [string]$Lesson = "*",
    [switch]$KeepArtifacts
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$script:PassCount = 0
$script:FailCount = 0
$script:Results = New-Object System.Collections.Generic.List[object]
$script:SolutionPassByLesson = @{}
$script:SolutionFailByLesson = @{}
$script:ScaffoldOkByLesson = @{}
$script:ScaffoldHarnessFailByLesson = @{}
$script:ListingFailures = New-Object System.Collections.Generic.List[object]

. "$PSScriptRoot\build.ps1"

function Get-LessonName {
    param([string]$Path)
    if ($Path -match 'lessons[\\/]([^\\/]+)') {
        return $matches[1]
    }
    return "unknown"
}

function Increment-Map {
    param($Map, [string]$Key)
    if (-not $Map.ContainsKey($Key)) {
        $Map[$Key] = 0
    }
    $Map[$Key]++
}

function Add-Result {
    param(
        [string]$File,
        [string]$Status,
        [string]$Details,
        [string]$Kind
    )
    $row = [PSCustomObject]@{
        File    = $File
        Status  = $Status
        Details = $Details
        Kind    = $Kind
    }
    $script:Results.Add($row)
    $lesson = Get-LessonName $File
    switch ($Kind) {
        "solution" {
            if ($Status -eq "PASS") {
                $script:PassCount++
                Increment-Map $script:SolutionPassByLesson $lesson
            } else {
                $script:FailCount++
                Increment-Map $script:SolutionFailByLesson $lesson
            }
        }
        "listing" {
            if ($Status -eq "PASS") {
                $script:PassCount++
            } else {
                $script:FailCount++
                $script:ListingFailures.Add($row)
            }
        }
        "exercise" {
            if ($Status -eq "SCAFFOLD OK") {
                $script:PassCount++
                Increment-Map $script:ScaffoldOkByLesson $lesson
            } else {
                $script:FailCount++
                Increment-Map $script:ScaffoldHarnessFailByLesson $lesson
            }
        }
    }
}

function Read-TextOrEmpty {
    param([string]$Path)
    if ([string]::IsNullOrWhiteSpace($Path)) {
        throw "Read-TextOrEmpty: Path is empty"
    }
    if (-not (Test-Path -LiteralPath $Path)) {
        return ""
    }
    $raw = Get-Content -LiteralPath $Path -Raw -ErrorAction SilentlyContinue
    if ($null -eq $raw) {
        return ""
    }
    return [string]$raw
}

function Convert-ExpectedText {
    param([string]$Text)
    if ($null -eq $Text) {
        return ""
    }
    $t = [string]$Text
    $t = $t -replace '\\n', "`n"
    $t = $t -replace '\\r', "`r"
    $t = $t -replace '\\t', "`t"
    return $t
}

function Parse-Expected {
    param([string]$AsmPath)
    Test-NonEmptyPath -Value $AsmPath -Name "Parse-Expected AsmPath"

    $content = Read-TextOrEmpty $AsmPath
    $expected = @{
        ExitCode     = $null
        Stdout       = $null
        Stderr       = $null
        Stdin        = $null
        StdoutRegex  = $null
        ExitUnparsed = $null
        HasAny       = $false
    }

    if ($content -match '(?im)^;\s*Expected exit(?: code)?:\s*(\d+)\b') {
        $expected.ExitCode = [int]$matches[1]
        $expected.HasAny = $true
    } elseif ($content -match '(?im)^;\s*exit=(\d+)') {
        $expected.ExitCode = [int]$matches[1]
        $expected.HasAny = $true
    } elseif ($content -match '(?im)^;\s*Expected:\s*".*?"\s*[→-]+\s*exit\s+(\d+)') {
        $expected.ExitCode = [int]$matches[1]
        $expected.HasAny = $true
    } elseif ($content -match '(?im)^;\s*Expected exit(?: code)?:\s*(.+)$') {
        $tail = $matches[1].Trim()
        if ($tail -match '^(\d+)') {
            $expected.ExitCode = [int]$matches[1]
            $expected.HasAny = $true
        } else {
            $expected.ExitUnparsed = $tail
            $expected.HasAny = $true
        }
    }

    $stdoutLine = $null
    if ($content -match '(?im)^;\s*Expected stdout:\s*(.+)$') {
        $stdoutLine = $matches[1].Trim()
    } elseif ($content -match '(?im)^;\s*Expected output:\s*(.+)$') {
        $stdoutLine = $matches[1].Trim()
    } elseif ($content -match '(?im)^;\s*stdout=(.+)$') {
        $stdoutLine = $matches[1].Trim()
    }

    if ($null -ne $stdoutLine) {
        $expected.HasAny = $true
        if ($stdoutLine -match '^\(to stderr\)\s*(.+)$') {
            $expected.Stderr = Convert-ExpectedText $matches[1].Trim()
            $expected.Stdout = ""
        } elseif ($stdoutLine -match '^\(none') {
            $expected.Stdout = ""
        } elseif ($stdoutLine -match '^"(.*)"$') {
            $expected.Stdout = Convert-ExpectedText $matches[1]
        } else {
            $expected.Stdout = Convert-ExpectedText $stdoutLine
        }
    }

    if ($content -match '(?im)^;\s*Expected stdout regex:\s*(.+)$') {
        $expected.StdoutRegex = $matches[1].Trim()
        $expected.HasAny = $true
    }

    if ($content -match '(?im)^;\s*Expected stdin:\s*"(.*)"\s*$') {
        $expected.Stdin = Convert-ExpectedText $matches[1]
        $expected.HasAny = $true
    } elseif ($content -match "(?im)^;\s*Expected exit:\s*65\s*\(when piped 'A'\)") {
        $expected.Stdin = "A"
    }

    return $expected
}

function Compare-Output {
    param(
        $Expected,
        [int]$ExitCode,
        [string]$Stdout,
        [string]$Stderr
    )
    $issues = New-Object System.Collections.Generic.List[string]

    if ($null -ne $Expected.ExitUnparsed) {
        $issues.Add("unparseable expected exit: $($Expected.ExitUnparsed)")
    }

    if ($null -ne $Expected.ExitCode) {
        if ($ExitCode -ne [int]$Expected.ExitCode) {
            $issues.Add("exit code $ExitCode (expected $($Expected.ExitCode))")
        }
    }

    if ($null -ne $Expected.Stdout) {
        $normalizedStdout = ([string]$Stdout) -replace "`r`n", "`n"
        $normalizedExpected = ([string]$Expected.Stdout) -replace "`r`n", "`n"
        if ($normalizedStdout -ne $normalizedExpected) {
            $issues.Add("stdout mismatch")
        }
    }

    if ($null -ne $Expected.Stderr) {
        $normalizedStderr = ([string]$Stderr) -replace "`r`n", "`n"
        $normalizedExpected = ([string]$Expected.Stderr) -replace "`r`n", "`n"
        if ($normalizedStderr -ne $normalizedExpected) {
            $issues.Add("stderr mismatch")
        }
    }

    if ($null -ne $Expected.StdoutRegex) {
        if ($Stdout -notmatch $Expected.StdoutRegex) {
            $issues.Add("stdout does not match regex: $($Expected.StdoutRegex)")
        }
    }

    return $issues
}

function Invoke-BuiltExe {
    param(
        [Parameter(Mandatory = $true)][string]$ExePath,
        [Parameter(Mandatory = $true)][string]$OutDir,
        [Parameter(Mandatory = $true)][string]$Name,
        [string]$StdinText = ""
    )

    Test-NonEmptyPath -Value $ExePath -Name "ExePath"
    Test-NonEmptyPath -Value $OutDir -Name "Invoke-BuiltExe OutDir"
    if (-not (Test-Path -LiteralPath $ExePath)) {
        throw "Executable not found: $ExePath"
    }

    $stdoutFile = Join-Path $OutDir "$Name.stdout.txt"
    $stderrFile = Join-Path $OutDir "$Name.stderr.txt"
    $stdinFile = Join-Path $OutDir "$Name.stdin.txt"
    Test-NonEmptyPath -Value $stdoutFile -Name "stdoutFile"
    Test-NonEmptyPath -Value $stderrFile -Name "stderrFile"
    Test-NonEmptyPath -Value $stdinFile -Name "stdinFile"

    if ($null -eq $StdinText) {
        $StdinText = ""
    }
    [System.IO.File]::WriteAllText($stdinFile, [string]$StdinText)

    $process = Start-Process -FilePath $ExePath -WorkingDirectory $OutDir `
        -NoNewWindow -PassThru `
        -RedirectStandardInput $stdinFile `
        -RedirectStandardOutput $stdoutFile `
        -RedirectStandardError $stderrFile

    if (-not $process.WaitForExit(8000)) {
        try { $process.Kill() } catch { }
        throw "timed out after 8s"
    }

    $exitCode = $process.ExitCode
    $stdout = Read-TextOrEmpty $stdoutFile
    $stderr = Read-TextOrEmpty $stderrFile

    if (-not $KeepArtifacts) {
        Remove-Item -LiteralPath $stdoutFile -ErrorAction SilentlyContinue
        Remove-Item -LiteralPath $stderrFile -ErrorAction SilentlyContinue
        Remove-Item -LiteralPath $stdinFile -ErrorAction SilentlyContinue
    }

    return @{
        ExitCode = $exitCode
        Stdout   = $stdout
        Stderr   = $stderr
    }
}

function Get-RelativeAsmPath {
    param([string]$AsmPath)
    Test-NonEmptyPath -Value $AsmPath -Name "Get-RelativeAsmPath"
    $relativePath = $AsmPath
    if (-not [string]::IsNullOrWhiteSpace($PSScriptRoot)) {
        $relativePath = $AsmPath -replace [regex]::Escape($PSScriptRoot), ""
    }
    return $relativePath.TrimStart("\", "/")
}

function Test-IsPrimaryListing {
    param([Parameter(Mandatory = $true)][string]$AsmPath)

    $base = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    $skipNames = @(
        '05-multifile-helper',
        '14-helper-add',
        '20-add-two-numbers'
    )
    if ($skipNames -contains $base) {
        return $false
    }

    $content = Read-TextOrEmpty $AsmPath
    if ($content -notmatch '(?im)^main\s+PROC') {
        return $false
    }

    return $true
}

function Test-IsScaffoldLinkOrAsmFailure {
    param([string]$Message)
    return ($Message -match '(?i)ml64 failed|LNK20|LNK11|unresolved external|undefined symbol|error A[0-9]{4}:')
}

function Test-RunnableAsm {
    param(
        [string]$AsmPath,
        [string]$OutDir,
        [string]$Kind,
        [switch]$RequireExpected
    )

    $name = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    $relativePath = Get-RelativeAsmPath $AsmPath

    try {
        $built = Build-Asm -AsmPath $AsmPath -OutputDir $OutDir
        if ($built -is [array]) {
            throw "Build-Asm returned multiple values (pipeline pollution): $($built -join ' | ')"
        }
        $exePath = [string]$built
        Test-NonEmptyPath -Value $exePath -Name "Build-Asm return"

        $expected = Parse-Expected -AsmPath $AsmPath
        if ($RequireExpected -and -not $expected.HasAny) {
            Add-Result -File $relativePath -Status "FAIL" -Details "missing Expected exit/stdout header" -Kind $Kind
            return
        }

        $stdinText = ""
        if ($null -ne $expected.Stdin) {
            $stdinText = [string]$expected.Stdin
        }
        $run = Invoke-BuiltExe -ExePath $exePath -OutDir $OutDir -Name $name -StdinText $stdinText
        # Empty List unwraps to $null in PowerShell; wrap so StrictMode can see .Count.
        $issues = @(Compare-Output -Expected $expected -ExitCode $run.ExitCode -Stdout $run.Stdout -Stderr $run.Stderr)

        if ($issues.Count -eq 0) {
            Add-Result -File $relativePath -Status "PASS" -Details "" -Kind $Kind
            if ($VerbosePreference -eq "Continue") {
                Write-Host "PASS: $relativePath" -ForegroundColor Green
            }
        } else {
            $details = $issues -join "; "
            Add-Result -File $relativePath -Status "FAIL" -Details $details -Kind $Kind
            Write-Host "FAIL: $relativePath - $details" -ForegroundColor Red
        }
    } catch {
        Add-Result -File $relativePath -Status "FAIL" -Details $_.Exception.Message -Kind $Kind
        Write-Host "FAIL: $relativePath - $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Test-ExerciseScaffold {
    param(
        [string]$AsmPath,
        [string]$OutDir
    )

    $name = [System.IO.Path]::GetFileNameWithoutExtension($AsmPath)
    $relativePath = Get-RelativeAsmPath $AsmPath

    try {
        $built = Build-Asm -AsmPath $AsmPath -OutputDir $OutDir
        if ($built -is [array]) {
            throw "Build-Asm returned multiple values (pipeline pollution): $($built -join ' | ')"
        }
        $exePath = [string]$built
        Test-NonEmptyPath -Value $exePath -Name "Build-Asm return"

        $expected = Parse-Expected -AsmPath $AsmPath
        $stdinText = ""
        if ($null -ne $expected.Stdin) {
            $stdinText = [string]$expected.Stdin
        }
        # Scaffolds must fail at link/asm time, not build and run.
        $run = Invoke-BuiltExe -ExePath $exePath -OutDir $OutDir -Name $name -StdinText $stdinText
        $issues = @(Compare-Output -Expected $expected -ExitCode $run.ExitCode -Stdout $run.Stdout -Stderr $run.Stderr)
        $why = if ($issues.Count -gt 0) { $issues -join "; " } else { "exit $($run.ExitCode)" }
        if ($issues.Count -eq 0) {
            Add-Result -File $relativePath -Status "HARNESS FAIL" -Details "Exercise scaffold passed as-is (should fail at link)" -Kind "exercise"
            Write-Host "HARNESS FAIL: $relativePath - scaffold passed without modification" -ForegroundColor Magenta
        } else {
            Add-Result -File $relativePath -Status "HARNESS FAIL" -Details "Exercise scaffold linked and ran ($why); expected link/asm failure only" -Kind "exercise"
            Write-Host "HARNESS FAIL: $relativePath - scaffold built ($why)" -ForegroundColor Magenta
        }
    } catch {
        $msg = $_.Exception.Message
        $isLinkOrAsm = ($msg -match '(?i)ml64 failed|LNK20|LNK11|unresolved external|undefined symbol|error A[0-9]{4}:')
        if ($isLinkOrAsm) {
            Add-Result -File $relativePath -Status "SCAFFOLD OK" -Details "Failed as expected ($msg)" -Kind "exercise"
            if ($VerbosePreference -eq "Continue") {
                Write-Host "SCAFFOLD OK: $relativePath (build failed as expected)" -ForegroundColor Green
            }
        } else {
            Add-Result -File $relativePath -Status "HARNESS FAIL" -Details $msg -Kind "exercise"
            Write-Host "HARNESS FAIL: $relativePath - $msg" -ForegroundColor Magenta
        }
    }
}

function Get-LessonDirectories {
    $lessonsRoot = Join-Path $PSScriptRoot "lessons"
    Test-NonEmptyPath -Value $lessonsRoot -Name "lessonsRoot"
    if (-not (Test-Path -LiteralPath $lessonsRoot)) {
        throw "lessons directory not found: $lessonsRoot"
    }
    $dirs = @(Get-ChildItem -LiteralPath $lessonsRoot -Directory)
    if ($Lesson -ne "*") {
        $dirs = @($dirs | Where-Object { $_.Name -like "$Lesson*" -or $_.Name -eq $Lesson })
    }
    return $dirs
}

function Get-AsmFiles {
    param(
        [System.IO.DirectoryInfo]$LessonDir,
        [string]$Subdir
    )
    $dir = Join-Path $LessonDir.FullName $Subdir
    if ([string]::IsNullOrWhiteSpace($dir) -or -not (Test-Path -LiteralPath $dir)) {
        return @()
    }
    return @(Get-ChildItem -LiteralPath $dir -File -Filter "*.asm")
}

Write-Host "=== Windows Port Test Harness ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "Setting up MSVC environment..." -ForegroundColor Cyan
Find-MSVC
Write-Host "Toolchain ready.`n" -ForegroundColor Green

$script:HarnessOutRoot = Join-Path $PSScriptRoot "out"
$script:HarnessOutDirSolutions = Join-Path $script:HarnessOutRoot "solutions"
$script:HarnessOutDirListings = Join-Path $script:HarnessOutRoot "listings"
$script:HarnessOutDirExercises = Join-Path $script:HarnessOutRoot "exercises"
foreach ($d in @($script:HarnessOutRoot, $script:HarnessOutDirSolutions, $script:HarnessOutDirListings, $script:HarnessOutDirExercises)) {
    if (-not (Test-Path -LiteralPath $d)) {
        New-Item -ItemType Directory -Path $d | Out-Null
    }
}

$lessonDirs = Get-LessonDirectories

Write-Host "Testing solutions..." -ForegroundColor Cyan
foreach ($lessonDir in $lessonDirs) {
    foreach ($solution in (Get-AsmFiles -LessonDir $lessonDir -Subdir "solutions")) {
        Test-RunnableAsm -AsmPath $solution.FullName -OutDir $script:HarnessOutDirSolutions -Kind "solution" -RequireExpected
    }
}

Write-Host "`nTesting listings..." -ForegroundColor Cyan
$listingCount = 0
$listingSkipped = 0
$listingSkippedNames = @()
foreach ($lessonDir in $lessonDirs) {
    foreach ($listing in (Get-AsmFiles -LessonDir $lessonDir -Subdir "listings")) {
        if (-not (Test-IsPrimaryListing -AsmPath $listing.FullName)) {
            $listingSkipped++
            $listingSkippedNames += (Get-RelativeAsmPath $listing.FullName)
            continue
        }
        $listingCount++
        Test-RunnableAsm -AsmPath $listing.FullName -OutDir $script:HarnessOutDirListings -Kind "listing" -RequireExpected
    }
}
if ($listingSkipped -gt 0) {
    Write-Host "Skipped $listingSkipped listing(s) (companion / non-main PROC):" -ForegroundColor Yellow
    foreach ($skippedListing in $listingSkippedNames) {
        Write-Host "  $skippedListing" -ForegroundColor Yellow
    }
}
if ($listingCount -eq 0) {
    Write-Host "No listings found" -ForegroundColor Yellow
}

Write-Host "`nVerifying exercise scaffolds fail..." -ForegroundColor Cyan
$exerciseCount = 0
foreach ($lessonDir in $lessonDirs) {
    foreach ($exercise in (Get-AsmFiles -LessonDir $lessonDir -Subdir "exercises")) {
        $exerciseCount++
        Test-ExerciseScaffold -AsmPath $exercise.FullName -OutDir $script:HarnessOutDirExercises
    }
}
if ($exerciseCount -eq 0) {
    Write-Host "No exercises found" -ForegroundColor Yellow
}

Write-Host "`n=== Test Results ===" -ForegroundColor Cyan
$script:Results | Format-Table -Property File, Status, Details -AutoSize | Out-String -Width 240 | Out-Host

Write-Host "`n=== Solution pass counts by lesson ===" -ForegroundColor Cyan
$allLessons = @($script:SolutionPassByLesson.Keys + $script:SolutionFailByLesson.Keys) | Sort-Object -Unique
foreach ($lesson in $allLessons) {
    $p = 0; $f = 0
    if ($script:SolutionPassByLesson.ContainsKey($lesson)) { $p = $script:SolutionPassByLesson[$lesson] }
    if ($script:SolutionFailByLesson.ContainsKey($lesson)) { $f = $script:SolutionFailByLesson[$lesson] }
    Write-Host ("  {0}: pass={1} fail={2}" -f $lesson, $p, $f)
}

Write-Host "`n=== Scaffold-failing counts by lesson ===" -ForegroundColor Cyan
$scaffoldLessons = @($script:ScaffoldOkByLesson.Keys + $script:ScaffoldHarnessFailByLesson.Keys) | Sort-Object -Unique
foreach ($lesson in $scaffoldLessons) {
    $ok = 0; $bad = 0
    if ($script:ScaffoldOkByLesson.ContainsKey($lesson)) { $ok = $script:ScaffoldOkByLesson[$lesson] }
    if ($script:ScaffoldHarnessFailByLesson.ContainsKey($lesson)) { $bad = $script:ScaffoldHarnessFailByLesson[$lesson] }
    Write-Host ("  {0}: scaffold-failing={1} harness-fail={2}" -f $lesson, $ok, $bad)
}

if ($script:ListingFailures.Count -gt 0) {
    Write-Host "`n=== Listing failures ===" -ForegroundColor Red
    foreach ($row in $script:ListingFailures) {
        Write-Host ("  {0}: {1}" -f $row.File, $row.Details)
    }
}

Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "Passed: $script:PassCount" -ForegroundColor Green
Write-Host "Failed: $script:FailCount" -ForegroundColor $(if ($script:FailCount -eq 0) { "Green" } else { "Red" })

if (-not $KeepArtifacts) {
    Write-Host "`nCleaning build artifacts..." -ForegroundColor Cyan
    Get-ChildItem -LiteralPath $script:HarnessOutRoot -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -in ".obj", ".exe", ".pdb", ".ilk", ".txt" } |
        Remove-Item -ErrorAction SilentlyContinue
}

if ($script:FailCount -gt 0) {
    exit 1
} else {
    exit 0
}
