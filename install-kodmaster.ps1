[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$Uninstall,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$source = Join-Path $PSScriptRoot 'skills\kodmaster'
$targetRoot = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.agents\skills'
$target = Join-Path $targetRoot 'kodmaster'

function Confirm-Action([string]$Prompt) {
    if ($Force) { return $true }
    return ((Read-Host "$Prompt [y/N]") -match '^(?i:y|yes|д|да)$')
}

if ($Uninstall) {
    if (-not (Test-Path -LiteralPath $target)) {
        Write-Host "KodMaster is not installed: $target"
        exit 0
    }
    if (-not (Confirm-Action "Remove $target?")) { Write-Host 'Cancelled.'; exit 0 }
    if ($PSCmdlet.ShouldProcess($target, 'Uninstall KodMaster')) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
    Write-Host 'UNINSTALL COMPLETE'
    exit 0
}

if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md'))) {
    throw "Package is incomplete: skills\kodmaster\SKILL.md was not found next to the installer."
}

if ($WhatIfPreference) {
    Write-Host "WHAT IF: validate $source and install KodMaster v4 to $target"
    exit 0
}

New-Item -ItemType Directory -Path $targetRoot -Force | Out-Null
$stage = Join-Path $targetRoot ('.kodmaster-stage-' + [Guid]::NewGuid().ToString('N'))
$old = Join-Path $targetRoot ('.kodmaster-old-' + [Guid]::NewGuid().ToString('N'))

try {
    Copy-Item -LiteralPath $source -Destination $stage -Recurse -Force
    $validator = Join-Path $stage 'scripts\validate_skill.py'
    $python = Get-Command python -ErrorAction SilentlyContinue
    $pythonWorks = $false
    if ($python -and $python.Source -notlike '*\WindowsApps\python.exe') {
        try {
            & $python.Source --version *> $null
            $pythonWorks = ($LASTEXITCODE -eq 0)
        } catch {
            $pythonWorks = $false
        }
    }
    if ($pythonWorks -and (Test-Path -LiteralPath $validator)) {
        & $python.Source $validator
        if ($LASTEXITCODE -ne 0) { throw 'Skill validation failed.' }
    } else {
        Write-Host 'Python is unavailable; structural validation only.'
    }

    if ($PSCmdlet.ShouldProcess($target, 'Install KodMaster v4')) {
        if (Test-Path -LiteralPath $target) { Move-Item -LiteralPath $target -Destination $old }
        Move-Item -LiteralPath $stage -Destination $target
        if (Test-Path -LiteralPath $old) { Remove-Item -LiteralPath $old -Recurse -Force }
    } else {
        Remove-Item -LiteralPath $stage -Recurse -Force
    }
} catch {
    if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
    if ((Test-Path -LiteralPath $old) -and -not (Test-Path -LiteralPath $target)) {
        Move-Item -LiteralPath $old -Destination $target
    }
    throw
}

if (-not $WhatIfPreference) {
    Write-Host ''
    Write-Host 'INSTALLATION COMPLETE'
    Write-Host "Installed to: $target"
    Write-Host 'Start a new Codex task. If the skill is not visible, restart Codex once.'
}
