本微視窗程式集
=======


我的 W$ 環境。

命令行以 git-bash 為主，並搭配 powershell、cmd 穿插使用。<br>
程式包管理工具使用 [Scoop](https://scoop.sh)。



## Scoop 安裝方式


**安裝命令行：**

```ps1
# 設定 Scoop 安裝程式包目錄路徑
# $scoopPath       = "$HOME\scoop"
# $scoopGlobalPath = "" # 若未賦值則不設置
# 預設安裝程式桶: extras
# 預設安裝程式包: git, wsltty
iwr https://raw.githubusercontent.com/BwayCer/scoop-bway.env/main/bin/installTerminal.ps1 | iex
```


**推薦安裝：**

```ps1
# 安裝 bway 程式桶
scoop bucket add bway https://raw.githubusercontent.com/BwayCer/scoop-bway.env
# 安裝預設執行命令
$env:SCOOP\buckets\bway\bin\linkBinToScoop.ps1

# 安裝常用程式包
iwr https://raw.githubusercontent.com/BwayCer/scoop-bway.env/main/bin/installCommonPackages.ps1 | iex
```


**相關說明：**

  * 關於應用清單的規範請見 [GitHub lukesampson/scoop/wiki/App-Manifests](https://github.com/lukesampson/scoop/wiki/App-Manifests)。
  * 關於程式包桶子的資訊請見 [GitHub lukesampson/scoop/wiki/Buckets](https://github.com/lukesampson/scoop/wiki/Buckets)。
  * 當程式包名稱相同時會依照 bucket 的名稱排序來選擇參考的 JSON 文件，
    其中數字又優先於英文字母。
    為避免此種情況發生，
    建議使用 `scoop install <bucket>/<package>` 的命令方式。



## 管理的程式集


* 可執行文件
  * [portable.ps1](./bin/portable.ps1): 可攜版程式包的定型化可攜命令。
  * [ps1.sh](./bin/ps1.sh): 在 mintty 中另開 PowerShell 執行命令。
  * [scoop.portable.ps1](./bin/scoop.portable.ps1): Scoop 可攜版。
  * [ysBashComplete](./bin/ysBashComplete): 命令列舉自動補齊。
  * [surfaceKeyboardLayout.reg](./bin/surfaceKeyboardLayout.reg): Surface 的鍵盤布局。
* 程式桶
  * [`bway/ultimate-windows-context-menu-customizer`](./looseLeaf/bucket/ultimate-windows-context-menu-customizer.md): Windows Context Menu 訂製工具。



## 活頁筆記


* 視窗語法
  * [鍵盤布局登入文件](./looseLeaf/windowsCode/keyboardLayoutRegistry.md)

