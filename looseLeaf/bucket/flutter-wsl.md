Flutter for WSL
=======

> [更新於 2022.11.26](#修改紀錄)

**安裝： `scoop install bway/flutter-wsl`**


## 程式包資訊

[安裝文件](../../bucket/flutter-wsl.json)

* 主頁： https://flutter.dev
* 描述： 用於通過單一代碼庫為移動裝置、Web 和桌面打造美觀、快速的用戶體驗。
* 授權： BSD-3-Clause
* 依賴：
  * [`bway/android-clt`](./android-clt.md)
* 可選擴展： ---
* 環境變數：
  * PATH: `./bin`
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

#### bin/cache 目錄

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
如： `flutter doctor|devices|run`、`flutter pub`。

[`./bin/flutter`](../../pkgfile/flutter-wsl/flutter)
中介執行文件會自動判斷調用該命令的平台，
但若要強制指定 WSL 可以使用 `flutter unix ...`，
或是要 Windows 可以使用 `flutter win ...`。


## 修改紀錄

* 2022.11.26 ~~~

