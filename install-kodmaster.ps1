[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$Uninstall,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$source = Join-Path $scriptDir "kodmaster"
if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md'))) {
    $source = Join-Path $scriptDir "skills\kodmaster"
}
$agentsRoot = Join-Path $HOME ".agents"
$skillsRoot = Join-Path $agentsRoot "skills"
$backupRoot = Join-Path $agentsRoot "skill-backups"
$target = Join-Path $skillsRoot "kodmaster"

if ($Uninstall) {
    if (-not (Test-Path -LiteralPath $target)) {
        Write-Host "KodMaster is not installed: $target"
        exit 0
    }
    if (-not $Force -and ((Read-Host "Remove $target? [y/N]") -notmatch '^(?i:y|yes|д|да)$')) {
        Write-Host 'Cancelled.'
        exit 0
    }
    if ($PSCmdlet.ShouldProcess($target, 'Uninstall KodMaster')) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
    Write-Host 'UNINSTALL COMPLETE'
    exit 0
}

if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md'))) { throw "KodMaster source folder was not found next to installer." }

New-Item -ItemType Directory -Force -Path $skillsRoot | Out-Null
New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null

# Codex scans every folder inside active skills. Never keep backups there.
Get-ChildItem -Path $skillsRoot -Directory -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -like "kodmaster.backup-*" -or $_.Name -like "kodmaster-old*" } |
    ForEach-Object { Remove-Item $_.FullName -Recurse -Force }

$legacyTargets = @(
    (Join-Path $HOME ".codex\skills\kodmaster"),
    (Join-Path $HOME ".codex\skills\kodmaster.backup"),
    (Join-Path $HOME ".agents\skills\kodmaster-old")
)
foreach ($legacy in $legacyTargets) {
    if ((Test-Path $legacy) -and ($legacy -ne $target)) { Remove-Item $legacy -Recurse -Force }
}

if (Test-Path $target) {
    $backup = Join-Path $backupRoot ("kodmaster-" + (Get-Date -Format "yyyyMMdd-HHmmss"))
    Move-Item $target $backup -Force
    Write-Host "Previous version backed up to: $backup"
}

Copy-Item $source $target -Recurse -Force

$skillFile = Join-Path $target "SKILL.md"
if (-not (Test-Path $skillFile)) { throw "Installation failed: SKILL.md is missing." }

$required = @(
    "references\rule-router.md",
    "rules\core.md",
    "rules\database.md",
    "rules\security.md",
    "rules\css-architecture.md",
    "rules\testing.md",
    "references\background-jobs-and-queues.md",
    "references\caching.md",
    "references\file-uploads-and-storage.md",
    "references\realtime.md",
    "references\browser-state-and-session.md",
    "tests\test_specs.py"
)
foreach ($relative in $required) {
    if (-not (Test-Path (Join-Path $target $relative))) { throw "Installation validation failed: missing $relative" }
}

$obsoletePattern = '(?<![A-Za-z0-9_])/plan(?![A-Za-z0-9_-])'
$obsolete = Get-ChildItem -Path $target -File -Recurse | Select-String -Pattern $obsoletePattern -ErrorAction SilentlyContinue
if ($obsolete) {
    $locations = ($obsolete | ForEach-Object { "$($_.Path):$($_.LineNumber)" }) -join ", "
    throw "Installation validation failed: obsolete standalone /plan command found at: $locations"
}

$python = Get-Command python -ErrorAction SilentlyContinue
if ($python) {
    & python (Join-Path $target "scripts\validate_skill.py")
    if ($LASTEXITCODE -ne 0) { throw "KodMaster validation failed." }
} else {
    Write-Host "Python not found: structural Python validation skipped."
}

Write-Host ""
Write-Host "KodMaster v4.1 installed: $target" -ForegroundColor Green
Write-Host "Rule Router: enabled"
Write-Host "Context Loading Policy: safety-first"
Write-Host "Restart Codex/ChatGPT Desktop completely and open a new session."
Write-Host "Test: `$kodmaster /kodhelp"
