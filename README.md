本微視窗程式集
=======


我的 W$ 環境。

命令行以 git-bash 為主，並搭配 powershell、cmd 穿插使用。<br>
程式包管理工具使用 [Scoop](https://scoop.sh)。



## Scoop 安裝方式


```ps1
# 設定 Scoop 安裝程式包目錄路徑
# $scoopPath       = "$HOME\scoop"
# $scoopGlobalPath = "" # 若未賦值則不設置
# 預設安裝程式桶: extras
# 預設安裝程式包: git, wsltty
iwr https://raw.githubusercontent.com/BwayCer/scoop-bway.env/main/bin/installTerminal.ps1 | iex
```

```ps1
# 安裝 bway 程式桶
# 當程式包名稱相同時會依照 bucket 的名稱排序來選擇參考的 JSON 文件，
# 其中數字又優先於英文字母。
# 為避免此種情況發生，建議使用 `scoop install <bucket>/<package>` 的命令方式。
scoop bucket add bway https://raw.githubusercontent.com/BwayCer/scoop-bway.env
```

關於 Buckets 的資訊請見 [GitHub lukesampson/scoop/wiki/Buckets](https://github.com/lukesampson/scoop/wiki/Buckets)。



## 管理的程式集


* 可執行文件
  * [surfaceKeyboardLayout.reg](./bin/surfaceKeyboardLayout.reg): Surface 的鍵盤布局。
* 程式桶
  * [`bway/ultimate-windows-context-menu-customizer`](./looseLeaf/bucket/ultimate-windows-context-menu-customizer.md): Windows Context Menu 訂製工具。



## 活頁筆記


* 視窗語法
  * [鍵盤布局登入文件](./looseLeaf/windowsCode/keyboardLayoutRegistry.md)

