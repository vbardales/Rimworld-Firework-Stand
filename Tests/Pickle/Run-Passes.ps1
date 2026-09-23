<#
.SYNOPSIS
  Plays the passes Firework Stand needs, one after the other, and keeps each report before anything else can
  overwrite it.

.DESCRIPTION
  Three passes: English, French, and English without Ideology (the DLC is left out of the staged set by
  wsl-deps.sans-ideology.map). Each goes through scripts/Run-PickleWsl.ps1, the only door: it takes a ticket
  in the queue, then the machine lock, stages, launches under Xvfb and gives the lock back. This script
  launches nothing itself and touches no game.

  WHY IT EXISTS. The launcher archives the previous report at the next launch and keeps only the newest few,
  and a session that waits hours in the queue is not there when its turn comes. The first English run of this
  suite (2026-09-21) finished, then lost its report before anyone read it. So this waits for each pass and, as
  soon as the launcher returns, keeps what the run wrote.

  WHERE THINGS GO. The rule is: evidence stays on disk and out of git, a text summary goes in git.
    Tests/Pickle/runs/<date>-<pass>/   the evidence: summary, junit, log, messages, this suite's films and
                                       stills. Ignored by git (.gitignore), never committed.
    docs/runs/<date>-<pass>.md         a text summary of the run: counts, exitReason, every scenario's outcome,
                                       the failure messages, and the list of evidence files. Committed.

  WHAT IT COPIES. Only this suite's files, and only from a report that is this suite's: the summary must name
  this suite's first scenario. The screenshots folder is shared with every mod and accumulates, so a still is
  taken only if its name is one this suite's features give it (`I take a screenshot "..."`), and a film only if
  its folder starts with one of this suite's feature titles, and in both cases only if it was written within
  the hour before the run ended. A file that merely looks new, from another mod that ran while this pass was
  queued, is not evidence of this run.

  A pass that fails to copy or to summarise does not stop the ones after it: each is wrapped, and the error is
  said out loud.

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Run-Passes.ps1
  powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Run-Passes.ps1 -Passes french
#>
param(
    [ValidateSet('english', 'french', 'sans-ideology')]
    [string[]]$Passes = @('english', 'french', 'sans-ideology'),
    [int]$MaxWaitMinutes = 720
)

$collection = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$launcher = Join-Path $collection 'scripts\Run-PickleWsl.ps1'
$live = Join-Path $collection 'pickle-reports'
$archive = Join-Path $collection 'pickle-reports-archive'
$features = Join-Path $PSScriptRoot 'Mod\Pickle\Features'
$signature = 'the mod is active and loads after Fireworks'   # first scenario of this suite

# Pickle names a still or a film folder from the words it was given, every character that is not a letter
# or a digit becoming a hyphen: "before the salvo: the loaded stand" -> "before-the-salvo--the-loaded-stand".
function ConvertTo-PickleName([string]$text) { return ($text -replace '[^A-Za-z0-9]', '-') }

function Get-OurStillNames {
    Get-ChildItem -LiteralPath $features -Filter '*.feature' | ForEach-Object {
        Select-String -LiteralPath $_.FullName -Pattern 'I take a screenshot "([^"]+)"' |
            ForEach-Object { 'manual--' + (ConvertTo-PickleName $_.Matches[0].Groups[1].Value) + '--step*.png' }
    } | Sort-Object -Unique
}

function Get-OurFilmPrefixes {
    Get-ChildItem -LiteralPath $features -Filter '*.feature' | ForEach-Object {
        Select-String -LiteralPath $_.FullName -Pattern '^Feature:\s*(.+?)\s*$' |
            ForEach-Object { (ConvertTo-PickleName $_.Matches[0].Groups[1].Value) + '--' }
    } | Sort-Object -Unique
}

function Test-IsOurs($dir) {
    $f = Join-Path $dir 'summary.json'
    if (-not (Test-Path -LiteralPath $f)) { return $false }
    return (Get-Content -LiteralPath $f -Raw).Contains($signature)
}

function Save-Evidence($dir, $target) {
    New-Item -ItemType Directory -Force -Path $target | Out-Null
    foreach ($n in 'summary.json', 'summary.md', 'junit.xml', 'messages.ndjson', 'Player.log') {
        $p = Join-Path $dir $n
        if (Test-Path -LiteralPath $p) { Copy-Item -LiteralPath $p -Destination $target -Force }
    }
    $ended = (Get-Item -LiteralPath (Join-Path $dir 'summary.json')).LastWriteTime
    $notBefore = $ended.AddMinutes(-60)
    $shots = Join-Path $dir 'screenshots'
    if (-not (Test-Path -LiteralPath $shots)) { return }

    $stills = Join-Path $target 'captures'
    foreach ($pattern in Get-OurStillNames) {
        Get-ChildItem -LiteralPath $shots -Filter $pattern -File -ErrorAction SilentlyContinue |
            Where-Object { $_.LastWriteTime -ge $notBefore } |
            ForEach-Object {
                New-Item -ItemType Directory -Force -Path $stills | Out-Null
                # A 1920x1080 png is about 3.5 MB; a jpeg at this quality is about 0.2 MB and just as readable. The disk
                # is short of space, so a still is minified as it is kept (the original stays in the shared report).
                if (Get-Command ffmpeg -ErrorAction SilentlyContinue) {
                    & ffmpeg -loglevel error -y -i $_.FullName -q:v 5 (Join-Path $stills ($_.BaseName + '.jpg'))
                }
                else { Copy-Item -LiteralPath $_.FullName -Destination $stills -Force }
            }
    }
    $prefixes = @(Get-OurFilmPrefixes)
    $films = Join-Path $target 'films'
    Get-ChildItem -LiteralPath (Join-Path $shots 'film') -Directory -ErrorAction SilentlyContinue |
        Where-Object { $name = $_.Name; $_.LastWriteTime -ge $notBefore -and ($prefixes | Where-Object { $name.StartsWith($_) }) } |
        ForEach-Object {
            $webm = Join-Path $_.FullName 'film.webm'
            if (Test-Path -LiteralPath $webm) {
                New-Item -ItemType Directory -Force -Path $films | Out-Null
                Copy-Item -LiteralPath $webm -Destination (Join-Path $films ($_.Name.Substring(0, [Math]::Min(90, $_.Name.Length)) + '.webm')) -Force
            }
        }
}

function Write-TextSummary($evidence, $pass, $launcherExit, $textFile) {
    $sum = Get-Content -LiteralPath (Join-Path $evidence 'summary.json') -Raw | ConvertFrom-Json
    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("# Pickle run: $pass, $(Split-Path $evidence -Leaf)")
    $lines.Add('')
    $lines.Add("- **exitReason:** ``$($sum.exitReason)`` (read before the counts). Launcher exit code: $launcherExit.")
    $lines.Add("- **Scenarios:** $($sum.total) discovered, $($sum.passed) passed, $($sum.failed) failed, $($sum.skipped) skipped, $($sum.flaky) flaky.")
    $lines.Add("- **Set name:** ``$($sum.setName)``.")
    $lines.Add("- **Evidence, on disk and ignored by git:** ``$(($evidence.Substring($repo.Length + 1)) -replace '\\', '/')/``")
    $lines.Add('- **Validated by a person:** not yet. A green scenario shows the trajectory ran, not that an image shows anything.')
    $lines.Add('')
    $lines.Add('| Scenario | Outcome | Duration (ms) |')
    $lines.Add('| --- | --- | --- |')
    foreach ($s in $sum.scenarios) { $lines.Add("| $($s.name) | $($s.outcome) | $($s.durationMs) |") }

    $junit = Join-Path $evidence 'junit.xml'
    if ($sum.failed -gt 0 -and (Test-Path -LiteralPath $junit)) {
        $lines.Add('')
        $lines.Add('## Failures')
        $xml = [xml](Get-Content -LiteralPath $junit -Raw)
        foreach ($case in $xml.SelectNodes('//testcase[failure]')) {
            $message = ($case.failure.message, $case.failure.InnerText | Where-Object { $_ } | Select-Object -First 1)
            if ($message.Length -gt 600) { $message = $message.Substring(0, 600) + '...' }
            $lines.Add('')
            $lines.Add("- **$($case.name)**: $($message -replace '\s+', ' ')")
        }
    }
    foreach ($kind in 'captures', 'films') {
        $dir = Join-Path $evidence $kind
        if (Test-Path -LiteralPath $dir) {
            $files = Get-ChildItem -LiteralPath $dir -File
            $lines.Add('')
            $lines.Add("## $kind ($($files.Count))")
            $lines.Add('')
            foreach ($f in $files) { $lines.Add("- $($f.Name) ($([Math]::Round($f.Length / 1KB)) KB)") }
        }
    }
    New-Item -ItemType Directory -Force -Path (Split-Path $textFile) | Out-Null
    Set-Content -LiteralPath $textFile -Value $lines -Encoding UTF8
}

$args_by_pass = @{
    'english'       = @()
    'french'        = @('-Language', 'French')
    'sans-ideology' = @('-DepMap', 'wsl-deps.sans-ideology.map')
}

Push-Location $collection
try {
    foreach ($pass in $Passes) {
        $since = Get-Date
        $launcherExit = $null
        try {
            Write-Host ("[{0}] pass '{1}': taking a ticket" -f (Get-Date -Format 'HH:mm:ss'), $pass)
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $launcher -Mod FireworkStand `
                -MaxWaitMinutes $MaxWaitMinutes @($args_by_pass[$pass])
            $launcherExit = $LASTEXITCODE
            Write-Host ("[{0}] pass '{1}': launcher exit {2}" -f (Get-Date -Format 'HH:mm:ss'), $pass, $launcherExit)

            $stamp = '{0}-{1}' -f (Get-Date -Format 'yyyy-MM-dd'), $pass
            $evidence = Join-Path $repo "Tests\Pickle\runs\$stamp"
            $source = $null
            $isFresh = { param($d) (Test-IsOurs $d) -and ((Get-Item (Join-Path $d 'summary.json')).LastWriteTime -ge $since) }
            if (& $isFresh $live) { $source = $live }
            else {
                $source = Get-ChildItem -LiteralPath $archive -Directory -ErrorAction SilentlyContinue |
                    Sort-Object LastWriteTime -Descending | Select-Object -First 6 |
                    Where-Object { & $isFresh $_.FullName } | Select-Object -First 1 -ExpandProperty FullName
            }
            if (-not $source) {
                Write-Host ("[{0}] pass '{1}': NO REPORT OF THIS SUITE FOUND, live or archived (launcher exit {2}). Nothing to read." -f `
                    (Get-Date -Format 'HH:mm:ss'), $pass, $launcherExit) -ForegroundColor Red
                continue
            }
            Save-Evidence $source $evidence
            $textFile = Join-Path $repo "docs\runs\$stamp.md"
            Write-TextSummary $evidence $pass $launcherExit $textFile
            $sum = Get-Content -LiteralPath (Join-Path $evidence 'summary.json') -Raw | ConvertFrom-Json
            Write-Host ("[{0}] pass '{1}': {2} scenarios, {3} passed, {4} failed, {5} skipped, exitReason {6}; evidence in {7}, summary in {8}" -f `
                (Get-Date -Format 'HH:mm:ss'), $pass, $sum.total, $sum.passed, $sum.failed, $sum.skipped, $sum.exitReason, $evidence, $textFile)
        }
        catch {
            Write-Host ("[{0}] pass '{1}': keeping the report failed: {2}. The next pass goes on." -f `
                (Get-Date -Format 'HH:mm:ss'), $pass, $_.Exception.Message) -ForegroundColor Red
        }
    }
}
finally { Pop-Location }
