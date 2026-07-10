Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Test-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-CommandExists {
    param([Parameter(Mandatory)] [string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Write-InstallerStatus {
    param(
        [Parameter(Mandatory)] [ValidateSet('INFO', 'OK', 'SKIP', 'WARN', 'ERROR')]
        [string]$Level,
        [Parameter(Mandatory)] [string]$Message
    )

    Write-Host ("[{0}] {1}" -f $Level, $Message)
}

function Assert-Administrator {
    if (-not (Test-Administrator)) {
        throw '此安裝模組需要系統管理員權限。'
    }
}

function Invoke-NativeCommand {
    param(
        [Parameter(Mandatory)] [string]$FilePath,
        [string[]]$ArgumentList = @()
    )

    & $FilePath @ArgumentList

    if ($LASTEXITCODE -ne 0) {
        throw "指令執行失敗，ExitCode=$LASTEXITCODE：$FilePath $($ArgumentList -join ' ')"
    }
}
