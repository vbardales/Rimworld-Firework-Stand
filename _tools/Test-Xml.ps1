param([string]$ModRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference = 'Stop'
$files = @(Get-ChildItem (Join-Path $ModRoot 'Mod') -Recurse -Filter *.xml)
foreach ($file in $files) {
    $doc = New-Object System.Xml.XmlDocument
    $doc.Load($file.FullName)
    if ($doc.DocumentElement.Name -eq 'LanguageData') {
        $seen = @{}
        foreach ($entry in $doc.LanguageData.ChildNodes | Where-Object NodeType -eq Element) {
            if ($seen.ContainsKey($entry.Name)) { throw "Duplicate translation in ${file}: $($entry.Name)" }
            $seen[$entry.Name] = $true
            if ([string]::IsNullOrWhiteSpace($entry.InnerText)) { throw "Empty translation in ${file}: $($entry.Name)" }
        }
    }
}
[xml]$about = Get-Content (Join-Path $ModRoot 'Mod/About/About.xml') -Raw
if ($about.ModMetaData.description -notmatch [regex]::Escape($about.ModMetaData.url)) {
    throw 'The description must include the GitHub source URL.'
}
[xml]$en = Get-Content (Join-Path $ModRoot 'Mod/Languages/English/Keyed/FireworkStand.xml') -Raw
[xml]$fr = Get-Content (Join-Path $ModRoot 'Mod/Languages/French/Keyed/FireworkStand.xml') -Raw
$keys = @($en.LanguageData.ChildNodes | Where-Object NodeType -eq Element | ForEach-Object Name)
$frKeys = @($fr.LanguageData.ChildNodes | Where-Object NodeType -eq Element | ForEach-Object Name)
$sourceKeys = @(Get-ChildItem (Join-Path $ModRoot 'Source') -Filter *.cs | ForEach-Object {
    [regex]::Matches((Get-Content $_.FullName -Raw), '"(FireworkStand\.[^"]+)"\.Translate\(') | ForEach-Object { $_.Groups[1].Value }
} | Sort-Object -Unique)
if (Compare-Object $sourceKeys $keys) { throw 'Owned Keyed entries differ from Translate calls in source.' }
if (Compare-Object $keys $frKeys) { throw 'English and French translation keys differ.' }
foreach ($key in $keys) {
    $a = @([regex]::Matches($en.LanguageData[$key].InnerText, '\{\d+\}') | ForEach-Object Value)
    $b = @([regex]::Matches($fr.LanguageData[$key].InnerText, '\{\d+\}') | ForEach-Object Value)
    if (($a -join ',') -cne ($b -join ',')) { throw "Translation placeholders differ: $key" }
}
Write-Output "$($files.Count) XML files parsed; GitHub description link and EN/FR keys/placeholders valid."
