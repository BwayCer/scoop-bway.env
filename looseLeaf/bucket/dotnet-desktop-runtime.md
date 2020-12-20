.NET Runtime
=======


> [更新於 2020.12.20](#修改紀錄)


**安裝： `scoop install bway/dotnet-desktop-runtime`**



## 程式包資訊


[安裝文件](../../bucket/dotnet-desktop-runtime.json)

* 主頁： https://dotnet.microsoft.com
* 描述： .NET 是免費、跨平台、開源代碼，而運行時程式包包含運行現有 .NET Core 和 ASP.NET Core 應用程式所需的一切。
* 授權： [Freeware](https://dotnet.microsoft.com/platform/free)
* 依賴： ---
* 可選擴展： ---
* 可攜式安裝： ![可修改](https://img.shields.io/badge/△%20可修改-orange)
* 執行文件： ---
* 捷徑文件： ---
* 環境變數：
  * `DOTNET_ROOT`: `./dotnet-runtime`
* 持久容器： ---
* 自動更新： :heavy_check_mark:
* 下載點：
  * [v5.0.1-64bit.exe](https://dotnetcli.blob.core.windows.net/dotnet/WindowsDesktop/5.0.1/windowsdesktop-runtime-5.0.1-win-x64.exe)
  * [v3.1.10-64bit.exe](https://dotnetcli.blob.core.windows.net/dotnet/Runtime/3.1.10/windowsdesktop-runtime-3.1.10-win-x64.exe)



## 問與答


##### 為何程式包路徑下多出 "_persist" 版本的目錄？

由於 .Net 會把不同版本安裝在相同的目錄中，
因此需要借助持久容器收錄不同版本的程式文件。

對比把主程式放於持久容器 (`persist` 欄位) 中，
筆者認為放於程式包目錄中更為合理。



## 參考


* 程式包桶
  * [main/dotnet-sdk](https://github.com/ScoopInstaller/Main/blob/master/bucket/dotnet-sdk.json)
  * [dorado/dotnet-desktop-runtime](https://github.com/chawyehsu/dorado/blob/master/bucket/dotnet-desktop-runtime.json)
* 其他閱讀
  * [.NET 5, .NET Core, .NET Framework 差別？](https://blog.darkthread.net/blog/netcore-3-release/)



## 修改紀錄


* 2020.12.18 編寫。
* 2020.12.20 編寫 程式包路徑下的 "_persist" 目錄問題。

