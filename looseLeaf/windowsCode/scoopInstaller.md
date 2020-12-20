Scoop 安裝工具
=======


筆者還只是新手，僅就目前所知做個紀錄。


**可參考文件：**

  * GitHub lukesampson/scoop/wiki
    * [App-Manifests](https://github.com/lukesampson/scoop/wiki/App-Manifests)：
      `pre_install`, `installer`, `post_install`, `uninstaller` 欄位。
    * [Pre and Post install scripts](https://github.com/lukesampson/scoop/wiki/Pre--and-Post-install-scripts)


**Power Shell：**

```ps1
# 如果 ".\path\to\name" 存在則 ...
if (Test-Path "$dir\name") {...}
# 如果 ".\path\to\name" 不存在則 ...
if (-not (Test-Path ".\path\to\name")) {...}

# 建立 ".\path\to\name" 目錄。
New-Item ".\path\to\name" -ItemType Directory

# 不顯示執行 `<cmd>` 命令的輸出訊息。
# `<cmd> | Out-Null`
New-Item ".\path\to\name" -ItemType Directory | Out-Null

# 在 ".\path\to\name" 位置建立對 ".\path\to\target" 路徑的鏈接文件。
New-Item ".\path\to\name" -ItemType Junction -Target ".\path\to\target"

# 移動 ".\path\to\nameA" 目錄下的子文件到 ".\path\to\nameB" 目錄。
Move-Item ".\path\to\nameA\*" ".\path\to\nameB" -Force

# 複製 ".\path\to\nameA" 目錄下的子文件到 ".\path\to\nameB" 目錄，
# 其中 `-Container` 選項可保持原始文件位於 ".\path\to\nameA" 目錄下的相對路徑位置。
# (`Move-Item` 沒有此功能)
Copy-Item ".\path\to\nameA\*" ".\path\to\nameB" -Container -Force -Recurse

# 移除 ".\path\to\name" 目錄。
Remove-Item ".\path\to\name" -Recurse

# 迴圈輸出 `str[]` 的內容。
@('A', 'B') | ForEach-Object { echo "$_" }
```


**Scoop 程式庫：**

```
# 取得當前程式包安裝目錄位置
# `pre_install`, `install`: `C:\path\to\scoop\apps\<packageName>\<version>`
# `post_install`:           `C:\path\to\scoop\apps\<packageName>\current`
$dir

# 取得程式包的目錄路徑 `C:\path\to\scoop\apps\<packageName>`
# (main/android-clt 安裝文件)
$(appdir <packageName> [isGlobal])

# 將 ".exe" 的安裝文件拆成數個 ".msi" 文件並放置於 "$dir\extracted" 目錄位置。
# 此步驟會自動安裝 `main/dark`。
# (dorado/dotnet-desktop-runtime 安裝文件)
Expand-DarkArchive "$dir\$fname" "$dir\extracted" -Removal

# 逐一執行 ".msi" 安裝文件，並將安裝目錄由 "C:\Program Files" 位置改置 "$dir" 位置。
# 此步驟會自動安裝 `main/lessmsi`
# (dorado/dotnet-desktop-runtime 安裝文件)
Get-ChildItem "$dir\extracted\AttachedContainer\*.msi" | ForEach-Object { Expand-MsiArchive $_ "$dir" }
```



## 參考


* 程式包桶
  * [bway/dotnet-desktop-runtime 安裝文件](../../bucket/dotnet-desktop-runtime.json)
  * [main/android-clt](https://github.com/ScoopInstaller/Main/tree/master/bucket/android-clt.json)
  * [dorado/dotnet-desktop-runtime 安裝文件](https://github.com/chawyehsu/dorado/blob/master/bucket/dotnet-desktop-runtime.json)
* [How to use PowerShell copy-item and keep structure - Stack Overflow](https://stackoverflow.com/questions/5432290/how-to-use-powershell-copy-item-and-keep-structure)

