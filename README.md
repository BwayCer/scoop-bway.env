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



## 活頁筆記


* 可執行文件
  * [surfaceKeyboardLayout.reg](./bin/surfaceKeyboardLayout.reg): Surface 的鍵盤布局。
* 視窗語法
  * [鍵盤布局登入文件](./looseLeaf/windowsCode/keyboardLayoutRegistry.md)

