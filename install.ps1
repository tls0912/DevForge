[CmdletBinding()]
param(
    [ValidateSet('Core', 'Productivity', 'Optional', 'Full')]
    [string]$Profile = 'Core',

    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$LogDirectory = Join-Path $ProjectRoot 'logs'
$LogFile = Join-Path $LogDirectory ("install-{0:yyyyMMdd-HHmmss}.log" -f (Get-Date))

function Write-Step {
    param(
        [Parameter(Mandatory)]
        [string]$Message
    )

    $line = "[{0:HH:mm:ss}] {1}" -f (Get-Date), $Message
    Write-Host $line
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
}

function Test-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-ModuleScript {
    param(
        [Parameter(Mandatory)]
        [string]$RelativePath
    )

    $scriptPath = Join-Path $ProjectRoot $RelativePath

    if (-not (Test-Path $scriptPath)) {
        Write-Step "[SKIP] 尚未建立模組：$RelativePath"
        return
    }

    Write-Step "[RUN ] $RelativePath"

    if ($WhatIf) {
        Write-Step "[WHATIF] 不實際執行。"
        return
    }

    & $scriptPath
}

New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null

Write-Step "DevForge installation started. Profile=$Profile"
Write-Step "Project root: $ProjectRoot"

if (-not (Test-Administrator)) {
    throw '請使用系統管理員權限執行 PowerShell。'
}

if ([Environment]::OSVersion.Version.Major -lt 10) {
    throw 'DevForge 僅支援 Windows 11。'
}

$profiles = @{
    Core = @(
        'scripts/windows/install-terminal.ps1',
        'scripts/windows/install-powershell.ps1',
        'scripts/windows/install-git.ps1',
        'scripts/windows/install-vscode.ps1',
        'scripts/windows/install-wsl.ps1'
    )
    Productivity = @(
        'scripts/windows/install-notepadpp.ps1',
        'scripts/windows/install-winmerge.ps1',
        'scripts/windows/install-postman.ps1',
        'scripts/windows/install-obsidian.ps1'
    )
    Optional = @(
        'scripts/windows/install-database-net.ps1',
        'scripts/windows/install-ssms.ps1',
        'scripts/windows/install-mysql-workbench.ps1',
        'scripts/windows/install-oracle-sqldeveloper.ps1'
    )
}

$selectedGroups = switch ($Profile) {
    'Core' { @('Core') }
    'Productivity' { @('Productivity') }
    'Optional' { @('Optional') }
    'Full' { @('Core', 'Productivity', 'Optional') }
}

foreach ($group in $selectedGroups) {
    Write-Step "Profile group: $group"

    foreach ($module in $profiles[$group]) {
        Invoke-ModuleScript -RelativePath $module
    }
}

Write-Step 'DevForge installation pipeline completed.'
Write-Step '目前為初始骨架；尚未建立的安裝模組會標示為 SKIP。'
