param(
    [Parameter(Mandatory=$true)]
    [int]$Module
)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$num = "{0:D2}" -f $Module
$moduleDir = Get-ChildItem "$root\learning-modules" -Directory |
    Where-Object { $_.Name -like "Module-$num-*" } |
    Select-Object -First 1
if (-not $moduleDir) { throw "Module $num not found." }
$stage = Join-Path $moduleDir.FullName "stage"
if (-not (Test-Path $stage)) {
    Write-Host "Module $num has no stage. Use its examples directly."
    exit 0
}
$live = Join-Path $root "kubernetes-live\manifests"
New-Item -ItemType Directory -Force -Path $live | Out-Null
Get-ChildItem $live -File | Where-Object { $_.Name -ne ".gitkeep" } | Remove-Item -Force
Copy-Item "$stage\*" $live -Recurse -Force
Write-Host "Loaded $($moduleDir.Name)"
Get-ChildItem $live
