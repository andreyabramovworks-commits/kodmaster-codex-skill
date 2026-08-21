[CmdletBinding()]
param(
    [string]$OutputDirectory = (Join-Path ([Environment]::GetFolderPath('UserProfile')) 'Downloads')
)

$ErrorActionPreference = 'Stop'
$version = 'v4'
$repo = $PSScriptRoot
$skillSource = Join-Path $repo 'skills\kodmaster'
if (-not (Test-Path -LiteralPath (Join-Path $skillSource 'SKILL.md'))) {
    throw 'Canonical skill is missing.'
}

New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
$stageRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('kodmaster-release-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $stageRoot | Out-Null

function New-Zip([string]$SourceGlob, [string]$Destination) {
    if (Test-Path -LiteralPath $Destination) { Remove-Item -LiteralPath $Destination -Force }
    Compress-Archive -Path $SourceGlob -DestinationPath $Destination -CompressionLevel Optimal
}

try {
    $skillStage = Join-Path $stageRoot 'skill\kodmaster'
    New-Item -ItemType Directory -Path (Split-Path $skillStage) -Force | Out-Null
    Copy-Item -LiteralPath $skillSource -Destination $skillStage -Recurse
    New-Zip (Join-Path $stageRoot 'skill\*') (Join-Path $OutputDirectory "kodmaster-$version-skill.zip")

    $windowsStage = Join-Path $stageRoot 'windows'
    New-Item -ItemType Directory -Path (Join-Path $windowsStage 'skills') -Force | Out-Null
    Copy-Item -LiteralPath $skillSource -Destination (Join-Path $windowsStage 'skills\kodmaster') -Recurse
    foreach ($file in @('install-kodmaster.ps1','install-kodmaster.cmd','INSTALL.md','README.ru.md','LICENSE','THIRD_PARTY_NOTICES.md')) {
        Copy-Item -LiteralPath (Join-Path $repo $file) -Destination $windowsStage
    }
    New-Zip (Join-Path $windowsStage '*') (Join-Path $OutputDirectory "kodmaster-$version-codex-windows.zip")

    $pluginStage = Join-Path $stageRoot 'plugin\kodmaster'
    New-Item -ItemType Directory -Path (Join-Path $pluginStage 'skills') -Force | Out-Null
    Copy-Item -LiteralPath $skillSource -Destination (Join-Path $pluginStage 'skills\kodmaster') -Recurse
    Copy-Item -LiteralPath (Join-Path $repo '.codex-plugin') -Destination (Join-Path $pluginStage '.codex-plugin') -Recurse
    Copy-Item -LiteralPath (Join-Path $repo 'assets') -Destination (Join-Path $pluginStage 'assets') -Recurse
    foreach ($file in @('README.md','README.ru.md','INSTALL.md','LICENSE','THIRD_PARTY_NOTICES.md')) {
        Copy-Item -LiteralPath (Join-Path $repo $file) -Destination $pluginStage
    }
    New-Zip (Join-Path $stageRoot 'plugin\*') (Join-Path $OutputDirectory "kodmaster-$version-plugin.zip")
} finally {
    if (Test-Path -LiteralPath $stageRoot) { Remove-Item -LiteralPath $stageRoot -Recurse -Force }
}

Get-ChildItem -LiteralPath $OutputDirectory -Filter "kodmaster-$version-*.zip" | Select-Object Name,Length,FullName
