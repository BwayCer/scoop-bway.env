Android SDK Command Tools
=======

> [更新於 2022.10.18](#修改紀錄)

**安裝： `scoop install bway/android-clt`**


## 程式包資訊

[安裝文件](../../bucket/android-clt.json)

* 主頁： https://developer.android.com/studio#command-tools
* 描述： 基本的 Android 命令行工具。
* 授權： [Freeware](https://developer.android.com/studio/terms.html)
* 依賴：
  * `java`
    * [`java/openjdk`](https://github.com/ScoopInstaller/Java/blob/master/bucket/openjdk.json)
    * [`java/openjdk18`](https://github.com/ScoopInstaller/Java/blob/master/bucket/openjdk18.json)
* 可選擴展：
  * 虛擬機的硬體加速器
    * [Intel HAXM](./haxm.md)
* 環境變數：
  * `ANDROID_SDK_ROOT`: `.`
  * `ANDROID_SDK_HOME`: `./sdkHome`
  * `ANDROID_AVD_HOME`: `./sdkHome/.android/avd`
  * `GRADLE_USER_HOME`: `./sdkHome/gradle`
* 執行文件：
  * `./bin/adb.ps1`
  * `./bin/emulator.ps1`
  * `./bin/fastboot.ps1`
  * `./cmdline-tools/latest/bin/apkanalyzer.bat`
  * `./cmdline-tools/latest/bin/avdmanager.bat`
  * `./cmdline-tools/latest/bin/sdkmanager.bat`
* 開始菜單： ---
* 持久容器：
  * `./build-tools`
  * `./emulator`
  * `./licenses`
  * `./platform-tools`
  * `./platforms`
  * `./system-images`
  * `./sdkHome`
* 自動更新： :white_check_mark:
* 下載點：
  * [v8512546.zip](https://dl.google.com/android/repository/commandlinetools-win-8512546_latest.zip)
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


##### Gradle需搭配合適的Java版本才能正常使用

關於Gradle與Java對應版本請見：
[docs.gradle.org: Compatibility Matrix](https://docs.gradle.org/current/userguide/compatibility.html)

查看當前使用的Gradle版本： **(不確定是否符合所有人)**

```powershell
PS > ls "$env:GRADLE_USER_HOME\wrapper\dists"

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2022/10/17  下午 12:28                gradle-7.4-all
```

筆者以Gradle 7.4版本搭配 java/openjdk19 環境下執行 `flutter run` 命令會遇到以下錯誤：

```
Launching lib\main.dart on ASUS X00QD in debug mode...

* Where:
Build file 'C:\...\my_app\android\build.gradle' line: 26

* What went wrong:
A problem occurred evaluating root project 'android'.
> A problem occurred configuring project ':app'.
   > Could not open proj generic class cache for build file 'C:\...\my_app\android\app\build.gradle' (C:\...\android-sdk-clt\current\sdkHome\gradle\caches\7.4\scripts\87n4e2g2ddcgdl55zs42203qz).
      > BUG! exception in phase 'semantic analysis' in source unit '_BuildScript_' Unsupported class file major version 63

... 略 (關於gradle命令的除錯教學)

BUILD FAILED in 27s
Running Gradle task 'assembleDebug'...                             31.6s
Exception: Gradle task assembleDebug failed with exit code 1
```


## 參考

* 程式桶
  * [main/android-clt](https://github.com/ScoopInstaller/Main/blob/master/bucket/android-clt.json)
* [Android SDK Command line tools运行sdkmanager报告Warning: Could not create settings错误信息解决方法_MICROAU的博客-CSDN博客](https://blog.csdn.net/zhufu86/article/details/106747556)
* [StackOverflow: BUG! exception in phase 'semantic analysis' in source unit '_BuildScript_' Unsupported class file major version 61 on Apple Arm](https://stackoverflow.com/questions/68597899)


## 修改紀錄

* 2022.10.19 v8512546版本更新；大部分內容重新編寫。
* 2020.12.22 ~~~

