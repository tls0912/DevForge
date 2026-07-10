# DevForge

> 從一台乾淨的 Windows 電腦，快速鍛造成可投入工作的開發環境。

DevForge 是一套以 **Windows 11 + WSL2** 為核心的開發環境自動化專案。

它的目標不是單純安裝幾個工具，而是把個人的開發環境轉化為一套：

- 可重複部署
- 可驗證
- 可維護
- 可備份與還原
- 可逐步擴充

的 **Developer Infrastructure**。

---

## 專案目標

理想流程如下：

```powershell
git clone https://github.com/tls0912/DevForge.git
cd DevForge
.\install.ps1
```

安裝完成後，一台乾淨的 Windows 電腦應具備一致且可用的開發環境，包括：

- Windows 基礎開發工具
- PowerShell 與終端機環境
- WSL2 Ubuntu 當前 LTS
- Git 與 GitHub CLI
- Docker Engine、Docker Compose 與 Dockge
- Java、Node.js 與 .NET 開發環境
- Codex CLI 等 AI 開發工具
- 常用 IDE、編輯器與文件工具
- 資料庫管理工具與容器化服務

---

## 設計原則

### 1. Windows 仍是主要工作介面

DevForge 不要求離開 Windows 生態系。

Windows 負責：

- Visual Studio / VS Code / IntelliJ IDEA
- SSMS、Oracle SQL Developer、Database .NET 等桌面工具
- PowerShell
- 檔案管理與日常操作
- 文件、API 測試與差異比對

WSL 負責：

- Docker
- Git
- Java / Node.js / .NET
- Linux Shell 工具
- Codex CLI 與其他 AI Agent

### 2. 可重複執行

安裝腳本應盡量具備冪等性：

- 已安裝的工具不重複安裝
- 已存在的設定不任意覆蓋
- 執行失敗時能指出明確原因
- 可安全地再次執行

### 3. 設定與資料分離

DevForge 管理安裝流程與設定，但不應將下列敏感資料直接提交到 Git：

- 密碼
- API Key
- 私鑰
- 公司內部連線資訊
- 個人資料庫備份

敏感設定應透過環境變數、範本檔或本機私有設定注入。

### 4. 模組化安裝

每一項工具應有獨立安裝模組，再由主要入口統一調度。

例如：

```text
scripts/windows/install-terminal.ps1
scripts/windows/install-vscode.ps1
scripts/wsl/install-java.sh
scripts/wsl/install-node.sh
scripts/wsl/install-codex.sh
scripts/docker/install-engine.sh
```

這樣未來更換版本或替換工具時，只需修改對應模組，不必重寫整套安裝流程。

### 5. 先建立穩定骨架，再逐步自動化

不是所有軟體都適合一開始就無人值守安裝。

DevForge 將依序發展：

1. 安裝清單與操作文件
2. 半自動安裝腳本
3. 一鍵部署
4. 健康檢查
5. 備份與還原
6. 版本升級與環境維護

---

## 安裝 Profile

DevForge 預計提供不同安裝層級，避免所有軟體一次全裝。

### Core

重灌後優先完成，讓電腦能快速投入開發：

- Windows Terminal
- PowerShell 7
- Git for Windows
- Git Credential Manager
- VS Code
- Visual Studio 2026 Community
- WSL2
- Ubuntu 當前 LTS
- Docker Engine
- Docker Compose
- OpenJDK 21 LTS
- Node.js LTS
- .NET SDK
- Codex CLI
- 7-Zip

### Productivity

日常開發與文件處理工具：

- IntelliJ IDEA Community
- Notepad++
- WinMerge
- Postman
- Obsidian
- Draw.io Desktop
- Microsoft Office
- Database .NET

### Optional

依專案需求安裝：

- MySQL Workbench
- Oracle SQL Developer
- SQL Server Management Studio
- Oracle Database
- Redis
- MQTT Broker
- Claude Code
- Gemini CLI
- Aider
- OpenHands

預計支援：

```powershell
.\install.ps1 -Profile Core
.\install.ps1 -Profile Productivity
.\install.ps1 -Profile Full
```

---

## 預計專案結構

```text
DevForge/
├── README.md
├── install.ps1          # Windows 端主要安裝入口
├── update.ps1           # 更新已安裝工具與設定
├── doctor.ps1           # 開發環境健康檢查
├── backup.ps1           # 備份設定與必要資料
├── restore.ps1          # 還原設定
│
├── scripts/
│   ├── windows/         # Windows 安裝與設定腳本
│   ├── wsl/             # WSL Ubuntu 初始化腳本
│   ├── docker/          # Docker 安裝與服務部署
│   ├── vscode/          # VS Code 擴充套件與設定
│   └── ai/              # Codex 與其他 AI 工具
│
├── configs/
│   ├── git/             # Git 設定範本
│   ├── terminal/        # Windows Terminal 設定
│   ├── powershell/      # PowerShell Profile 與模組
│   └── vscode/          # VS Code settings / keybindings / snippets
│
├── docker/
│   ├── mysql/
│   ├── mssql/
│   ├── oracle/
│   ├── mqtt/
│   ├── redis/
│   └── dockge/
│
├── templates/           # 不含敏感資料的設定範本
├── backup/              # 本機備份輸出位置，不提交大型或敏感資料
└── docs/                # 安裝、維護與故障排除文件
```

目前結構仍會依實際需求逐步調整。

---

## 預計支援內容

### Windows 基礎環境

- Windows 11 Pro
- Windows Update
- 必要硬體驅動
- Windows Terminal
- PowerShell 7
- Google Chrome

### Windows 工具

- 7-Zip
- Notepad++
- WinMerge

### IDE 與編輯器

- Visual Studio 2026 Community
- VS Code
- IntelliJ IDEA Community

### VS Code Extensions

- C#
- Extension Pack for Java
- Docker
- GitLens
- Markdown All in One
- YAML
- XML
- EditorConfig
- Error Lens
- REST Client
- Draw.io Integration
- PlantUML
- Remote - WSL

### Git 與版本控制

- Git for Windows
- Git Credential Manager
- GitHub CLI (`gh`)
- `.gitconfig`
- SSH Key 設定
- Windows OpenSSH Client
- Windows OpenSSH Server（選配）

### WSL Ubuntu

- Ubuntu 當前 LTS
- git
- curl
- wget
- tree
- jq
- build-essential
- p7zip-full
- vim
- nano
- less
- htop
- dos2unix

其中 `p7zip-full` 提供 Linux 環境的 7-Zip；`dos2unix` 用於處理 Windows 與 Linux 間的換行格式差異。

### Node.js

- nvm
- Node.js LTS
- npm

### Java

- OpenJDK 21 LTS
- Maven
- Gradle
- JAVA_HOME

### .NET

Windows：

- .NET SDK
- .NET Framework 4.8 Developer Pack

WSL：

- .NET SDK

### AI 開發工具

主要：

- Codex CLI

預留：

- Claude Code
- Gemini CLI
- Aider
- OpenHands

### Docker

WSL：

- Docker Engine
- Docker Compose
- Dockge

預設服務：

- MySQL
- Microsoft SQL Server
- MQTT Broker
- Redis（選配）
- Oracle Database（選配）

是否啟用由使用者依需求選擇，不應預設全部啟動。

### 資料庫管理工具

- SQL Server Management Studio
- MySQL Workbench
- Oracle SQL Developer
- Database .NET

### API 與文件工具

- Postman
- Obsidian
- Draw.io Desktop
- Microsoft Office

---

## 明確不納入的項目

目前不列入 DevForge 標準安裝範圍：

- Everything
- PowerToys
- Linux unzip
- Linux zip
- Python
- DBeaver
- Wireshark

後續若有明確需求，再以 Optional 模組加入，而不是預設安裝。

---

## 設定同步與還原

### Git

- `.gitconfig`
- SSH Key 設定流程
- Git Credential Manager 設定

### VS Code

- `settings.json`
- `keybindings.json`
- snippets
- extensions 清單

### Windows Terminal

- Profiles
- Theme
- 預設 Shell

### PowerShell

- `$PROFILE`
- 常用 Alias
- 必要模組

### WSL

- `.bashrc`
- nvm 設定
- Git 設定
- Shell 工具設定

---

## 規劃中的命令

```powershell
# 建立核心開發環境
.\install.ps1 -Profile Core

# 安裝日常工具
.\install.ps1 -Profile Productivity

# 安裝完整環境
.\install.ps1 -Profile Full

# 檢查環境狀態
.\doctor.ps1

# 更新工具與設定
.\update.ps1

# 備份本機開發設定
.\backup.ps1

# 還原開發設定
.\restore.ps1
```

`doctor.ps1` 預計輸出類似：

```text
[OK] Windows 11
[OK] PowerShell 7
[OK] Windows Terminal
[OK] WSL2
[OK] Ubuntu LTS
[OK] Git
[OK] Docker
[OK] Java
[OK] Node.js
[OK] .NET SDK
[OK] Codex CLI
[--] IntelliJ IDEA 尚未安裝

Environment health: 92%
```

---

## 開發階段

### Phase 1 — 建立基準

- [x] 建立專案
- [x] 建立 README
- [x] 整理初版軟體清單
- [ ] 建立手動安裝檢查表
- [ ] 定義版本管理策略
- [ ] 定義資料夾與設定保存策略

### Phase 2 — 核心自動化

- [ ] 建立 `install.ps1`
- [ ] 建立 Profile 機制
- [ ] 啟用並初始化 WSL2
- [ ] 安裝 Ubuntu 當前 LTS
- [ ] 建立 WSL 初始化腳本
- [ ] 安裝 Git、Node.js、Java、.NET 與 Codex CLI
- [ ] 安裝 Docker Engine、Compose 與 Dockge

### Phase 3 — Windows 工具自動化

- [ ] 安裝 Windows Terminal 與 PowerShell 7
- [ ] 安裝 VS Code 與擴充套件
- [ ] 安裝 Visual Studio 2026 Community
- [ ] 安裝 IntelliJ IDEA Community
- [ ] 安裝 Notepad++、WinMerge、Postman、Obsidian
- [ ] 安裝資料庫管理工具

### Phase 4 — 驗證與維護

- [ ] 建立 `doctor.ps1`
- [ ] 建立 `update.ps1`
- [ ] 建立日誌與錯誤處理
- [ ] 支援重複執行
- [ ] 驗證版本與 PATH

### Phase 5 — 備份與復原

- [ ] 備份 Git、PowerShell、VS Code 與 Terminal 設定
- [ ] 管理 Docker Compose 與 Volume 備份
- [ ] 建立 `backup.ps1`
- [ ] 建立 `restore.ps1`

---

## 安全注意事項

請勿將以下內容提交至儲存庫：

```text
.env
*.key
*.pem
id_rsa
id_ed25519
API Key
資料庫密碼
公司內部帳號與位址
```

後續將提供 `.gitignore` 與 `.env.example` 作為標準範本。

---

## 專案狀態

DevForge 目前處於早期規劃與基礎建設階段。

現階段重點不是追求「一次包辦所有軟體」，而是先建立一套可靠、可閱讀、可驗證、可維護的部署骨架。安裝腳本會隨實際使用逐步擴充，避免把一鍵部署寫成一鍵製造事故。

---

## 名稱由來

**Forge** 代表鍛造。

DevForge 的目的，是將一台乾淨、尚未成形的電腦，透過可重複的流程，鍛造成穩定且熟悉的開發工作平台。
