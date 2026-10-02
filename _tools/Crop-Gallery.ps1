<#
.SYNOPSIS
  Crops the raw pictures of the vitrine pass into the Workshop gallery images (PUBLICATION.md, "Gallery").

.DESCRIPTION
  The game cannot zoom past its maximum (Pickle's own "zoom all the way in" stops at RootSize 12; the game's own floor
  is 11, and nothing promises it stays sane below that; the run's screen is a fixed 1920x1080, xvfb-run's, not a Pickle
  setting - PickleTools, 2026-09-27). At that zoom the stand is about 65 px wide: a 16:9 crop tight enough to fill half
  the window's height (the owner's rule) is far smaller than 1280x720, so it is scaled back up. The owner chose this
  over a bigger stand (capture 6 already had its box overflowing its cell) or a higher run resolution (a shared script
  outside this mod, 2026-09-27). The scale-up uses nearest-neighbour (`flags=neighbor`), not a smoothing filter: the
  game is pixel art, so a sharp, blocky enlargement reads better than a blurred one.

  -From is a folder of jpeg or png pictures (Tests/Pickle/runs/<run>/), -To the destination (Gallery/ at the root, or a
  scratch folder to look first). The output files are numbered in the order they go on the Steam page. The crop (and
  scale, when the entry has one) is the table below, matched on the scenario name in the file name; it is read off the
  pictures, so it is to be re-read after a change of camera or of zoom in 14-gallery.feature.
#>
param(
    [Parameter(Mandatory)] [string] $From,
    [Parameter(Mandatory)] [string] $To
)
$ErrorActionPreference = 'Stop'

# number, file-name pattern, output name, crop as "w:h:x:y" in the 1920x1080 window, optional Scale ("outW:outH") when
# the crop is tighter than 1280x720 and has to be enlarged back up to it
$plan = @(
    @{ N = '1'; Match = 'gallery-03b*';  Name = 'the-audience';         Crop = '1280:720:320:225' },
    @{ N = '2'; Match = 'gallery-01*';   Name = 'the-fuse-smoking';     Crop = '256:144:832:553';  Scale = '1280:720' },
    @{ N = '3'; Match = 'gallery-02*';   Name = 'the-launch';           Crop = '256:144:832:553';  Scale = '1280:720' },
    @{ N = '4'; Match = 'gallery-04b*';  Name = 'the-burst-at-night';   Crop = '1280:720:320:65' },
    @{ N = '5'; Match = 'gallery-05*';   Name = 'the-reload-countdown'; Crop = '1254:705:0:340' },
    @{ N = '6'; Match = 'gallery-06*';   Name = 'the-blueprint';        Crop = '1254:705:0:340' }
)

New-Item -ItemType Directory -Force $To | Out-Null

# Image 0: a plain copy of Mod/About/Preview.png (the Steam capsule image, with its own ModIcon corner badge),
# always first on the Workshop page (owner's rule, 2026-09-29).
$previewSrc = Join-Path $PSScriptRoot '..\Mod\About\Preview.png'
Copy-Item $previewSrc (Join-Path $To '0-preview.png') -Force
"0-preview.png  <-  Preview.png"

foreach ($p in $plan) {
    $src = Get-ChildItem $From -File | Where-Object { $_.Name -like $p.Match -and $_.Extension -in '.jpg', '.jpeg', '.png' } | Select-Object -First 1
    if (-not $src) { Write-Warning "no picture for $($p.N) $($p.Match) in $From"; continue }
    $out = Join-Path $To ("{0}-{1}.jpg" -f $p.N, $p.Name)
    $w, $h, $x, $y = $p.Crop.Split(':')
    $vf = "crop=${w}:${h}:${x}:${y}"
    if ($p.Scale) {
        $sw, $sh = $p.Scale.Split(':')
        $vf += ",scale=${sw}:${sh}:flags=neighbor"
    }
    & ffmpeg -v error -y -i $src.FullName -vf $vf -q:v 2 $out
    if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed on $($src.Name)" }
    "{0}  <-  {1}" -f (Split-Path $out -Leaf), $src.Name
}
