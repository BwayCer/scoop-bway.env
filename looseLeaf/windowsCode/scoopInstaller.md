Scoop 安裝工具
=======


筆者還只是新手，僅就目前所知做個紀錄。


**dotnet-desktop-runtime：**

[dorado/dotnet-desktop-runtime 安裝文件](https://github.com/chawyehsu/dorado/blob/master/bucket/dotnet-desktop-runtime.json)<br>
[bway/dotnet-desktop-runtime 安裝文件](../../bucket/dotnet-desktop-runtime.json)

```
# 將 ".exe" 的安裝文件拆成數個 ".msi" 文件並放置於 "$dir\extracted" 目錄位置。
# 此步驟會自動安裝 `main/dark`。
Expand-DarkArchive "$dir\$fname" "$dir\extracted" -Removal

# 逐一執行 ".msi" 安裝文件，並將安裝目錄由 "C:\Program Files" 位置改置 "$dir" 位置。
# 此步驟會自動安裝 `main/lessmsi`
"Get-ChildItem "$dir\extracted\AttachedContainer\*.msi" | ForEach-Object { Expand-MsiArchive $_ "$dir" }

# 移動 ".msi" 安裝文件產生的 "$dir\dotnet" 目錄下的子文件至 "$dir" 安裝目錄，
# 然後刪除過程中本安裝產生的 "$dir\dotnet", "$dir\extracted" 目錄。
Move-Item "$dir\dotnet\*" "$dir\dotnet-runtime" -Force
@('dotnet', 'extracted') | ForEach-Object { Remove-Item "$dir\$_" -Recurse }
```

但由於 .Net 會把不同版本安裝在相同的目錄中，
因此需要借助持久容器收錄不同版本的程式文件。

以下腳本用到 `persist` 欄位創建持久容器，
與 `post_install` 欄位於持久容器創建後欲執行的腳本。

```
# 複製 "$dir\dotnet" 目錄下的子文件到 "$dir\dotnet-runtime" 持久容器目錄，
# 其中 `-Container` 選項為保持原始文件位於 "$dir\dotnet" 目錄得相對路徑位置。
# (`Move-Item` 沒有此功能)
Copy-Item "$dir\dotnet\*" "$dir\dotnet-runtime" -Container -Force -Recurse
Remove-Item "$dir\dotnet" -Recurse
```


**其他：**

```
# 如果 "$dir\dirname" 持久容器不存在則創建該目錄。
if (-not (Test-Path "$dir\dirname")) {
    New-Item "$dir\dirname" -ItemType Directory
}
```



## 參考


* [How to use PowerShell copy-item and keep structure - Stack Overflow](https://stackoverflow.com/questions/5432290/how-to-use-powershell-copy-item-and-keep-structure)

