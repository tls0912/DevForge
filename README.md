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
- WSL2 Ubuntu
- Git
- Docker Engine 與 Docker Compose
- Java、Node.js、Python 等開發執行環境
- Codex CLI 等 AI 開發工具
- 常用 IDE、編輯器與設定
- 資料庫與基礎服務的容器化部署

---

## 設計原則

### 1. Windows 仍是主要工作介面

DevForge 不要求離開 Windows 生態系。

Windows 負責：

- Visual Studio / VS Code
- SSMS、Oracle SQL Developer 等桌面工具
- PowerShell
- 檔案管理與日常操作

WSL 負責：

- Docker
- Git
- Java / Node.js / Python
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

### 4. 先建立穩定骨架，再逐步自動化

不是所有軟體都適合一開始就無人值守安裝。

DevForge 將依序發展：

1. 安裝清單與操作文件
2. 半自動安裝腳本
3. 一鍵部署
4. 健康檢查
5. 備份與還原
6. 版本升級與環境維護

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
├── windows/             # Windows 安裝與設定腳本
├── wsl/                 # WSL Ubuntu 初始化腳本
├── docker/              # Docker Compose / Stack 定義
├── vscode/              # VS Code 設定與擴充套件
├── powershell/          # PowerShell Profile 與模組
├── git/                 # Git 設定範本
├── ai/                  # Codex 等 AI 工具設定
├── templates/           # 不含敏感資料的設定範本
└── docs/                # 安裝、維護與故障排除文件
```

目前結構仍會依實際需求逐步調整。

---

## 預計支援內容

### Windows

- Windows Update 與必要功能確認
- WSL2
- Windows Terminal
- PowerShell 7
- Git for Windows
- VS Code
- Visual Studio
- 7-Zip
- Everything
- 常用資料庫管理工具

### WSL Ubuntu

- Git
- Docker Engine
- Docker Compose
- Node.js（nvm）
- Java
- Maven / Gradle
- Python
- Codex CLI
- 常用 Shell 工具

### Docker 服務

預計以 Docker Compose 管理常用開發服務：

- MySQL
- Microsoft SQL Server
- Oracle Database
- Redis
- MQTT Broker
- Dockge

是否啟用由使用者依需求選擇，不應預設全部啟動。

---

## 規劃中的命令

```powershell
# 建立完整開發環境
.\install.ps1

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
[OK] WSL2
[OK] Ubuntu
[OK] Git
[OK] Docker
[OK] Node.js
[OK] Codex CLI
[--] Windows Terminal 尚未安裝

Environment health: 87%
```

---

## 開發階段

### Phase 1 — 建立基準

- [x] 建立專案
- [x] 建立 README
- [ ] 整理軟體與版本清單
- [ ] 建立手動安裝檢查表
- [ ] 定義資料夾與設定保存策略

### Phase 2 — 核心自動化

- [ ] 建立 `install.ps1`
- [ ] 啟用並初始化 WSL2
- [ ] 建立 WSL 初始化腳本
- [ ] 安裝 Git、Node.js、Codex CLI
- [ ] 安裝 Docker Engine 與 Compose

### Phase 3 — 驗證與維護

- [ ] 建立 `doctor.ps1`
- [ ] 建立 `update.ps1`
- [ ] 建立日誌與錯誤處理
- [ ] 支援重複執行

### Phase 4 — 備份與復原

- [ ] 備份 Git、PowerShell、VS Code 等設定
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

現階段重點不是追求「一次包辦所有軟體」，而是先建立一套可靠、可閱讀、可驗證的部署骨架。安裝腳本會隨實際使用逐步擴充，避免把一鍵部署寫成一鍵製造事故。

---

## 名稱由來

**Forge** 代表鍛造。

DevForge 的目的，是將一台乾淨、尚未成形的電腦，透過可重複的流程，鍛造成穩定且熟悉的開發工作平台。
