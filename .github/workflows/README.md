# GitHub Actions 自動部署設置說明

## 概述
此 GitHub Actions 工作流程會在每次推送代碼到 `main` 分支時，自動在遠端伺服器上執行 Docker 重新部署。

## 設置步驟

### 1. 配置 GitHub Secrets
在您的 GitHub repository 中設置以下 Secrets：

1. 前往 GitHub repository
2. 點擊 **Settings** > **Secrets and variables** > **Actions**
3. 點擊 **New repository secret** 並添加以下變數：

| Secret 名稱 | 描述 | 範例值 |
|------------|------|--------|
| `SERVER_HOST` | 伺服器 IP 位址或域名 | `192.168.1.100` 或 `example.com` |
| `SERVER_USER` | SSH 登入用戶名 | `ubuntu` 或 `root` |
| `SERVER_SSH_KEY` | SSH 私鑰內容 | 完整的 SSH 私鑰文本 |
| `SERVER_PORT` | SSH 連接埠（選填，預設 22） | `22` |
| `PROJECT_PATH` | 伺服器上的專案路徑（選填） | `/home/ubuntu/DtxCaseMgnt` |

### 2. 生成 SSH 密鑰對
如果您還沒有 SSH 密鑰對，請在本地機器上執行：

```bash
# 生成新的 SSH 密鑰對
ssh-keygen -t rsa -b 4096 -C "github-actions@yourdomain.com"

# 複製公鑰到伺服器
ssh-copy-id -i ~/.ssh/id_rsa.pub username@server_ip
```

### 3. 伺服器準備
確保您的伺服器滿足以下條件：

1. **安裝 Docker**：
   ```bash
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker $USER
   ```

2. **安裝 Git**：
   ```bash
   sudo apt update
   sudo apt install git -y
   ```

3. **克隆專案到伺服器**：
   ```bash
   cd /home/ubuntu  # 或您選擇的目錄
   git clone https://github.com/yourusername/DtxCaseMgnt.git
   ```

4. **設置腳本權限**：
   ```bash
   chmod +x /home/ubuntu/DtxCaseMgnt/FreeMarkerApp/redeploy-docker.sh
   ```

### 4. 工作流程說明

#### 觸發條件
- 推送到 `main` 分支時自動執行
- 也可以手動觸發（通過 GitHub Actions 頁面）

#### 執行步驟
1. **檢出代碼**：獲取最新的代碼
2. **連接伺服器**：通過 SSH 連接到遠端伺服器
3. **執行部署腳本**：運行 `redeploy-docker.sh`
4. **檢查狀態**：驗證容器是否正常運行
5. **通知結果**：顯示部署成功或失敗狀態

#### 部署腳本功能
- 拉取最新代碼
- 停止並移除舊容器
- 建立新的 Docker 映像（版本號：日期+git hash）
- 啟動新容器（端口 8262）

### 5. 安全注意事項

1. **SSH 密鑰安全**：
   - 使用專用的部署密鑰，不要使用個人密鑰
   - 定期輪換密鑰
   - 限制密鑰權限（只讀取必要目錄）

2. **伺服器安全**：
   - 配置防火牆只開放必要端口
   - 使用非標準 SSH 端口
   - 啟用 SSH 密鑰認證，禁用密碼認證

3. **Docker 安全**：
   - 定期更新 Docker 映像
   - 不要以 root 用戶運行容器
   - 使用多階段構建減少攻擊面

### 6. 故障排除

#### GitHub Actions 失敗
- 檢查 Secrets 是否正確設置
- 確認 SSH 密鑰格式正確
- 驗證伺服器網路連接

#### 部署腳本失敗
- 檢查伺服器上的專案路徑
- 確認 Docker 服務正常運行
- 查看伺服器日誌：`docker logs dtxcasemgnt`

### 7. 監控和維護

#### 查看部署狀態
```bash
# 檢查容器狀態
docker ps | grep dtxcasemgnt

# 查看容器日誌
docker logs dtxcasemgnt

# 檢查應用程式是否運行
curl http://localhost:8262
```

#### 清理舊映像
```bash
# 清理未使用的映像
docker image prune -f

# 清理未使用的容器
docker container prune -f
```

## 手動部署
如果需要手動部署，可以直接在伺服器上執行：
```bash
cd /path/to/DtxCaseMgnt/FreeMarkerApp
./redeploy-docker.sh
```

## 支援
如有問題，請檢查：
1. GitHub Actions 執行日誌
2. 伺服器系統日誌
3. Docker 容器日誌
