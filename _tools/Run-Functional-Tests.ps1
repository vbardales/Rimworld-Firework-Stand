<#
.SYNOPSIS
  What the game and telardo's mod actually do with this one, checked outside the game.

.DESCRIPTION
  TESTING.md next door lists what to watch for in a running colony. This asks the question that
  can be settled without a colony: this mod delegates almost everything, so do the things it
  delegates to still do what it delegates them for?

  There are three of them, and they are not equally safe:

    the game's classes    JobDriver_WatchBuilding hands its tick to a protected virtual method
                          this mod overrides, and CompGlower asks every IThingGlower comp before
                          lighting. Neither is a published extension point.
    telardo's assembly    reached by reflection, by string names, with no compile-time reference
                          at all. A rename on his side is silent here until a colonist watches.
    telardo's defs        the four ThoughtDefs the bridge looks up, the item the guard tests for,
                          and the texture the stand borrows.

  Nothing is simulated. RimWorld does not run outside itself - ThingDef alone throws on
  construction - but three things do work and they are enough:

    reading IL       a method body comes back as bytes through plain reflection and its tokens
                     resolve, so what a vanilla method does is read off the compiled game rather
                     than asserted in a comment.
    reverse lookup   scanning every method body in the game for the field tokens these defs write
                     says WHO reads each setting. Sixteen thousand types in a dozen seconds.
    construction     the mod's own comp, its comp properties and its job driver are really
                     instantiated here, and the driver's override really is matched against the
                     vanilla slot it means to take.

  The one worth reading twice is the delegate binding. The vanilla driver does not call
  WatchTickAction: it builds a delegate from it once, when the toil is made, and hands that to
  Toil.AddPreTickIntervalAction. A delegate built with ldftn would be bound to the base method and
  this entire mod would be dead code - a stand that never fires, with nothing in the log. It is
  built with dup + ldvirtftn, so the override runs. That is one opcode between working and not, it
  is invisible in the source, and no other kind of test would see it.

  Exit code 0 when everything passes, 1 otherwise. About fifteen seconds, most of it the scan.

  WHAT IT FOUND ON ITS FIRST RUN. CompProperties_Refuelable.showFuelGizmo has no reader left in
  1.6: the def was setting it to true and the game had stopped looking. It loads, it warns about
  nothing, and it does nothing. It is gone from the def now, with a comment where it was.

  TWENTY OF THESE TESTS HAVE BEEN SEEN TO FAIL, one fault at a time in a copy of the mod - and
  where the fault is telardo's, in a copy of his - never in the real files:

    a comp class renamed under the def   -> the class test, and the IThingGlower test with it
    ShouldBeLitNow made to answer true   -> the veto test
    IThingGlower dropped from the comp   -> the veto test
    shotInterval misspelt in the def     -> the comp-settings test
    a private field of the game read     -> the access test, naming CompGlower.glowOnInt
    the override made `new` not `override`-> the slot test
    his assembly swapped for another     -> all four of his tests at once
    BeautifulFireworks renamed by him    -> the memories test
    FireworkLauncher renamed by him      -> the guard test
    texPath put in the wrong case        -> the texture test, which is the Linux-only failure
    showFuelGizmo written back in        -> the inert-setting test
    the giver pointed at SocialRelax     -> the giver-settings test, and the chance comparison
    the joyKind taken off the job        -> the credit test
    the building given another kind      -> the credit test
    the job pointed at the base driver   -> the two-settings test
    joyDuration tripled                  -> the length comparison
    joyMaxParticipants at 40             -> the audience comparison
    baseChance at 40                     -> the chance comparison
    the watch range at 4~60              -> the distance comparison

  SIX MORE were added on 2026-09-24 with the empty-stand rules and the move of the effects to CompTick,
  and all six were seen to fail against the previous version of the mod (its DLL and its patch, taken
  from HEAD).

  FIVE COULD NOT BE, and the file says so rather than letting the count imply otherwise: the three
  about CompGlower and the two about JobDriver_WatchBuilding are claims about Assembly-CSharp
  itself, and mutating the game to prove a test would mean rewriting its IL. They are the tests
  that matter most, and they are the ones with no red run behind them.

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
#>

param(
    [string]$ModRoot   = (Split-Path -Parent $PSScriptRoot),
    [string]$GameData  = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data',
    [string]$Managed   = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed',
    [string]$Fireworks = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\2922179297'
)

$ErrorActionPreference = 'Stop'

$script:ran = 0
$script:failed = 0

function It([string]$name, [scriptblock]$body) {
    $script:ran++
    $problems = @()
    try   { $problems = @(& $body | Where-Object { $_ }) }
    catch { $problems = @("threw: $($_.Exception.GetBaseException().Message)") }
    if ($problems.Count -eq 0) { Write-Output "  ok    $name" }
    else {
        $script:failed++
        Write-Output "  FAIL  $name"
        foreach ($p in $problems) { Write-Output "          $p" }
    }
}

function Section([string]$name) { Write-Output ''; Write-Output $name }

# ---------------------------------------------------------------------------------------------
# The three assemblies
# ---------------------------------------------------------------------------------------------

$script:probed = @{}
$script:asmResolver = [System.ResolveEventHandler]{
    param($sender, $e)
    $short = $e.Name.Split(',')[0]
    if ($script:probed.ContainsKey($short)) { return $null }
    $script:probed[$short] = $true
    $p = Join-Path $Managed "$short.dll"
    if (Test-Path $p) { return [System.Reflection.Assembly]::LoadFrom($p) }
    return $null
}
[System.AppDomain]::CurrentDomain.add_AssemblyResolve($script:asmResolver)

function Get-AssemblyTypes([System.Reflection.Assembly]$a) {
    try     { return $a.GetTypes() }
    catch [System.Reflection.ReflectionTypeLoadException] { return $_.Exception.Types | Where-Object { $_ } }
    catch   { return $_.Exception.InnerException.Types | Where-Object { $_ } }
}

$BFall = [System.Reflection.BindingFlags]'Public,NonPublic,Instance,Static,DeclaredOnly'
$BFi   = [System.Reflection.BindingFlags]'Public,NonPublic,Instance'
$BFid  = [System.Reflection.BindingFlags]'Public,NonPublic,Instance,DeclaredOnly'
$BFn   = [System.Reflection.BindingFlags]'Public,NonPublic'
$BFpi  = [System.Reflection.BindingFlags]'Public,Instance'

$gameAsm  = [System.Reflection.Assembly]::LoadFrom((Join-Path $Managed 'Assembly-CSharp.dll'))
$allTypes = @(Get-AssemblyTypes $gameAsm)
$byName = @{}
foreach ($t in $allTypes) { if (-not $byName.ContainsKey($t.Name)) { $byName[$t.Name] = $t } }

$modAsm = [System.Reflection.Assembly]::LoadFrom((Join-Path $ModRoot 'Mod\Assemblies\FireworkStand.dll'))

# telardo's mod ships one folder per game version behind a LoadFolders.xml; 1.6 is the version
# this mod declares, so it is the one every claim below is made against.
$fwVersion = Join-Path $Fireworks '1.6'
$fwAsmPath = Join-Path $fwVersion 'Assemblies\Fireworks.dll'
$fwAsm = $null
if (Test-Path $fwAsmPath) { $fwAsm = [System.Reflection.Assembly]::LoadFrom($fwAsmPath) }

# ---------------------------------------------------------------------------------------------
# Reading IL
# ---------------------------------------------------------------------------------------------
#
# Only the handful of opcodes this suite asks about, each a byte followed by a four-byte metadata
# token. Within one module that token IS the member's MetadataToken, which is what makes the
# reverse scan further down an integer comparison rather than a resolve per instruction.

function Get-Refs($method) {
    # @{ Kind = 'call' | 'ldftn' | 'ldvirtftn' | 'fld' | 'type'; Member = <resolved> } for every
    # token the body names. Unresolvable tokens are skipped: generic context, mostly.
    $out = @()
    $body = $null
    try { $body = $method.GetMethodBody() } catch { }
    if (-not $body) { return $out }
    $il = $body.GetILAsByteArray()
    if (-not $il) { return $out }
    $mod = $method.Module
    for ($i = 0; $i -lt $il.Length - 4; $i++) {
        $op = $il[$i]
        $kind = $null; $at = $i + 1; $resolve = $null
        if     ($op -eq 0x28 -or $op -eq 0x6F -or $op -eq 0x73) { $kind = 'call'; $resolve = 'method' }
        elseif ($op -eq 0x7B -or $op -eq 0x7D)                  { $kind = 'fld';  $resolve = 'field'  }
        elseif ($op -eq 0x74 -or $op -eq 0x75)                  { $kind = 'type'; $resolve = 'type'   }
        elseif ($op -eq 0xFE -and $i + 5 -lt $il.Length -and ($il[$i+1] -eq 0x06 -or $il[$i+1] -eq 0x07)) {
            $kind = $(if ($il[$i+1] -eq 0x06) { 'ldftn' } else { 'ldvirtftn' })
            $at = $i + 2; $resolve = 'method'
        }
        if (-not $kind) { continue }
        $tok = [BitConverter]::ToInt32($il, $at)
        $m = $null
        try {
            switch ($resolve) {
                'method' { $m = $mod.ResolveMethod($tok) }
                'field'  { $m = $mod.ResolveField($tok) }
                'type'   { $m = $mod.ResolveType($tok) }
            }
        } catch { }
        if ($m) { $out += ,@{ Kind = $kind; Member = $m } }
    }
    return $out
}

function Test-Calls($refs, [string]$typeName, [string]$memberName) {
    foreach ($r in $refs) {
        if ($r.Kind -eq 'type') { continue }
        $d = $r.Member.DeclaringType
        if ($d -and $d.Name -eq $typeName -and $r.Member.Name -eq $memberName) { return $true }
    }
    return $false
}

function Get-AllMethods([Type]$t, [bool]$withNested) {
    $types = @($t)
    if ($withNested) { $types += @($t.GetNestedTypes($BFn)) }
    $out = @()
    foreach ($x in $types) {
        $out += @($x.GetMethods($BFall))
        $out += @($x.GetConstructors($BFall))
        foreach ($p in $x.GetProperties($BFid)) {
            $g = $p.GetGetMethod($true); if ($g) { $out += $g }
        }
    }
    return $out
}

function Get-Ancestry([Type]$t) {
    $names = @{}
    $cur = $t
    while ($cur -and $cur.FullName -ne 'System.Object') { $names[$cur.Name] = $true; $cur = $cur.BaseType }
    return $names
}

function Get-FieldsRecursive([Type]$t) {
    $d = @{}
    $cur = $t
    while ($cur -and $cur.FullName -ne 'System.Object') {
        foreach ($f in $cur.GetFields($BFid)) { if (-not $d.ContainsKey($f.Name)) { $d[$f.Name] = $f } }
        $cur = $cur.BaseType
    }
    return $d
}

# ---------------------------------------------------------------------------------------------
# What the defs write
# ---------------------------------------------------------------------------------------------
#
# The defs sit inside a PatchOperationConditional, so they are read from under <value> rather than
# from a Defs root. That is the mod's own design and not an accident of this file: without
# telardo's mod, none of them is ever loaded.

$patch = New-Object System.Xml.XmlDocument
$patch.Load((Join-Path $ModRoot 'Mod\Patches\Stand.xml'))

$defNodes = @($patch.SelectNodes('//match/value/*') | Where-Object { $_.NodeType -eq 'Element' })
function Get-DefNode([string]$type) { return ($defNodes | Where-Object { $_.LocalName -eq $type } | Select-Object -First 1) }

$standNode = Get-DefNode 'ThingDef'
$jobNode   = Get-DefNode 'JobDef'
$giverNode = Get-DefNode 'JoyGiverDef'
$kindNode  = Get-DefNode 'JoyKindDef'

function Get-Text($node, [string]$xpath) {
    if (-not $node) { return $null }
    $n = $node.SelectSingleNode($xpath)
    if ($n) { return $n.InnerText.Trim() }
    return $null
}

$giverClassName  = Get-Text $giverNode 'giverClass'
$driverClassName = Get-Text $jobNode   'driverClass'

# The giver class is this mod's own (a subclass of the vanilla watch-building giver that refuses an empty
# stand), so it is looked up in the mod's assembly first and in the game's after. `$giverVanillaName` is
# the nearest class the game itself declares, which is what the vanilla defs are compared through.
$giverType = $modAsm.GetType($giverClassName)
if (-not $giverType) { $giverType = $byName[$giverClassName] }
$giverVanillaName = $null
for ($gt = $giverType; $gt -and -not $giverVanillaName; $gt = $gt.BaseType) {
    if ($byName.ContainsKey($gt.Name) -and $byName[$gt.Name].Assembly -eq $gameAsm) { $giverVanillaName = $gt.Name }
}

$written = @{}      # metadata token -> "Type.field"
function Collect-Written($node, [Type]$t) {
    if (-not $t) { return }
    $fields = Get-FieldsRecursive $t
    foreach ($c in $node.ChildNodes) {
        if ($c.NodeType -ne 'Element' -or $c.LocalName -eq 'li') { continue }
        $f = $fields[$c.LocalName]
        if (-not $f) { continue }
        # Keyed by the type that DECLARES the field: defName written under a JoyGiverDef is
        # Def.defName, read by half the game and a setting of nobody's.
        $written[$f.MetadataToken] = "$($f.DeclaringType.Name).$($f.Name)"
        $ft = $f.FieldType
        if ($ft.IsPrimitive -or $ft -eq [string] -or $ft.IsEnum -or $ft.IsGenericType) { continue }
        if ($byName['Def'] -and $byName['Def'].IsAssignableFrom($ft)) { continue }
        $sub = $ft
        $cls = $c.GetAttribute('Class')
        if ($cls -and $byName.ContainsKey($cls)) { $sub = $byName[$cls] }
        Collect-Written $c $sub
    }
}
foreach ($n in $defNodes) { Collect-Written $n $byName[$n.LocalName] }
foreach ($li in @($patch.SelectNodes('//comps/li'))) {
    $cls = $li.GetAttribute('Class')
    $t = $null
    if ($cls -and $byName.ContainsKey($cls)) { $t = $byName[$cls] } else { $t = $byName['CompProperties'] }
    if ($t) { Collect-Written $li $t }
}

# One field the defs deliberately leave at its default and whose reader still has to be named: the
# tally of recreation types available on a map consults it.
$extra = @{}
if ($byName['JoyKindDef']) {
    $f = $byName['JoyKindDef'].GetField('needsThing', $BFi)
    if ($f) { $extra[$f.MetadataToken] = 'JoyKindDef.needsThing' }
}

# ---------------------------------------------------------------------------------------------
# Who reads what: one pass over every method body in the game
# ---------------------------------------------------------------------------------------------

$hunted = @{}
foreach ($k in $written.Keys) { $hunted[$k] = $written[$k] }
foreach ($k in $extra.Keys)   { $hunted[$k] = $extra[$k] }

$readers = @{}
$scanSeconds = 0
if ($hunted.Count -gt 0) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    foreach ($t in $allTypes) {
        foreach ($m in (@($t.GetMethods($BFall)) + @($t.GetConstructors($BFall)))) {
            $body = $null
            try { $body = $m.GetMethodBody() } catch { }
            if (-not $body) { continue }
            $il = $body.GetILAsByteArray()
            if (-not $il -or $il.Length -lt 5) { continue }
            for ($i = 0; $i -lt $il.Length - 4; $i++) {
                if ($il[$i] -ne 0x7B) { continue }      # ldfld
                $tok = [BitConverter]::ToInt32($il, $i + 1)
                if (-not $hunted.ContainsKey($tok)) { continue }
                # The OUTERMOST declaring type: a state machine is <MakeNewToils>d__2, a name two
                # dozen classes share, and reporting it would name nothing.
                $owner = $t
                while ($owner.DeclaringType) { $owner = $owner.DeclaringType }
                $key = $hunted[$tok]
                if (-not $readers.ContainsKey($key)) { $readers[$key] = @{} }
                $readers[$key][$owner.Name] = $true
            }
        }
    }
    $sw.Stop()
    $scanSeconds = $sw.Elapsed.TotalSeconds
}

function Get-Readers([string]$field) {
    if ($readers.ContainsKey($field)) { return @($readers[$field].Keys | Sort-Object) }
    return @()
}
function Show-Readers($names) {
    $a = @($names)
    if ($a.Count -eq 0)  { return 'nothing' }
    if ($a.Count -le 6)  { return ($a -join ', ') }
    return (($a[0..5] -join ', ') + " and $($a.Count - 6) more")
}

# ---------------------------------------------------------------------------------------------
# The vanilla defs that run on the same classes
# ---------------------------------------------------------------------------------------------

$vanillaJobs   = @{}
$vanillaGivers = @{}
$vanillaWatch  = @{}
foreach ($dir in (Get-ChildItem $GameData -Directory)) {
    $defsRoot = Join-Path $dir.FullName 'Defs'
    if (-not (Test-Path $defsRoot)) { continue }
    foreach ($f in Get-ChildItem $defsRoot -Recurse -Filter *.xml) {
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        if ($null -eq $x.DocumentElement -or $x.DocumentElement.LocalName -ne 'Defs') { continue }
        foreach ($n in $x.DocumentElement.ChildNodes) {
            if ($n.NodeType -ne 'Element') { continue }
            if ($n.LocalName -eq 'JobDef') {
                $d = Get-Text $n 'driverClass'
                if ($d) { $vanillaJobs[[string]$n.defName] = @{
                    Driver       = $d
                    Duration     = Get-Text $n 'joyDuration'
                    Participants = Get-Text $n 'joyMaxParticipants' } }
            }
            elseif ($n.LocalName -eq 'JoyGiverDef') {
                $g = Get-Text $n 'giverClass'
                if ($g) { $vanillaGivers[[string]$n.defName] = @{ Giver = $g; Chance = Get-Text $n 'baseChance' } }
            }
            elseif ($n.LocalName -eq 'ThingDef') {
                $r = Get-Text $n 'building/watchBuildingStandDistanceRange'
                if ($r) { $vanillaWatch[[string]$n.defName] = $r }
            }
        }
    }
}

# ---------------------------------------------------------------------------------------------

Write-Output 'Firework Stand - what the game and telardo do with it'
Write-Output "  mod        $ModRoot"
Write-Output ("  scanned    {0} types for the readers of {1} field(s), in {2:n1}s" -f `
              $allTypes.Count, $hunted.Count, $scanSeconds)
Write-Output ("  vanilla    {0} jobs, {1} joy givers and {2} watched buildings read from the game data" -f `
              $vanillaJobs.Count, $vanillaGivers.Count, $vanillaWatch.Count)
Write-Output ("  fireworks  {0}" -f $(if ($fwAsm) { 'the 1.6 assembly and defs are on disk' } else { "NOT FOUND under $Fireworks" }))

# =============================================================================================
Section 'The mod''s own code, built and run here'
# =============================================================================================

It 'every class the defs name is in this assembly, and can be built' {
    # A comp class named in XML and missing from the assembly fails the whole def, taking the
    # building with it. These are instantiated rather than merely found, because that is what the
    # game does when it reads the comps list.
    foreach ($name in 'FireworkStand.CompProperties_FireworkStand',
                      'FireworkStand.CompFireworkStand',
                      'FireworkStand.JobDriver_WatchFireworks',
                      'FireworkStand.JoyGiver_WatchFireworkStand',
                      'FireworkStand.FireworksBridge') {
        $t = $modAsm.GetType($name)
        if (-not $t) { "$name is not in the assembly"; continue }
        if ($t.IsAbstract -and $t.IsSealed) { continue }        # the bridge is static
        try { [void][Activator]::CreateInstance($t) }
        catch { "$name could not be built: $($_.Exception.GetBaseException().Message)" }
    }
    # And the properties have to point back at the comp, which is what pairs them at load.
    $props = [Activator]::CreateInstance($modAsm.GetType('FireworkStand.CompProperties_FireworkStand'))
    if ($props.compClass -ne $modAsm.GetType('FireworkStand.CompFireworkStand')) {
        "the properties point at $($props.compClass) rather than at the comp"
    }
}

It 'the comp is an IThingGlower, and a fresh one keeps the light off' {
    # The default answer is the one that matters. CompGlower consults neither fuel nor power (the
    # test further down reads that off the game), so a comp answering yes by default would leave a
    # loaded stand lit like a lamp - the most visible defect this mod could ship.
    $ig = $byName['IThingGlower']
    if (-not $ig) { 'the game has no IThingGlower any more'; return }
    $c = [Activator]::CreateInstance($modAsm.GetType('FireworkStand.CompFireworkStand'))
    if (-not $ig.IsInstanceOfType($c)) { 'the comp does not implement IThingGlower'; return }
    if ($c.ShouldBeLitNow()) { 'a fresh comp asks for the light to be on' }
}

It 'every setting the def writes into the comp exists on the properties class' {
    # An unknown element under a comp's <li> does not warn: it is dropped and the setting keeps
    # its default. A misspelt shotInterval is a stand firing on the wrong cadence, silently.
    $t = $modAsm.GetType('FireworkStand.CompProperties_FireworkStand')
    $fields = Get-FieldsRecursive $t
    $li = $patch.SelectSingleNode("//comps/li[@Class='FireworkStand.CompProperties_FireworkStand']")
    if (-not $li) { 'the def does not carry this comp at all'; return }
    $seen = 0
    foreach ($c in $li.ChildNodes) {
        if ($c.NodeType -ne 'Element') { continue }
        $seen++
        if (-not $fields.ContainsKey($c.LocalName)) { "the def writes $($c.LocalName), which the class does not declare" }
    }
    if ($seen -eq 0) { 'the def sets none of the comp settings, which cannot be right' }
}

It 'the mod reaches for nothing in the game it is not allowed to reach for' {
    # The Contented Livestock trap. Krafs.Publicizer makes every member of the reference assembly
    # public, so a private field of the game compiles without a word; the instruction that comes
    # out is only legal with [assembly: IgnoresAccessChecksTo], which the publicizer poses through
    # the generated AssemblyInfo - and this csproj sets GenerateAssemblyInfo to false. So the
    # attribute is absent, and anything non-public touched here throws at the first tick.
    $hasAttr = @($modAsm.GetCustomAttributesData() |
                 Where-Object { $_.AttributeType.Name -like 'IgnoresAccessChecksTo*' }).Count -gt 0
    foreach ($t in (Get-AssemblyTypes $modAsm)) {
        $family = Get-Ancestry $t
        foreach ($m in (Get-AllMethods $t $true)) {
            foreach ($r in (Get-Refs $m)) {
                if ($r.Kind -eq 'type') { continue }
                $member = $r.Member
                $decl = $member.DeclaringType
                if (-not $decl -or $decl.Assembly -ne $gameAsm) { continue }
                if ($member.IsPublic) { continue }
                # A protected member is legal from a subclass, with no attribute at all.
                if (($member.IsFamily -or $member.IsFamilyOrAssembly) -and $family.ContainsKey($decl.Name)) { continue }
                if ($hasAttr) { continue }
                "$($t.Name).$($m.Name) touches $($decl.Name).$($member.Name), which is not public, and this assembly carries no IgnoresAccessChecksTo"
            }
        }
    }
}

# =============================================================================================
Section 'The graft onto the vanilla watching driver'
# =============================================================================================

It 'the method this mod overrides is still there, still virtual, still taking a tick delta' {
    $wb = $byName['JobDriver_WatchBuilding']
    if (-not $wb) { 'the game has no JobDriver_WatchBuilding any more'; return }
    $m = $wb.GetMethod('WatchTickAction', $BFi)
    if (-not $m) { 'JobDriver_WatchBuilding no longer declares WatchTickAction'; return }
    if (-not $m.IsVirtual) { 'WatchTickAction is no longer virtual, so it cannot be overridden' }
    $ps = @($m.GetParameters())
    if ($ps.Count -ne 1 -or $ps[0].ParameterType -ne [int]) {
        "WatchTickAction takes ($(($ps | ForEach-Object { $_.ParameterType.Name }) -join ', ')) rather than one int"
    }
}

It 'the override takes the vanilla slot rather than opening one of its own' {
    # The mod declares the override public where the game declares it protected, because the
    # publicized reference assembly says public and C# forbids narrowing on an override. Widening
    # is legal, but only as long as the result is still an override: a new slot would compile,
    # load, and never be called.
    $t = $modAsm.GetType('FireworkStand.JobDriver_WatchFireworks')
    $m = $t.GetMethod('WatchTickAction', $BFid)
    if (-not $m) { 'the mod no longer declares WatchTickAction'; return }
    $base = $m.GetBaseDefinition()
    if ($base.DeclaringType.Name -ne 'JobDriver_WatchBuilding') {
        "its base definition is $($base.DeclaringType.FullName).$($base.Name), not the vanilla driver's"
    }
    if ($m.Attributes.HasFlag([System.Reflection.MethodAttributes]::NewSlot)) {
        'the override is marked NewSlot, so the base driver would go on calling its own'
    }
}

It 'the vanilla driver binds that method virtually, which is the whole graft' {
    # It never calls WatchTickAction. It builds ONE delegate from it as the toil is made and hands
    # that to Toil.AddPreTickIntervalAction. dup + ldvirtftn binds to the runtime type, so the
    # override runs; a plain ldftn would bind to the base method and this mod would be dead code,
    # in silence - a stand that never fires, and not a line in the log.
    $wb = $byName['JobDriver_WatchBuilding']
    if (-not $wb) { 'the game has no JobDriver_WatchBuilding any more'; return }
    $tok = $wb.GetMethod('WatchTickAction', $BFi).MetadataToken
    $how = @()
    foreach ($m in (Get-AllMethods $wb $true)) {
        foreach ($r in (Get-Refs $m)) {
            if ($r.Kind -eq 'fld' -or $r.Kind -eq 'type') { continue }
            if ($r.Member.MetadataToken -ne $tok) { continue }
            $how += $r.Kind
        }
    }
    if ($how.Count -eq 0) { 'nothing in the vanilla driver names WatchTickAction any more'; return }
    if ($how -notcontains 'ldvirtftn' -and $how -notcontains 'call') {
        "the driver reaches it only by $(($how | Sort-Object -Unique) -join ', '), which does not dispatch to an override"
    }
    # And the delegate has to end up on the toil's tick, not somewhere decorative.
    $onTick = $false
    foreach ($t in @($wb.GetNestedTypes($BFn) | Where-Object { $_.Name -like '*MakeNewToils*' })) {
        foreach ($m in (Get-AllMethods $t $false)) {
            if (Test-Calls (Get-Refs $m) 'Toil' 'AddPreTickIntervalAction') { $onTick = $true }
        }
    }
    if (-not $onTick) { 'the toil no longer takes a pre-tick action, so nothing would drive the stand' }
}

# =============================================================================================
Section 'An empty stand: not offered, not watched, not "ready", and timed on every tick'
# =============================================================================================

It 'the joy giver takes the vanilla slot that decides whether a building is offered' {
    # An empty stand used to be offered as recreation and, watched, paid the whole recreation without a
    # rocket going up: the vanilla giver never looks at fuel. The mod's own giver refuses an empty stand
    # by overriding CanInteractWith. Like the driver's, the override is declared public where the game
    # declares it protected, so it has to be checked that it is still an override and not a new slot.
    $t = $modAsm.GetType('FireworkStand.JoyGiver_WatchFireworkStand')
    if (-not $t) { 'the mod has no JoyGiver_WatchFireworkStand'; return }
    $m = $t.GetMethod('CanInteractWith', $BFid)
    if (-not $m) { 'the mod no longer declares CanInteractWith'; return }
    $base = $m.GetBaseDefinition()
    if ($base.DeclaringType.Name -ne 'JoyGiver_InteractBuilding') {
        "its base definition is $($base.DeclaringType.FullName).$($base.Name), not the vanilla giver's"
    }
    if ($m.Attributes.HasFlag([System.Reflection.MethodAttributes]::NewSlot)) {
        'the override is marked NewSlot, so the game would go on asking the vanilla method'
    }
    if ($t.BaseType.Name -ne 'JoyGiver_WatchBuilding') {
        "the giver derives from $($t.BaseType.Name), not from the vanilla watch-building giver"
    }
}

It 'the vanilla giver decides through that method, so a refusal there keeps the colonist away' {
    # FindBestGame builds a predicate around CanInteractWith and hands it to the closest-thing search.
    # If the game stopped calling it virtually, the override would be dead code and an empty stand would
    # be offered again, in silence.
    $ib = $byName['JoyGiver_InteractBuilding']
    if (-not $ib) { 'the game has no JoyGiver_InteractBuilding any more'; return }
    $tok = $ib.GetMethod('CanInteractWith', $BFi).MetadataToken
    $how = @()
    foreach ($m in (Get-AllMethods $ib $true)) {
        foreach ($r in (Get-Refs $m)) {
            if ($r.Kind -eq 'fld' -or $r.Kind -eq 'type') { continue }
            if ($r.Member.MetadataToken -ne $tok) { continue }
            $how += $r.Kind
        }
    }
    if ($how.Count -eq 0) { 'nothing in the vanilla giver calls CanInteractWith any more'; return }
    # 'call' covers callvirt here: Get-Refs does not tell the opcodes apart, as in the driver test above.
    if ($how -notcontains 'call' -and $how -notcontains 'ldvirtftn') {
        "it reaches it only by $(($how | Sort-Object -Unique) -join ', '), which does not dispatch to an override"
    }
}

It 'the giver refuses a stand with nothing loaded, and the vanilla one asks nothing about fuel' {
    # The reason the override exists. Read off both: the mod's method asks CompRefuelable for HasFuel, and
    # the vanilla giver, its ancestors' CanInteractWith and the driver's joy tick name no CompRefuelable.
    $t = $modAsm.GetType('FireworkStand.JoyGiver_WatchFireworkStand')
    if (-not $t) { 'the mod has no JoyGiver_WatchFireworkStand'; return }
    $refs = Get-Refs ($t.GetMethod('CanInteractWith', $BFid))
    if (-not (Test-Calls $refs 'CompRefuelable' 'get_HasFuel')) { 'the giver no longer asks CompRefuelable.HasFuel' }
    foreach ($vt in 'JoyGiver_InteractBuilding', 'JoyGiver_WatchBuilding') {
        $g = $byName[$vt]
        $m = $g.GetMethod('CanInteractWith', $BFid)
        if (-not $m) { continue }
        $vr = Get-Refs $m
        if (@($vr | Where-Object { $_.Member.DeclaringType -and $_.Member.DeclaringType.Name -eq 'CompRefuelable' }).Count -gt 0) {
            "the vanilla $vt.CanInteractWith now asks about fuel, so the mod's refusal may be redundant"
        }
    }
}

It 'the watching job ends when the show is over, and the joy tick is still vanilla''s' {
    # The vanilla joy tick does not ask the stand, so without this the colonist would go on gaining
    # recreation in front of a stand that has fired its last rocket.
    $t = $modAsm.GetType('FireworkStand.JobDriver_WatchFireworks')
    $refs = Get-Refs ($t.GetMethod('WatchTickAction', $BFid))
    if (-not (Test-Calls $refs 'CompFireworkStand' 'ShowIsOn')) { 'the driver no longer asks the stand whether the show is on' }
    if (-not (Test-Calls $refs 'JobDriver' 'EndJobWith')) { 'the driver never ends the job' }
    if (-not (Test-Calls $refs 'JobDriver_WatchBuilding' 'WatchTickAction')) { 'the driver no longer calls the vanilla tick, so nothing would be inherited' }
}

It 'the inspect line says nothing when nothing is loaded' {
    $t = $modAsm.GetType('FireworkStand.CompFireworkStand')
    $refs = Get-Refs ($t.GetMethod('CompInspectStringExtra', $BFid))
    if (-not (Test-Calls $refs 'CompRefuelable' 'get_HasFuel')) {
        'the inspect line no longer looks at the fuel, so an empty stand would read "ready to fire" again'
    }
}

It 'the comp times its effects in CompTick, which the game runs on every tick' {
    # For a building whose ticker is Normal the game runs CompTick on every tick and CompTickInterval only
    # every UpdateRateTicks ticks (Thing.DoTick). The effects lived in CompTickInterval: a sixty-tick fuse
    # smoking every twelve ticks fell between two calls, and on the first full Pickle run the smoke could
    # not be seen at all. Read off both sides.
    $t = $modAsm.GetType('FireworkStand.CompFireworkStand')
    if (-not $t.GetMethod('CompTick', $BFid)) { 'the comp no longer declares CompTick' }
    if ($t.GetMethod('CompTickInterval', $BFid)) { 'the comp declares CompTickInterval again, which the game calls only every few ticks' }
    $twc = $byName['ThingWithComps']
    $tick = $twc.GetMethod('Tick', $BFid)
    if (-not $tick) { 'the game has no ThingWithComps.Tick any more'; return }
    if (-not (Test-Calls (Get-Refs $tick) 'ThingComp' 'CompTick')) { 'ThingWithComps.Tick no longer runs CompTick on every tick' }
    $th = $gameAsm.GetType('Verse.Thing')
    $doTick = $th.GetMethod('DoTick', $BFi)
    # Tick and TickInterval are declared on Entity, the base of Thing. DoTick calls Tick on every tick, and
    # reaches TickInterval only through the update rate: that is the throttle the effects fell victim to.
    $doRefs = Get-Refs $doTick
    if (-not (Test-Calls $doRefs 'Entity' 'Tick')) { 'Thing.DoTick no longer calls Tick on every tick for a Normal ticker' }
    if (-not (Test-Calls $doRefs 'GenTicks' 'IsTickInterval')) {
        'Thing.DoTick no longer throttles TickInterval: CompTickInterval may now be fine, and this test can be relaxed'
    }
}

It 'the fuse throws its own smoke, which fades in inside the fuse, not the game''s half-second Smoke' {
    # The fuse burns for launchDelay ticks (one second). The game's Smoke fleck fades in over half a second, so
    # the thread never showed: on the 0.1.1 pass two puffs were counted at the still and none could be seen.
    $t = $modAsm.GetType('FireworkStand.CompFireworkStand')
    $m = $t.GetMethod('ThrowFuseSmoke', $BFi)
    if (-not $m) { 'the comp has no ThrowFuseSmoke'; return }
    $refs = Get-Refs $m
    if (-not (Test-Calls $refs 'FleckMaker' 'GetDataStatic')) { 'ThrowFuseSmoke no longer builds its fleck through FleckMaker.GetDataStatic' }
    if (-not (Test-Calls (Get-Refs $t.GetMethod('CompTick', $BFid)) 'CompFireworkStand' 'ThrowFuseSmoke')) { 'the fuse no longer throws its smoke from CompTick' }
    $xml = New-Object System.Xml.XmlDocument
    $xml.Load((Join-Path $ModRoot 'Mod\Defs\FuseSmoke.xml'))
    $def = $xml.SelectSingleNode("//FleckDef[defName='FS_FuseSmoke']")
    if (-not $def) { 'Mod/Defs/FuseSmoke.xml has no FS_FuseSmoke'; return }
    $fade = [double]::Parse($def.SelectSingleNode('fadeInTime').InnerText, [Globalization.CultureInfo]::InvariantCulture)
    $delay = [int](Get-Text $standNode ".//launchDelay")
    $fuseSeconds = $delay / 60.0
    if ($fade -gt $fuseSeconds / 4) { "the smoke takes $fade s to fade in, more than a quarter of the $fuseSeconds s fuse: it would not show before the rocket leaves" }
    $solid = [double]::Parse($def.SelectSingleNode('solidTime').InnerText, [Globalization.CultureInfo]::InvariantCulture)
    if ($solid -lt $fuseSeconds) { "the smoke stays solid $solid s, less than the $fuseSeconds s fuse" }
    if ((Get-Text $standNode ".//smokeInterval") -and [int](Get-Text $standNode ".//smokeInterval") -lt 1) { 'smokeInterval is not positive' }
}

# =============================================================================================
Section 'The light, and the hook that makes it blink'
# =============================================================================================

It 'the game asks every IThingGlower comp on the building before lighting it' {
    # The hook the whole light rests on, and one the game documents nowhere: ShouldBeLitNow walks
    # parent.AllComps, tests each against IThingGlower, and gives up as soon as one says no. Read
    # off the compiled game rather than asserted in a comment.
    $cg = $byName['CompGlower']
    if (-not $cg) { 'the game has no CompGlower any more'; return }
    $p = $cg.GetProperty('ShouldBeLitNow', $BFi)
    if (-not $p) { 'CompGlower no longer exposes ShouldBeLitNow'; return }
    $refs = Get-Refs $p.GetGetMethod($true)
    if (@($refs | Where-Object { $_.Kind -eq 'type' -and $_.Member.Name -eq 'IThingGlower' }).Count -eq 0) {
        'it no longer tests anything against IThingGlower'
    }
    if (-not (Test-Calls $refs 'IThingGlower' 'ShouldBeLitNow')) { 'it never calls IThingGlower.ShouldBeLitNow' }
    if (-not (Test-Calls $refs 'ThingWithComps' 'get_AllComps')) {
        'it no longer walks the building''s comps, so only the Thing itself would be asked'
    }
}

It 'that same test consults neither fuel nor power, which is why the veto is needed' {
    # This is the reason a loaded stand would otherwise glow for ever: ShouldBeLitNow looks at
    # Spawned and at the flick switch, and at nothing else. If the game ever started consulting
    # fuel, the comp's veto would be doing work the game already does - worth knowing, not worth
    # guessing at.
    $cg = $byName['CompGlower']
    if (-not $cg) { 'the game has no CompGlower any more'; return }
    $refs = Get-Refs ($cg.GetProperty('ShouldBeLitNow', $BFi).GetGetMethod($true))
    foreach ($unwanted in 'CompRefuelable', 'CompPowerTrader') {
        if (@($refs | Where-Object { $_.Member.DeclaringType -and $_.Member.DeclaringType.Name -eq $unwanted }).Count -gt 0) {
            "it now consults $unwanted, so the comp's veto is no longer the only thing keeping an idle stand dark"
        }
    }
    if (-not (Test-Calls $refs 'Thing' 'get_Spawned')) {
        'it no longer checks Spawned, which is not fatal but means this reading is stale'
    }
}

It 'putting the light on the grid is a comparison, so the comp may call it at will' {
    # The mod calls UpdateLit at the two instants its answer changes and never on a tick. That is
    # only safe because UpdateLit compares the wanted state against its own before touching the
    # grid: if it stopped, the mod would be dirtying the map mesh twice a salvo.
    $cg = $byName['CompGlower']
    if (-not $cg) { 'the game has no CompGlower any more'; return }
    $m = $cg.GetMethod('UpdateLit', $BFi)
    if (-not $m) { 'CompGlower no longer exposes UpdateLit'; return }
    if (-not $m.IsPublic) { 'UpdateLit is no longer public, so the comp cannot call it' }
    $ps = @($m.GetParameters())
    if ($ps.Count -ne 1 -or $ps[0].ParameterType.Name -ne 'Map') { 'UpdateLit no longer takes a Map' }
    $refs = Get-Refs $m
    if (-not (Test-Calls $refs 'CompGlower' 'get_ShouldBeLitNow')) { 'UpdateLit no longer asks ShouldBeLitNow' }
    if (@($refs | Where-Object { $_.Kind -eq 'fld' -and $_.Member.Name -eq 'glowOnInt' }).Count -eq 0) {
        'UpdateLit no longer compares against its own state before acting'
    }
}

# =============================================================================================
Section 'telardo''s mod, reached by reflection and by name'
# =============================================================================================

It 'the three things the bridge looks up are there, under exactly those names' {
    # FireworksBridge asks for them by string. A rename on his side costs one warning in the log
    # and a stand that never fires; it cannot fail to build, because nothing here is compiled
    # against his assembly.
    if (-not $fwAsm) { "Fireworks 1.6 assembly not found under $Fireworks"; return }
    $t = $fwAsm.GetType('Fireworks.CompLaunchFireworks')
    if (-not $t) { 'Fireworks.CompLaunchFireworks is gone'; return }
    $m = $t.GetMethod('Launch', $BFpi)
    if (-not $m) { 'CompLaunchFireworks.Launch is no longer a public instance method' }
    else {
        $ps = @($m.GetParameters())
        if ($ps.Count -ne 1 -or $ps[0].ParameterType -ne [int]) {
            "Launch takes ($(($ps | ForEach-Object { $_.ParameterType.Name }) -join ', ')) rather than one int"
        }
    }
    $f = $t.GetField('launched', $BFpi)
    if (-not $f) { 'the launched field is no longer a public instance field' }
    elseif ($f.FieldType -ne [bool]) { "launched is a $($f.FieldType.Name) now" }
}

It 'that field is what stops a second salvo, so putting it back is what rearms the comp' {
    # The single mechanism this mod is built on. Launch reads launched on the way in and sets it on
    # the way out: one shot per comp, for ever, unless somebody puts it back. If he stops reading
    # it, the rearming becomes a no-op and the stand fires on his terms rather than the driver's.
    if (-not $fwAsm) { "Fireworks 1.6 assembly not found under $Fireworks"; return }
    $refs = Get-Refs ($fwAsm.GetType('Fireworks.CompLaunchFireworks').GetMethod('Launch', $BFi))
    $names = @($refs | Where-Object { $_.Kind -eq 'fld' -and $_.Member.Name -eq 'launched' }).Count
    if ($names -lt 2) { "Launch names launched $names time(s); it used to read it as a guard and set it at the end" }
}

It 'firing destroys nothing, which is what lets a building hold an item''s comp' {
    # His launcher is a single-use item. If Launch ever cleaned up after itself, the stand would
    # delete itself the first time a colonist watched.
    if (-not $fwAsm) { "Fireworks 1.6 assembly not found under $Fireworks"; return }
    $refs = Get-Refs ($fwAsm.GetType('Fireworks.CompLaunchFireworks').GetMethod('Launch', $BFi))
    foreach ($bad in 'Destroy', 'DeSpawn', 'SplitOff') {
        if (Test-Calls $refs 'Thing' $bad) { "Launch now calls Thing.$bad on something" }
    }
}

It 'firing makes no assumption about what is holding the comp' {
    # It reads its holder's position and its map, and nothing else. A cast to Building, or to his
    # own item class, would be the moment a stand stopped being a legal holder.
    if (-not $fwAsm) { "Fireworks 1.6 assembly not found under $Fireworks"; return }
    $refs = Get-Refs ($fwAsm.GetType('Fireworks.CompLaunchFireworks').GetMethod('Launch', $BFi))
    foreach ($r in $refs) {
        if ($r.Kind -ne 'type') { continue }
        $n = $r.Member.Name
        if ($n -eq 'Thing' -or $n -eq 'Object') { continue }
        "Launch casts its way to a $n, so it no longer takes just any holder"
    }
    if (-not (Test-Calls $refs 'Thing' 'get_DrawPos')) { 'Launch no longer reads its holder''s position' }
    if (-not (Test-Calls $refs 'Thing' 'get_Map'))     { 'Launch no longer reads its holder''s map' }
}

It 'the four memories the bridge hands out are still defs of his' {
    # Looked up with GetNamedSilentFail, so a rename costs no error whatsoever: colonists would
    # simply stop feeling anything about the show.
    $defs = Join-Path $fwVersion 'Defs'
    if (-not (Test-Path $defs)) { "no Defs folder under $fwVersion"; return }
    $text = (Get-ChildItem $defs -Recurse -Filter *.xml |
             ForEach-Object { Get-Content $_.FullName -Raw -Encoding UTF8 }) -join "`n"
    foreach ($name in 'TerribleFireworks', 'UnimpressiveFireworks', 'BeautifulFireworks', 'UnforgettableFireworks') {
        if ($text -cnotmatch "<defName>$name</defName>") { "no ThoughtDef named $name in his defs" }
    }
}

It 'the def the guard tests for is still his, and still the fuel this stand burns' {
    # Everything sits inside a PatchOperationConditional on FireworkLauncher. If he renames it,
    # this mod adds nothing at all - the designed failure, but it should be a known one rather
    # than a surprise. The same name is the stand's fuel filter, so it has to be a real item.
    $defs = Join-Path $fwVersion 'Defs'
    if (-not (Test-Path $defs)) { "no Defs folder under $fwVersion"; return }
    $guard = $patch.SelectSingleNode('//Operation/xpath')
    if (-not $guard) { 'the patch no longer carries a guard'; return }
    if ($guard.InnerText -cnotmatch 'FireworkLauncher') {
        "the guard tests $($guard.InnerText), which this test knows nothing about"; return
    }
    $found = $false
    foreach ($f in (Get-ChildItem $defs -Recurse -Filter *.xml)) {
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        if ($x.SelectSingleNode("//ThingDef[defName='FireworkLauncher']")) { $found = $true; break }
    }
    if (-not $found) { 'no ThingDef named FireworkLauncher in his defs: the patch would never apply' }
    $fuel = Get-Text $standNode './/fuelFilter/thingDefs/li'
    if ($fuel -cne 'FireworkLauncher') { "the stand burns $fuel, which is not what the guard tests for" }
}

It 'the texture the stand borrows is one of his, spelt his way' {
    # Compared segment by segment and case-sensitively. Windows finds Things/item/... for
    # Things/Item/..., so the mod would look fine here and show a missing texture on Linux.
    $tex = Get-Text $standNode 'graphicData/texPath'
    if (-not $tex) { 'the stand declares no texPath'; return }
    $root = Join-Path $fwVersion 'Textures'
    if (-not (Test-Path $root)) { $root = Join-Path $Fireworks 'Textures' }
    if (-not (Test-Path $root)) { "no Textures folder under $Fireworks"; return }
    $cur = Get-Item $root
    foreach ($seg in ($tex -split '/')) {
        $child = @(Get-ChildItem $cur.FullName | Where-Object { $_.Name -ceq $seg -or $_.BaseName -ceq $seg })
        if ($child.Count -eq 0) { "$tex : nothing named exactly '$seg' under $($cur.FullName)"; return }
        $cur = $child[0]
    }
}

# =============================================================================================
Section 'The recreation type, traced to what counts it'
# =============================================================================================

It 'no setting in these defs is one the game stopped reading' {
    # The game keeps public fields nothing reads any more. They load without a murmur and do
    # nothing, which is the quietest way for a def to be wrong.
    if ($written.Count -eq 0) { 'no field was resolved at all, which cannot be right'; return }
    foreach ($k in ($written.Values | Sort-Object -Unique)) {
        if ((Get-Readers $k).Count -eq 0) { "$k : nothing in the game reads it" }
    }
}

It 'every setting on the joy giver is read by the giver class the def names' {
    # unroofedOnly and desireSit belong to one particular giver. Point the def at another class
    # and they stay in the XML, stay unread, and the stand gets used under a roof by colonists
    # dragging chairs about.
    # The def now names this mod's own giver, a subclass of the vanilla one: the settings are still read
    # by the vanilla ancestors, so the family is walked from the mod's class upwards.
    $t = $giverType
    if (-not $t) { "no class named $giverClassName"; return }
    $family = Get-Ancestry $t
    $family['JoyGiverDef'] = $true      # giverClass itself is read by JoyGiverDef.Worker
    $checked = 0
    foreach ($k in ($written.Values | Sort-Object -Unique)) {
        if ($k -notlike 'JoyGiverDef.*') { continue }
        $rs = Get-Readers $k
        if ($rs.Count -eq 0) { continue }       # the test above owns that case
        $checked++
        if (@($rs | Where-Object { $family.ContainsKey($_) }).Count -eq 0) {
            "$k is read by $(Show-Readers $rs) - none of them $giverClassName or above it"
        }
    }
    if ($checked -eq 0) { 'not one setting of the giver was checked, which cannot be right' }
}

It 'the recreation gained is credited under the job''s kind, and the map tally counts it' {
    # Why a new JoyKindDef is worth more than another piece of furniture. JoyUtility pays out
    # against the JOB's joyKind and builds the tally expectations are measured against from the
    # BUILDING's - two different fields, both needed, and a mod can easily set only one.
    if (-not (Get-Text $jobNode 'joyKind'))            { 'the job declares no joyKind' }
    if (-not (Get-Text $standNode 'building/joyKind')) { 'the building declares no joyKind' }
    # A hashtable and not a list of pairs: PowerShell flattens `foreach ($p in @(@('a','b')))`
    # into 'a' then 'b', and the test would compare a two-element array against nothing and fail
    # for a reason that has nothing to do with the mod.
    $mustBeReadBy = [ordered]@{
        'JobDef.joyKind'             = 'JoyUtility'
        'BuildingProperties.joyKind' = 'JoyUtility'
        'JoyKindDef.needsThing'      = 'JoyUtility'
    }
    foreach ($field in @($mustBeReadBy.Keys)) {
        $rs = Get-Readers $field
        if ($rs -notcontains $mustBeReadBy[$field]) {
            "$field is read by $(Show-Readers $rs), no $($mustBeReadBy[$field]) among them"
        }
    }
    # And the three places that name the kind have to name the same one.
    $k = Get-Text $kindNode 'defName'
    if (-not $k) { 'this mod declares no JoyKindDef, which is its whole contribution'; return }
    foreach ($where in 'job', 'giver', 'building') {
        $v = switch ($where) {
            'job'      { Get-Text $jobNode   'joyKind' }
            'giver'    { Get-Text $giverNode 'joyKind' }
            'building' { Get-Text $standNode 'building/joyKind' }
        }
        if ($v -cne $k) { "the $where names $v where the kind this mod adds is $k" }
    }
}

It 'the driver reads how long the watching lasts and how many may share it' {
    $t = $modAsm.GetType($driverClassName)
    if (-not $t) { $t = $byName[$driverClassName.Split('.')[-1]] }
    if (-not $t) { "no class named $driverClassName"; return }
    $family = Get-Ancestry $t
    foreach ($field in 'JobDef.joyDuration', 'JobDef.joyMaxParticipants') {
        $short = $field.Split('.')[1]
        if (-not (Get-Text $jobNode $short)) { "the job declares no $short"; continue }
        $rs = Get-Readers $field
        if (@($rs | Where-Object { $family.ContainsKey($_) }).Count -eq 0) {
            "$field is read by $(Show-Readers $rs) - none of them $($t.Name) or above it"
        }
    }
}

# =============================================================================================
Section 'The numbers, against the vanilla defs on the same classes'
# =============================================================================================

It 'the watching lasts what vanilla''s jobs on this driver last' {
    $mine = Get-Text $jobNode 'joyDuration'
    if (-not $mine) { 'the job declares no joyDuration'; return }
    $cousins = @($vanillaJobs.GetEnumerator() | Where-Object { $_.Value.Driver -like '*JobDriver_WatchBuilding' -and $_.Value.Duration })
    if ($cousins.Count -eq 0) { 'no vanilla job runs on JobDriver_WatchBuilding, so there is nothing to compare with'; return }
    $values = @($cousins | ForEach-Object { [int]$_.Value.Duration } | Sort-Object -Unique)
    if ([int]$mine -lt $values[0] -or [int]$mine -gt $values[-1]) {
        "$mine ticks, where $($cousins.Count) vanilla job(s) on this driver use $($values -join ', ')"
    }
}

It 'the audience is bigger than vanilla''s, deliberately, and not by an order of magnitude' {
    # The same rule as the standing distance below, and for the same reason: a firework show is a
    # public event where everything vanilla watches is furniture. Both numbers are meant to sit
    # above the game's, so neither test compares against the driver's own cousin - there is only
    # one, the telescope, and a telescope has one eyepiece. The comparison is against the whole
    # game, and the rule is that this mod may pass the ceiling but not double it. A 10 against
    # television's 8 is the intent; a 40 would be a typo.
    $mine = Get-Text $jobNode 'joyMaxParticipants'
    if (-not $mine) { 'the job declares no joyMaxParticipants'; return }
    $all = @($vanillaJobs.Values | Where-Object { $_.Participants } | ForEach-Object { [int]$_.Participants })
    if ($all.Count -eq 0) { 'no vanilla job sets it, so there is nothing to compare with'; return }
    $ceiling = ($all | Measure-Object -Maximum).Maximum
    if ([int]$mine -lt 1)               { "$mine, which would let nobody watch" }
    if ([int]$mine -gt $ceiling * 2)    { "$mine, where the most-shared vanilla recreation takes $ceiling" }
}

It 'the stand is picked about as often as vanilla''s buildings on this giver' {
    $mine = Get-Text $giverNode 'baseChance'
    if (-not $mine) { 'the giver declares no baseChance'; return }
    # The giver is this mod's own subclass, so its cousins are the vanilla givers of the nearest vanilla class.
    $cousins = @($vanillaGivers.GetEnumerator() | Where-Object { $_.Value.Giver -eq $giverVanillaName -and $_.Value.Chance })
    if ($cousins.Count -eq 0) { "no vanilla giver uses $giverVanillaName, so there is nothing to compare with"; return }
    $values = @($cousins | ForEach-Object { [double]$_.Value.Chance } | Sort-Object -Unique)
    if ([double]$mine -lt $values[0] -or [double]$mine -gt $values[-1]) {
        "$mine, where the vanilla givers on this class use $($values -join ', ')"
    }
}

It 'colonists stand further back than for a television, but not absurdly so' {
    # This one is allowed above vanilla's range - fireworks are watched from far away, and that is
    # a stated choice - but not silently, and not by an order of magnitude.
    $mine = Get-Text $standNode 'building/watchBuildingStandDistanceRange'
    if (-not $mine) { 'the stand declares no watchBuildingStandDistanceRange'; return }
    if ($vanillaWatch.Count -eq 0) { 'no vanilla building declares one, so there is nothing to compare with'; return }
    $mineMax = [double](($mine -split '~')[-1])
    $ceiling = (@($vanillaWatch.Values | ForEach-Object { [double](($_ -split '~')[-1]) }) | Measure-Object -Maximum).Maximum
    if ($mineMax -gt $ceiling * 2) { "$mine, where the furthest vanilla building is watched from $ceiling" }
}

# =============================================================================================

Write-Output ''
if ($script:failed -eq 0) { Write-Output "$($script:ran) tests, all passing." }
else                      { Write-Output "$($script:ran) tests, $($script:failed) failing." }

[System.AppDomain]::CurrentDomain.remove_AssemblyResolve($script:asmResolver)
exit ([int]($script:failed -gt 0))
