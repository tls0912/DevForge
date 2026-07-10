[CmdletBinding()]
param(
    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'DevForge update pipeline'
Write-Host '------------------------'
Write-Host '此版本先提供更新流程骨架，後續將逐步加入：'
Write-Host '- Windows 套件更新'
Write-Host '- WSL 套件更新'
Write-Host '- Node.js LTS 與 Codex CLI 更新'
Write-Host '- Docker Engine 與 Compose 更新'
Write-Host '- VS Code Extensions 同步'

if ($WhatIf) {
    Write-Host '[WHATIF] 本次不會變更系統。'
}
