[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$checks = [System.Collections.Generic.List[object]]::new()

function Add-Check {
    param(
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [bool]$Passed,
        [string]$Detail = ''
    )

    $checks.Add([pscustomobject]@{
        Name   = $Name
        Passed = $Passed
        Detail = $Detail
    })
}

function Test-CommandExists {
    param([Parameter(Mandatory)] [string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

Add-Check 'Windows 11' ([Environment]::OSVersion.Version.Build -ge 22000) ([Environment]::OSVersion.VersionString)
Add-Check 'PowerShell 7' ($PSVersionTable.PSVersion.Major -ge 7) ($PSVersionTable.PSVersion.ToString())
Add-Check 'Windows Terminal' (Test-CommandExists 'wt')
Add-Check 'Git' (Test-CommandExists 'git')
Add-Check 'WSL' (Test-CommandExists 'wsl')
Add-Check 'Node.js' (Test-CommandExists 'node')
Add-Check 'npm' (Test-CommandExists 'npm')
Add-Check '.NET SDK' (Test-CommandExists 'dotnet')
Add-Check 'Codex CLI' (Test-CommandExists 'codex')
Add-Check 'VS Code' (Test-CommandExists 'code')

foreach ($check in $checks) {
    $status = if ($check.Passed) { '[OK]' } else { '[--]' }
    $detail = if ([string]::IsNullOrWhiteSpace($check.Detail)) { '' } else { " - $($check.Detail)" }
    Write-Host "$status $($check.Name)$detail"
}

$passed = @($checks | Where-Object Passed).Count
$total = $checks.Count
$health = if ($total -eq 0) { 0 } else { [math]::Round(($passed / $total) * 100) }

Write-Host ''
Write-Host "Environment health: $health% ($passed/$total)"

if ($passed -ne $total) {
    exit 1
}
