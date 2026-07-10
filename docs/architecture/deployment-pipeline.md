# Deployment Pipeline

DevForge 的核心不是一次執行大量安裝命令，而是一條可驗證、可中斷、可重複執行的部署流程。

## Pipeline

```text
Start
  │
  ├─ Check administrator permission
  ├─ Check Windows version
  ├─ Check network and package source
  ├─ Create execution log
  ├─ Resolve installation profile
  ├─ Execute independent modules
  ├─ Verify installed commands and versions
  ├─ Generate summary
  └─ Finish
```

## Profile

### Core

建立可投入開發的基本環境：

- Windows Terminal
- PowerShell 7
- Git for Windows
- VS Code
- Visual Studio 2026 Community
- WSL2 與 Ubuntu 當前 LTS
- Docker Engine / Compose
- Java / Node.js / .NET
- Codex CLI

### Productivity

安裝日常開發與文件工具：

- IntelliJ IDEA Community
- Notepad++
- WinMerge
- Postman
- Obsidian
- Draw.io Desktop
- Database .NET

### Optional

安裝依專案才需要的工具與服務：

- SSMS
- MySQL Workbench
- Oracle SQL Developer
- Oracle Database
- Redis
- MQTT Broker
- 其他 AI CLI

## Module contract

每個安裝模組應遵守以下規則：

1. 一個檔案只負責一項工具或一項明確能力。
2. 執行前先檢查是否已安裝。
3. 已符合需求時回報 `SKIP`，不得重複破壞設定。
4. 失敗時拋出明確錯誤，不可靜默略過。
5. 安裝完成後驗證命令、版本或必要檔案。
6. 不得把密碼、Token、API Key 或私鑰寫入儲存庫。

## Current status

目前已建立主流程、健康檢查、備份／還原骨架、共用 PowerShell Helper，以及 WSL 基礎初始化腳本。個別 Windows 軟體安裝模組將依優先順序逐步完成。
