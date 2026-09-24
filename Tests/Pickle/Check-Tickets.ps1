<#
.SYNOPSIS
  One look at everything Firework Stand has in the Pickle queue. Read-only: it takes no ticket, launches nothing and
  kills nothing. It is what the session's single heartbeat runs.

.DESCRIPTION
  Prints, in a few lines: whether the passes' watcher (Run-Passes.ps1) is alive, which of this suite's tickets are in
  the queue and how many stand ahead of each, who holds the lock, and which text summaries of runs appeared or changed
  in docs/runs/ in the last day. It exists so that a session waiting hours on a queue keeps ONE heartbeat for all its
  tickets instead of one background task per ticket.

  It reads the queue and the lock through scripts/Pickle-Status.ps1, which looks in every place a session could have
  written (the Claude desktop app's AppData is split in two, see Headless/README.md).

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Check-Tickets.ps1
#>
$collection = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path

$watchers = @(Get-CimInstance Win32_Process -Filter "Name='powershell.exe'" |
    Where-Object { $_.CommandLine -match 'Run-Passes\.ps1' })
$launchers = @(Get-CimInstance Win32_Process -Filter "Name='powershell.exe'" |
    Where-Object { $_.CommandLine -match 'Run-PickleWsl' -and $_.CommandLine -match '-Mod FireworkStand' })
Write-Output ("watcher (Run-Passes.ps1): {0}; launchers waiting or running: {1}" -f `
    $(if ($watchers.Count) { 'alive, pid ' + (($watchers | ForEach-Object ProcessId) -join ', ') } else { 'NOT running' }), $launchers.Count)

$status = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $collection 'scripts\Pickle-Status.ps1') 2>&1
$lines = @($status | ForEach-Object { "$_" })
$lock = $lines | Where-Object { $_ -match '^verrou' } | Select-Object -First 1
$wsl = $lines | Where-Object { $_ -match '^WSL' } | Select-Object -First 1
Write-Output $lock
Write-Output $wsl

# The queue lines are indented "<pid> <name> <time>"; count the tickets ahead of each of ours.
$queue = @($lines | Where-Object { $_ -match '^\s+\d+\s+\S' })
$mine = @()
for ($i = 0; $i -lt $queue.Count; $i++) { if ($queue[$i] -match 'FireworkStand') { $mine += ,@($i, $queue[$i].Trim()) } }
if ($mine.Count -eq 0) { Write-Output 'tickets in the queue: none of ours' }
foreach ($m in $mine) { Write-Output ("ticket: {0}   ({1} ahead of it, {2} in the queue)" -f $m[1], $m[0], $queue.Count) }

$recent = @(Get-ChildItem -LiteralPath (Join-Path $repo 'docs\runs') -Filter '*.md' -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -ne 'README.md' -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) } |
    Sort-Object LastWriteTime -Descending)
if ($recent.Count) {
    Write-Output 'run summaries written or changed in the last day:'
    foreach ($f in $recent) {
        $head = (Get-Content -LiteralPath $f.FullName -TotalCount 4 | Where-Object { $_ -match 'exitReason|Scenarios' }) -join ' | '
        Write-Output ("  {0}  {1}  {2}" -f $f.LastWriteTime.ToString('MM-dd HH:mm'), $f.Name, $head)
    }
}
else { Write-Output 'no run summary written in the last day' }
