<#
.SYNOPSIS
  Crops the raw pictures of the vitrine pass into the Workshop gallery images (PUBLICATION.md, "Gallery").

.DESCRIPTION
  The game cannot zoom past its maximum, so a picture whose subject has to fill enough of the window is cropped around it.
  Each crop is 16:9 (Steam shows the gallery in that shape) and leaves out the studio's alerts, the letters on the right
  edge and the colonist bar. Native pixels only: nothing is scaled up.

  -From is a folder of jpeg or png pictures (Tests/Pickle/runs/<run>/), -To the destination (Gallery/ at the root, or a
  scratch folder to look first). The output files are numbered in the order they go on the Steam page. The crop of each
  picture is the table below, matched on the scenario name in the file name; it is read off the pictures, so it is to be
  re-read after a change of camera or of zoom in 14-gallery.feature.
#>
param(
    [Parameter(Mandatory)] [string] $From,
    [Parameter(Mandatory)] [string] $To
)
$ErrorActionPreference = 'Stop'

# number, file-name pattern, output name, crop as "w:h:x:y" in the 1920x1080 window
$plan = @(
    @{ N = '01'; Match = 'gallery-03b*';  Name = 'the-audience';                     Crop = '1280:720:320:225' },
    @{ N = '02'; Match = 'gallery-01*';   Name = 'the-fuse-smoking';                 Crop = '1280:720:320:225' },
    @{ N = '03'; Match = 'gallery-02*';   Name = 'the-launch';                       Crop = '1280:720:320:225' },
    @{ N = '04'; Match = 'gallery-04b*';  Name = 'the-burst-at-night';               Crop = '1280:720:320:225' },
    @{ N = '05'; Match = 'gallery-05*';   Name = 'the-reload-countdown';             Crop = '1254:705:0:340' },
    @{ N = '06'; Match = 'gallery-06*';   Name = 'the-blueprint';                    Crop = '1254:705:0:340' }
)

New-Item -ItemType Directory -Force $To | Out-Null
foreach ($p in $plan) {
    $src = Get-ChildItem $From -File | Where-Object { $_.Name -like $p.Match -and $_.Extension -in '.jpg', '.jpeg', '.png' } | Select-Object -First 1
    if (-not $src) { Write-Warning "no picture for $($p.N) $($p.Match) in $From"; continue }
    $out = Join-Path $To ("{0}-{1}.jpg" -f $p.N, $p.Name)
    $w, $h, $x, $y = $p.Crop.Split(':')
    & ffmpeg -v error -y -i $src.FullName -vf "crop=${w}:${h}:${x}:${y}" -q:v 2 $out
    if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed on $($src.Name)" }
    "{0}  <-  {1}" -f (Split-Path $out -Leaf), $src.Name
}
