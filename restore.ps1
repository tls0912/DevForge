[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Source
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path $Source)) {
    throw "找不到備份來源：$Source"
}

Write-Host "Restore source: $Source"
Write-Host '目前為還原流程骨架，後續將依設定類型逐項驗證後還原。'
Write-Host '預設不覆蓋既有設定，除非使用者明確確認。'
