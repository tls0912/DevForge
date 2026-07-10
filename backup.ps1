[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $PSScriptRoot 'backup')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$target = Join-Path $Destination $timestamp

New-Item -ItemType Directory -Path $target -Force | Out-Null

Write-Host "Backup target: $target"
Write-Host '目前為備份流程骨架，後續預計納入：'
Write-Host '- Git 設定'
Write-Host '- PowerShell Profile'
Write-Host '- Windows Terminal 設定'
Write-Host '- VS Code settings / keybindings / extensions'
Write-Host '- WSL Shell 設定'
Write-Host '- Docker Compose 定義'
Write-Host ''
Write-Host '密碼、Token、API Key 與私鑰不會預設納入備份。'
