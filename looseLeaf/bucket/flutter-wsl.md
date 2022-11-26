Flutter for WSL
=======

> [更新於 2022.12.03](#修改紀錄)

**安裝： `scoop install bway/flutter-wsl`**


## 程式包資訊

[安裝文件](../../bucket/flutter-wsl.json)

* 主頁： https://flutter.dev
* 描述： 用於通過單一代碼庫為移動裝置、Web 和桌面打造美觀、快速的用戶體驗。
* 授權： BSD-3-Clause
* 依賴： ---
* 可選擴展：
  * [`bway/android-clt`](./android-clt.md)
* 環境變數：
  * `FLUTTER_ROOT`: `./flutter`
  * `APUB_CACHE`: `./.pub-cache`
* 執行文件：
  * `./bin/flutter`
  * `./bin/flutter.ps1`
* 開始菜單： ---
* 持久容器：
  * `./.pub-cache`
  * `./bin/cache.unix`
  * `./bin/cache.win`
* 自動更新： ---
* 下載點：
  * [GitHub:flutter/flutter](https://github.com/flutter/flutter)


## 如何在WSL環境下使用

#### 設定預設WSL

為避免使用 `git-bash.exe` 所下載的 "dos" 文件，
調用 `git` 時借用 WSL 容器命令，
所以請先確保有安裝 `git` 的 WSL 容器並設為預設 (`wsl --set-default <DistributionName>`)。

```
$ wsl --list
Windows 子系統 Linux 版發佈:
ArchLinux (預設)
docker-desktop-data
docker-desktop
```

當安裝完成時，為使中介執行文件能順利運行，請在 WSL 執行下述命令：

```
sudo chown $(whoami):$(whoami) -R /path/to/scoop/app/flutter-wsl/current/flutter
```

#### cache 目錄

因為 flutter 專案的 `bin/cache` 會依平台而有不同，
所以我而外建立調用 `flutter` 命令的
[`./bin/flutter`](../../pkgfile/flutter-wsl/flutter) 和
[`./bin/flutter.ps1`](../../pkgfile/flutter-wsl/flutter.ps1)
兩中介執行文件，
會在調用該命令時創建對應平台的 cache 目錄的鏈結文件。

#### 職責劃分

紀錄於版本控制的文件由 Unix 的 WSL 負責，
如： `flutter create --no-pub`、`dart`；
建構圖形介面則由 Windows 執行，
如： `flutter pub|doctor|devices|emulators|run`、。

[`./bin/flutter`](../../pkgfile/flutter-wsl/flutter)
中介執行文件會自動判斷調用該命令的平台，
但若要強制指定 WSL 可以使用 `flutter wino ...`，
或是要 Windows 可以使用 `flutter win ...`。


## 問與答


#### 推薦在 Windows 與 WSL 哪個中安裝 flutter 呢？

首先說明 flutter 共存在兩環境下是可行的，
但必須先知道 Windows 的 `flutter` 命令無法讀取 WSL 的目錄文件，
而 WSL 的命令對 Windows 文件系統又是超慢
 (在 flutter 專案執行 git status 命令約 43 秒)，
所以就看如何取捨，
如果空間允許都安裝也行。

另外，WSL 中會引入 Windows 的環境路徑，
以下提供將 Windows 環境路徑移至 `$PATH` 最後的作法參考：

```sh
tmpNewPathTxt=""
tmpWinPathTxt=""
while read line
do
  [[ "$line" =~ ^\/mnt\/ ]] &&
    tmpWinPathTxt+=":$line" ||
    tmpNewPathTxt+=":$line"
done <<< "$(echo -e $(sed 's/:/\\n/g' <<< "$PATH"))"
tmpNewPathTxt="$tmpNewPathTxt$tmpWinPathTxt"
PATH="${tmpNewPathTxt:1}"
unset tmpNewPathTxt tmpWinPathTxt
```


#### 安裝 Android 工具

對於 Android 工具的安裝自我推薦使用
[`scoop install bway/android-clt`](./android-clt.md)，
但僅使用瀏覽器開發現在也可以實現，
之後再透過 GitHub Action 打包成各平台執行文件也是可選的方案之一。


#### `Unable to locate Android SDK.` 問題？

如果有以下訊息：

```
[!] Android toolchain - develop for Android devices
    X Unable to locate Android SDK.
      ...

    X No valid Android SDK platforms found in C:\path\to\ANDROID_SDK_ROOT\platforms. Directory was
      empty.
```

則請安裝 `build-tools` 及 `platforms` 工具程式包。

```
# 請自行下載最新版本
sdkmanager "build-tools;30.0.3"
sdkmanager "platforms;android-30"
```


## 修改紀錄

* 2022.12.03 Android 工具改為可選安裝、處理 WSL 與 Windows 整合。
* 2022.11.26 ~~~

