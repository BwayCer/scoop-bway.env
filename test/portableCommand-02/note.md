筆記
=======


#### WSL容器附帶Windows與Unix間路徑切換命令

```sh
# WSL容器附帶 `wslpath` 命令
$ which wslpath
/usr/sbin/wslpath

$ wslpath -a 'C:\Users\bwaycer\Desktop'
/mnt/c/Users/bwaycer/Desktop

# 如果有使用docker mount則會呈現以下路徑
$ wslpath -a 'C:\Users\bwaycer\Desktop'
/mnt/wsl/docker-desktop-bind-mounts/Arch/b8de4c5b3311860f3a11ab5ae28bbd7dfe22119d60b65ddbc6bb8b1b909f11c0
```

#### Shell調用PowerShell可選用選項

```powershell
PowerShell.exe -h

  -NoProfile
    不載入 Windows PowerShell 設定檔。
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles
  -NoExit
    命令執行完成後不退出。
  -ExecutionPolicy <Execution Policy>
    unrestricted 類似於 "Bypass" 執行政策。
  -Command
    選項與 `sh -c "..."` 功能相似。
```

#### Shell調用PowerShell時被忽略的引號

```powershell
powershell.exe -Command '\"echo is not command.\"'
# same as
# `sudo` 是Scoop的 `main/sudo`
sudo powershell.exe -Command '\\\\\\\"echo is not command\\\\\\\"'
```

#### PowerShell取得的文件路徑即為原始文件路徑

Windows平台的只能對目錄建立鏈結文件，所以不會有 `realpath "$0"` 問題。

```
$PSScriptRoot    # like as `realpath "$0"`
$PSCommandPath   # like as `dirname "$(realpath "$0")"`
```


#### 舊版PowerShell的 `PSScriptRoot` 參數問題

```powershell
# http://www.tastones.com/zh-tw/stackoverflow/powershell/built-in-variables/psscriptroot/
# 如果從外部調用(?)，則 $PSScriptRoot 為 $null，
# 但從 Windows PowerShell 3.0 之後在所有指令碼中都有效。
if (!(Test-Path Variable:PSScriptRoot)) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}
```

