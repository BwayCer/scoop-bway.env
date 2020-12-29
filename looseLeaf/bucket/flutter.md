Flutter
=======


> [更新於 2020.12.29](#修改紀錄)


**安裝： `scoop install bway/flutter`**<br>
**可攜版安裝： `scoop install bway/portable-flutter`**



## 程式包資訊


[安裝文件](../../bucket/flutter.json)
、 [可攜版安裝文件](../../bucket/portable-flutter.json)

* 主頁： https://flutter.dev
* 描述： Google’s mobile app SDK for crafting high-quality native interfaces on iOS and Android.
* 授權： [BSD-3-Clause](https://github.com/flutter/flutter/blob/master/LICENSE)
* 依賴：
    * [`bway/android-sdk-clt`](./android-sdk-clt)
* 可選擴展：
  * Visual Studio Code with Flutter Extension
    * [`extras/vscode-portable`](https://github.com/lukesampson/scoop-extras/blob/master/bucket/vscode-portable.json)
* 可攜式安裝： ![可魔改](https://img.shields.io/badge/△%20可魔改-orange)
* 執行文件：
  * `./bin/flutter.bat`
  * `./bin/dart.bat`
  * `./bin/cache/dart-sdk/bin/dart2js.bat`
  * `./bin/cache/dart-sdk/bin/dart2native.bat`
  * `./bin/cache/dart-sdk/bin/dartaotruntime.exe`
  * `./bin/cache/dart-sdk/bin/dartdevc.bat`
  * `./bin/cache/dart-sdk/bin/dartdoc.bat`
* 捷徑文件： ---
* 環境變數： ---
* 持久容器： ---
* 自動更新： :heavy_check_mark:
* 下載點：
  * [v1.22.5.zip](https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_1.22.5-stable.zip)



## 問與答


##### `Unable to locate Android SDK.` 問題？

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



## 參考


* 程式桶
  * [extras/flutter](https://github.com/lukesampson/scoop-extras/blob/master/bucket/flutter.json)



## 修改紀錄


* 2020.12.29 編寫。

