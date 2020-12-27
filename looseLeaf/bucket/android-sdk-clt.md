Android Studio - command tools
=======


> [更新於 2020.12.22](#修改紀錄)


**安裝： `scoop install bway/android-sdk-clt`**<br>
**可攜版安裝： `scoop install bway/portable-android-sdk-clt`**



## 程式包資訊


[安裝文件](../../bucket/android-sdk-clt.json)
、 [可攜版安裝文件](../../bucket/portable-android-sdk-clt.json)

* 主頁： https://developer.android.com/studio#command-tools
* 描述： 基本的 Android 命令行工具。
* 授權： [Freeware](https://developer.android.com/studio/terms.html)
* 依賴：
    * [`java/openjdk`](https://github.com/ScoopInstaller/Java/blob/master/bucket/openjdk.json)
* 可選擴展：
  * 虛擬機的硬體加速器
    * [Intel HAXM](./haxm.md)
* 可攜式安裝： ![可魔改](https://img.shields.io/badge/△%20可魔改-orange)
* 執行文件： ---
* 捷徑文件： ---
* 環境變數：
  * `PATH`: `./cmdline-tools/latest/bin`
  * `ANDROID_SDK_ROOT`: `.`
  * `ANDROID_SDK_HOME`: `./sdkHome`
  * `ANDROID_AVD_HOME`: `./sdkHome/.android/avd`
* 持久容器：
  * `./add-ons`
  * `./build-tools`
  * `./cmake`
  * `./emulator`
  * `./extras`
  * `./licenses`
  * `./ndk-bundle`
  * `./ndk`
  * `./patcher`
  * `./platform-tools`
  * `./platforms`
  * `./skiaparser`
  * `./sources`
  * `./system-images`
  * `./sdkHome`
* 自動更新： :heavy_check_mark:
* 下載點：
  * [v6858069.zip](https://dl.google.com/android/repository/commandlinetools-win-6858069_latest.zip)



## 問與答


##### 如何不帶 `--sdk_root` 選項執行 `sdkmanager` 命令？

參考 [MICROAU 大大的說明](https://blog.csdn.net/zhufu86/article/details/106747556)，
只需要調整 `ANDROID_SDK_ROOT` 的目錄結構即可改善此問題。

```
# 原本解壓縮後的路徑
─┬ cmdline-tools/
 ├─┬ bin/
 │ ├── sdkmanager.bat
 │ └── ...
 └── ...
# 改變為
─┬ cmdline-tools/
 └─┬ latest/
   ├─┬ bin/
   │ ├── sdkmanager.bat
   │ └── ...
   └── ...
```



## 參考


* 程式桶
  * [main/android-clt](https://github.com/ScoopInstaller/Main/blob/master/bucket/android-clt.json)
* [Android SDK Command line tools运行sdkmanager报告Warning: Could not create settings错误信息解决方法_MICROAU的博客-CSDN博客](https://blog.csdn.net/zhufu86/article/details/106747556)



## 修改紀錄


* 2020.12.22 編寫。

