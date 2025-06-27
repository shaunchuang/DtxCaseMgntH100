# DtxCaseMgnt 自動部署指南

## 🎯 目標
配合 GitHub Actions 實現當推送程式碼到 `main` 分支時，自動在遠端伺服器進行 Docker 重新部署。

## 📁 已創建的檔案

### 1. GitHub Actions 工作流程
- `.github/workflows/deploy.yml` - 基本部署工作流程
- `.github/workflows/ci-cd.yml` - 完整的 CI/CD 流程（包含測試和建置）
- `.github/workflows/README.md` - 詳細設置說明

### 2. 輔助腳本
- `test-deploy.sh` - 本地測試部署腳本

## 🚀 快速開始

### 步驟 1: 設置 GitHub Secrets
在 GitHub repository 設置中添加以下 Secrets：

```
SERVER_HOST=your-server-ip-or-domain
SERVER_USER=ubuntu
SERVER_SSH_KEY=-----BEGIN OPENSSH PRIVATE KEY-----
your-private-key-content-here
-----END OPENSSH PRIVATE KEY-----
SERVER_PORT=22 (選填，預設 22)
PROJECT_PATH=/home/ubuntu/DtxCaseMgnt (選填)
```

### 步驟 2: 準備伺服器
```bash
# 安裝 Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# 安裝 Git
sudo apt update && sudo apt install git -y

# 克隆專案
git clone https://github.com/yourusername/DtxCaseMgnt.git
cd DtxCaseMgnt/FreeMarkerApp
chmod +x redeploy-docker.sh
```

### 步驟 3: 設置 SSH 密鑰
```bash
# 在本地生成密鑰對
ssh-keygen -t rsa -b 4096 -C "github-actions@yourdomain.com"

# 將公鑰複製到伺服器
ssh-copy-id -i ~/.ssh/id_rsa.pub username@server_ip
```

### 步驟 4: 測試本地建置
```bash
# 在專案根目錄下執行
chmod +x test-deploy.sh
./test-deploy.sh
```

### 步驟 5: 推送觸發部署
```bash
git add .
git commit -m "設置自動部署"
git push origin main
```

## 🔄 工作流程說明

### 簡單部署流程 (deploy.yml)
1. **觸發**: 推送到 `main` 分支
2. **連接**: SSH 連接到伺服器
3. **部署**: 執行 `redeploy-docker.sh`
4. **驗證**: 檢查應用程式狀態

### 完整 CI/CD 流程 (ci-cd.yml)
1. **測試階段** (Pull Request):
   - 建置所有模組
   - 執行測試套件
   
2. **部署階段** (推送到 main):
   - 建置 Framework、FreeMarker、FreeMarkerApp
   - 備份當前版本
   - 執行部署腳本
   - 健康檢查
   - 清理舊備份

## 🔧 部署腳本功能

`redeploy-docker.sh` 執行以下操作：
- 獲取 Git 版本號 (日期+短hash)
- 拉取最新程式碼
- 停止並移除舊容器
- 建立新映像
- 啟動新容器 (端口 8262)

## 📊 監控和維護

### 檢查部署狀態
```bash
# 查看容器狀態
docker ps | grep dtxcasemgnt

# 查看應用程式日誌
docker logs dtxcasemgnt

# 檢查應用程式健康狀態
curl http://localhost:8262
```

### 手動部署
```bash
cd /path/to/DtxCaseMgnt/FreeMarkerApp
./redeploy-docker.sh
```

### 回滾操作
```bash
# 如果新版本有問題，可以快速回滾
docker stop dtxcasemgnt
docker rm dtxcasemgnt
docker run --name dtxcasemgnt -d -p 8262:8262 dtxcasemgnt:previous-version
```

## 🛡️ 安全最佳實踐

1. **SSH 密鑰管理**:
   - 使用專用部署密鑰
   - 定期輪換密鑰
   - 限制密鑰權限

2. **伺服器安全**:
   - 配置防火牆
   - 使用非標準 SSH 端口
   - 啟用密鑰認證，禁用密碼認證

3. **容器安全**:
   - 使用非 root 用戶運行
   - 定期更新基底映像
   - 限制容器權限

## 🐛 故障排除

### GitHub Actions 失敗
- 檢查 Secrets 設置
- 驗證 SSH 連接
- 檢查伺服器網路

### 部署失敗
- 檢查伺服器磁碟空間
- 驗證 Docker 服務狀態
- 檢查應用程式配置

### 應用程式無法啟動
- 檢查端口衝突
- 驗證配置檔案
- 查看容器日誌

## 📈 效益

### 自動化部署帶來的好處：
- ✅ **快速部署**: 推送即部署，無需手動操作
- ✅ **版本管理**: 自動生成版本號，便於追蹤
- ✅ **備份機制**: 自動備份前一版本，支援快速回滾
- ✅ **健康檢查**: 自動驗證部署結果
- ✅ **通知機制**: 即時了解部署狀態
- ✅ **安全性**: 透過 SSH 密鑰認證，避免密碼洩露

## 📞 支援

如遇到問題，請檢查：
1. GitHub Actions 執行日誌
2. 伺服器系統日誌  
3. Docker 容器日誌
4. 應用程式日誌

---
**注意**: 首次設置時請仔細閱讀 `.github/workflows/README.md` 中的詳細說明。
