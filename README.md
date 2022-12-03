本微視窗程式集
=======

我的 W$ 環境。

使用 Windows Terminal 搭配 WSL 為主。<br>
程式包管理工具使用 [Scoop](https://scoop.sh)。


## Scoop 安裝方式

**安裝/解除安裝：**

```powershell
## 安裝
# 預設配置
# - Scoop 安裝程式包目錄路徑
#     $scoopPath       = "$HOME\ph\scoop"
#     $scoopGlobalPath = "" # 不設置全域路徑
# - 程式桶: bway
# - 程式包: sudo, git
iwr https://raw.githubusercontent.com/BwayCer/scoop-bway.env/main/bin/installScoopByBway.ps1 | iex

## 解除安裝
uninstallScoopByBway.ps1
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
  * [installScoopByBway.ps1](./bin/installScoopByBway.ps1): 安裝 Scoop & Bway bucket。
  * [uninstallScoopByBway.ps1](./bin/uninstallScoopByBway.ps1): 解除安裝Scoop。
  * [scoop.portable.ps1](./bin/scoop.portable.ps1): Scoop可攜版。
  * [keyboardLayout.surface.change.reg](./bin/keyboardLayout.surface.change.reg): 變更Surface的鍵盤布局。
  * [keyboardLayout.surface.recover.reg](./bin/keyboardLayout.surface.recover.reg): 恢復原始Surface的鍵盤布局。
* 程式桶
  * [`bway/android-clt`](./looseLeaf/bucket/android-clt.md): Android SDK 命令工具。
  * [`bway/flutter-wsl`](./looseLeaf/bucket/flutter-wsl.md): Flutter 跨平台圖形介面開發工具。


## 活頁筆記

* 視窗語法
  * [鍵盤布局登入文件](./looseLeaf/windowsCode/keyboardLayoutRegistry.md)


## 推薦程式桶

* [`main/ffmpeg`](https://github.com/ScoopInstaller/Java/blob/master/bucket/openjdk.json)
* [`main/youtube-dl`](https://github.com/ScoopInstaller/Java/blob/master/bucket/openjdk.json)
* [`java/openjdk`](https://github.com/ScoopInstaller/Java/blob/master/bucket/openjdk.json)

