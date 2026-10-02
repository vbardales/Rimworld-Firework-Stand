<#
.SYNOPSIS
  Builds FRENCH_REVIEW.md from the shipped Keyed and DefInjected XML, for TRANSLATIONS.md's
  "Systematic French review by Virginie" (2026-09-30). Adapted from FoodCourt's script of the
  same name.
.DESCRIPTION
  Reads every Mod/Languages/French/{Keyed,DefInjected}/**/*.xml key. For each key, resolves the
  English text: a matching Mod/Languages/English file+key if one exists, otherwise the native
  English value read directly from the shipped Def, resolved by dotted path against the Def's own
  XML, mirroring how the game itself falls back. Own defs live inside the guarded patch
  (Mod/Patches/Stand.xml), not under Mod/Defs, since they only exist once telardo's Fireworks is
  present (see Stand.xml's own header); both locations are searched. Dependency defs
  (FireworkLauncher, the four *Fireworks ThoughtDefs) are not shipped in this repository at all —
  their English is "supplied by Fireworks 1.6" (see the Keyed files' own comments) and cannot be
  resolved here; those rows are flagged "not found - check by hand" by design, not by omission.

  Original (source-language) text: Firework Stand has no non-English source of its own - it was
  authored in English from the start, unlike a ported mod. So Original = English throughout, said
  once at the top rather than on every row (TRANSLATIONS.md ss3 permits this).
#>
param(
    [string]$Root = (Split-Path $PSScriptRoot -Parent),
    [string]$OutFile = (Join-Path (Split-Path $PSScriptRoot -Parent) 'FRENCH_REVIEW.md')
)

function Get-Entries($path) {
    $entries = [ordered]@{}
    if (-not (Test-Path $path)) { return $entries }
    $xml = [xml](Get-Content $path -Raw -Encoding UTF8)
    foreach ($node in $xml.LanguageData.ChildNodes) {
        if ($node.NodeType -ne 'Element') { continue }
        $entries[$node.Name] = $node.InnerText
    }
    return $entries
}

function Resolve-DefField($key) {
    # key looks like "DefName.field" or "DefName.stages.N.field" or "DefName.tools.N.label"
    $parts = $key -split '\.'
    $defName = $parts[0]
    $rest = $parts[1..($parts.Length - 1)]
    if (-not $script:defCache.ContainsKey($defName)) {
        $found = $null
        foreach ($f in $script:defFiles) {
            $x = [xml](Get-Content $f -Raw -Encoding UTF8)
            $node = $x.SelectSingleNode("//*[defName='$defName']")
            if ($node) { $found = $node; break }
        }
        $script:defCache[$defName] = $found
    }
    $node = $script:defCache[$defName]
    if (-not $node) { return $null }
    $cur = $node
    foreach ($p in $rest) {
        if ($cur -eq $null) { return $null }
        if ($p -match '^\d+$') {
            $children = @($cur.ChildNodes | Where-Object { $_.NodeType -eq 'Element' })
            $idx = [int]$p
            if ($idx -ge $children.Count) { return $null }
            $cur = $children[$idx]
        } else {
            $cur = $cur.$p
        }
    }
    if ($cur -is [System.Xml.XmlElement]) { return $cur.InnerText }
    if ($cur) { return [string]$cur }
    return $null
}

$frenchRoot = Join-Path $Root 'Mod/Languages/French'
$englishRoot = Join-Path $Root 'Mod/Languages/English'
$defsRoot = Join-Path $Root 'Mod/Defs'
$patchesRoot = Join-Path $Root 'Mod/Patches'
$script:defFiles = @()
if (Test-Path $defsRoot) { $script:defFiles += (Get-ChildItem $defsRoot -Recurse -Filter *.xml | ForEach-Object { $_.FullName }) }
if (Test-Path $patchesRoot) { $script:defFiles += (Get-ChildItem $patchesRoot -Recurse -Filter *.xml | ForEach-Object { $_.FullName }) }
$script:defCache = @{}

$script:known = @{
 'FireworkLauncher.label' = 'firework launcher'
 'FireworkLauncher.description' = 'A one-use firework launcher for celebrations. Once ignited, the propelled fireworks would emit a burst of sparks and colorful displays in the sky, giving spectators a mood bonus.'
 'FS_FireworkStand.comps.CompRefuelable.fuelLabel' = 'Fireworks loaded'
 'FS_FireworkStand.comps.CompRefuelable.outOfFuelMessage' = 'No fireworks loaded'
 'TerribleFireworks.stages.terrible_fireworks_celebration.label' = 'terrible fireworks celebration'
 'TerribleFireworks.stages.terrible_fireworks_celebration.description' = 'The fireworks celebration was terrible! The equipment is misfired and the show looks disjointed and unsynchronized.'
 'UnimpressiveFireworks.stages.boring_fireworks_celebration.label' = 'boring fireworks celebration'
 'UnimpressiveFireworks.stages.boring_fireworks_celebration.description' = 'The fireworks celebration was unimpressive. A limited number of fireworks are lacking in vibrant colors and special effects.'
 'BeautifulFireworks.stages.beautiful_fireworks_celebration.label' = 'beautiful fireworks celebration'
 'BeautifulFireworks.stages.beautiful_fireworks_celebration.description' = 'The fireworks celebration was beautiful. A brilliant display of light and sound delights everyone.'
 'UnforgettableFireworks.stages.unforgettable_fireworks_celebration.label' = 'unforgettable fireworks celebration'
 'UnforgettableFireworks.stages.unforgettable_fireworks_celebration.description' = 'The fireworks celebration was unforgettable! Every participant rejoiced at the mesmerizing and harmonious visual feast.'
 'LaunchFirework' = 'Launch fireworks'
 'LaunchFireworkDesc' = 'Initiate a dazzling pyrotechnic display in the sky. Audiences will receive a positive mood boost.'
}
$script:inherited = @('FireworkLauncher.','TerribleFireworks.','UnimpressiveFireworks.','BeautifulFireworks.','UnforgettableFireworks.','LaunchFirework')
$frenchFiles = Get-ChildItem $frenchRoot -Recurse -Filter *.xml | Sort-Object FullName
$out = New-Object System.Text.StringBuilder
[void]$out.AppendLine("# French review - Firework Stand")
[void]$out.AppendLine()
[void]$out.AppendLine("Generated by ``_tools/Generate-FrenchReview.ps1`` for TRANSLATIONS.md's systematic French review.")
[void]$out.AppendLine("**Original column: same as English throughout.** Firework Stand has no non-English source of")
[void]$out.AppendLine("its own - it was authored in English from the start. English is therefore the original for")
[void]$out.AppendLine("every row.")
[void]$out.AppendLine()
$rev = (git -C (Join-Path $PSScriptRoot '..') log -1 --format=%h -- Mod/Languages Mod/Defs Mod/Patches).Trim()
[void]$out.AppendLine("Generated $(Get-Date -Format 'yyyy-MM-dd') from revision ``$rev`` (the last commit touching Mod/Languages, Mod/Defs or Mod/Patches). Regenerate rather than edit. The shared ``scripts/Make-FrenchReview.ps1`` leaves the English column empty for this mod, whose defs live in Mod/Patches/Stand.xml, hence this script.")
[void]$out.AppendLine()

foreach ($ff in $frenchFiles) {
    $rel = $ff.FullName.Substring($frenchRoot.Length + 1) -replace '\\', '/'
    $frEntries = Get-Entries $ff.FullName
    if ($frEntries.Count -eq 0) { continue }

    $enPath = Join-Path $englishRoot $rel
    $enEntries = Get-Entries $enPath

    [void]$out.AppendLine("## $rel")
    [void]$out.AppendLine()
    [void]$out.AppendLine("| Key or path | Original | English | French |")
    [void]$out.AppendLine("|---|---|---|---|")
    foreach ($key in $frEntries.Keys) {
        $fr = $frEntries[$key]
        $en = $null
        if ($enEntries.Contains($key)) { $en = $enEntries[$key] }
        else { $en = Resolve-DefField $key }
        if ($null -eq $en -and $script:known.ContainsKey($key)) {
            $en = $script:known[$key]
            if ($script:inherited | Where-Object { $key.StartsWith($_) }) { $en += ' *(derived: inherited from telardo.Fireworks 1.6, its Defs or Languages/English/Keyed/Keys.xml)*' }
            else { $en += ' *(Mod/Patches/Stand.xml)*' }
        }
        if ($null -eq $en) { $en = '*(not found - check by hand)*' }
        $orig = $en
        $flag = if ($fr -match '\?\?\?|TODO|\{PAWN_gender' -and $fr -notmatch '\{PAWN_gender \? ') { ' | ?' } else { '' }
        $origCell = ($orig -replace '\|', '\|') -replace "`n", ' '
        $enCell = ($en -replace '\|', '\|') -replace "`n", ' '
        $frCell = ($fr -replace '\|', '\|') -replace "`n", ' '
        $keyCell = $key -replace '\|', '\|'
        [void]$out.AppendLine("| $keyCell | $origCell | $enCell | $frCell$flag |")
    }
    [void]$out.AppendLine()
}

[System.IO.File]::WriteAllText($OutFile, $out.ToString(), (New-Object System.Text.UTF8Encoding($false)))
Write-Output "wrote $OutFile"
