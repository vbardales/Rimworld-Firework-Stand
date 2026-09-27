<#
.SYNOPSIS
  Moves a Pickle report out of the shared monorepo root into this mod's own evidence folder, safely.

.DESCRIPTION
  A report submitted with a relative -EvidenceDir sometimes lands at the monorepo root
  (C:\Users\nelim\Documents\rimworld\Tests\...) instead of under FireworkStand\Tests\... (seen on requests e0f0 and
  6702, 2026-09-27; not this mod's bug, and not chased further here). This script is the fix for what went wrong the
  second time: a `Move-Item` that failed silently on a locked file, followed by an unconditional `Remove-Item` on the
  whole shared `Tests` folder, which destroyed the evidence of a red run before it was read (6702). This script
  never does that:
    - it moves file by file and checks each one landed at the destination before deleting the source;
    - it only ever deletes the run's own leaf folder (-RunName), never the shared `Tests` root or any sibling;
    - a file that fails to move is reported and left in place, and the script exits non-zero rather than deleting
      anything under it.

.PARAMETER RunName
  The run's folder name, e.g. "2026-09-27-vitrine-8" (matches -EvidenceDir's last path segment).

.PARAMETER MonorepoRoot
  Defaults to the standard location; override only for testing.
#>
param(
    [Parameter(Mandatory)] [string] $RunName,
    [string] $MonorepoRoot = 'C:\Users\nelim\Documents\rimworld'
)
$ErrorActionPreference = 'Stop'

$strayLeaf = Join-Path (Join-Path (Join-Path $MonorepoRoot 'Tests') 'Pickle') (Join-Path 'runs' $RunName)
$properLeaf = Join-Path (Join-Path $MonorepoRoot 'FireworkStand') (Join-Path 'Tests\Pickle\runs' $RunName)

if (-not (Test-Path $strayLeaf)) {
    "nothing at $strayLeaf : already in place, or the report used the right path this time."
    exit 0
}
if ($strayLeaf -notlike "$MonorepoRoot\Tests\Pickle\runs\*") { throw "refusing: $strayLeaf is not under the expected stray path" }

New-Item -ItemType Directory -Force $properLeaf | Out-Null
$files = Get-ChildItem $strayLeaf -File -Recurse
$moved = @()
foreach ($f in $files) {
    $rel = $f.FullName.Substring($strayLeaf.Length).TrimStart('\')
    $destFile = Join-Path $properLeaf $rel
    New-Item -ItemType Directory -Force (Split-Path $destFile) | Out-Null
    Copy-Item $f.FullName $destFile -Force
    if (-not (Test-Path $destFile) -or (Get-Item $destFile).Length -ne $f.Length) {
        throw "copy did not land correctly for $rel : leaving $strayLeaf untouched"
    }
    $moved += $f.FullName
}
# Only now, one file at a time, each already verified copied: remove the source files, then the (now empty) leaf
# folder. Never the shared `Tests` root above it, and never in one unconditional sweep.
foreach ($m in $moved) { Remove-Item $m -Force }
$remaining = Get-ChildItem $strayLeaf -Recurse -File
if ($remaining) { throw "files remain under $strayLeaf after individual removal: not cleaning the folder" }
Remove-Item $strayLeaf -Recurse -Force
"{0} file(s) moved from {1} to {2}." -f $moved.Count, $strayLeaf, $properLeaf
