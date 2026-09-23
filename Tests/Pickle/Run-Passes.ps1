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
  suite (2026-09-21) finished, then lost its report before anyone read it. So this waits for each pass, and as
  soon as the launcher returns it copies what the run wrote into Tests/Pickle/runs/<date>-<pass>/: the summary,
  the junit report, the log, the messages, this suite's films and this suite's stills (the stills are large and
  ignored by git; the rest is committed by whoever reads it).

  It checks that what it copies is THIS suite's report and newer than the pass it just played, and if the live
  folder has already been archived by the next launch it looks in the newest archive folders instead.

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Run-Passes.ps1
  powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Run-Passes.ps1 -Passes french
#>
param(
    [ValidateSet('english', 'french', 'sans-ideology')]
    [string[]]$Passes = @('english', 'french', 'sans-ideology'),
    [int]$MaxWaitMinutes = 720
)

$ErrorActionPreference = 'Stop'
$collection = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$launcher = Join-Path $collection 'scripts\Run-PickleWsl.ps1'
$live = Join-Path $collection 'pickle-reports'
$archive = Join-Path $collection 'pickle-reports-archive'
$signature = 'the mod is active and loads after Fireworks'   # first scenario of this suite

function Test-IsOurs($dir) {
    $f = Join-Path $dir 'summary.json'
    if (-not (Test-Path -LiteralPath $f)) { return $false }
    return (Get-Content -LiteralPath $f -Raw) -like "*$signature*"
}

function Save-Report($dir, $target, $since) {
    New-Item -ItemType Directory -Force -Path $target | Out-Null
    foreach ($n in 'summary.json', 'summary.md', 'junit.xml', 'messages.ndjson', 'Player.log') {
        $p = Join-Path $dir $n
        if (Test-Path -LiteralPath $p) { Copy-Item -LiteralPath $p -Destination $target -Force }
    }
    $shots = Join-Path $dir 'screenshots'
    if (Test-Path -LiteralPath $shots) {
        $stills = Join-Path $target 'captures'
        New-Item -ItemType Directory -Force -Path $stills | Out-Null
        Get-ChildItem -LiteralPath $shots -Filter 'manual--*.png' -File |
            Where-Object { $_.LastWriteTime -ge $since } |
            ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $stills -Force }
        $films = Join-Path $target 'films'
        Get-ChildItem -LiteralPath (Join-Path $shots 'film') -Directory -ErrorAction SilentlyContinue |
            Where-Object { $_.LastWriteTime -ge $since -and (Test-Path (Join-Path $_.FullName 'film.webm')) } |
            ForEach-Object {
                New-Item -ItemType Directory -Force -Path $films | Out-Null
                Copy-Item -LiteralPath (Join-Path $_.FullName 'film.webm') `
                    -Destination (Join-Path $films (($_.Name).Substring(0, [Math]::Min(80, $_.Name.Length)) + '.webm')) -Force
            }
    }
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
        Write-Host ("[{0}] pass '{1}': taking a ticket" -f (Get-Date -Format 'HH:mm:ss'), $pass)
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $launcher -Mod FireworkStand `
            -MaxWaitMinutes $MaxWaitMinutes @($args_by_pass[$pass])
        $code = $LASTEXITCODE
        Write-Host ("[{0}] pass '{1}': launcher exit {2}" -f (Get-Date -Format 'HH:mm:ss'), $pass, $code)

        $target = Join-Path $repo ("Tests\Pickle\runs\{0}-{1}" -f (Get-Date -Format 'yyyy-MM-dd'), $pass)
        $source = $null
        if ((Test-IsOurs $live) -and ((Get-Item (Join-Path $live 'summary.json')).LastWriteTime -ge $since)) {
            $source = $live
        }
        else {
            $source = Get-ChildItem -LiteralPath $archive -Directory -ErrorAction SilentlyContinue |
                Sort-Object LastWriteTime -Descending | Select-Object -First 6 |
                Where-Object { (Test-IsOurs $_.FullName) -and ((Get-Item (Join-Path $_.FullName 'summary.json')).LastWriteTime -ge $since) } |
                Select-Object -First 1 -ExpandProperty FullName
        }
        if ($source) {
            Save-Report $source $target $since
            $sum = Get-Content -LiteralPath (Join-Path $target 'summary.json') -Raw | ConvertFrom-Json
            Write-Host ("[{0}] pass '{1}': saved to {2}: {3} scenarios, {4} passed, {5} failed, {6} skipped, exitReason {7}" -f `
                (Get-Date -Format 'HH:mm:ss'), $pass, $target, $sum.total, $sum.passed, $sum.failed, $sum.skipped, $sum.exitReason)
        }
        else {
            Write-Host ("[{0}] pass '{1}': NO REPORT OF THIS SUITE FOUND, live or archived (launcher exit {2}). Nothing to read." -f `
                (Get-Date -Format 'HH:mm:ss'), $pass, $code) -ForegroundColor Red
        }
    }
}
finally { Pop-Location }
