# 安裝 Scoop


param($paramScoopPath, $paramScoopGlobalPath)


# 設定 Scoop 安裝程式包目錄路徑
if ($paramScoopPath -ne $null) {
  $scoopPath = $paramScoopPath
} elseif ($scoopPath -eq $null) {
  $scoopPath = "$HOME\scoop"
}
if ($paramScoopGlobalPath -ne $null) {
  $scoopGlobalPath = $paramScoopGlobalPath
}


## 安裝 scoop 程式包管理工具
# https://scoop.sh/
# https://github.com/lukesampson/scoop

# 允許使用當前用戶權限 (由於不使用用戶目錄而無須開啟用戶權限)
# Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# 設定環境變量
[Environment]::SetEnvironmentVariable('SCOOP', $scoopPath, 'User')
if ($scoopGlobalPath -eq $null) {
  # 以管理員身分安裝時為全域安裝
  [Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $scoopGlobalPath, 'User')
}

# 安裝 Scoop
# Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
# or
iwr get.scoop.sh | iex


## 安裝常用程式包
# sudo: 取得管理員權限
# git:
#   1. scoop 安裝其他 bucket 的依賴程式包
#   2. 在 Window 環境下使用 git-bash.exe 命令行
scoop install sudo git

# 設定命令行視窗外觀
# 比 `Out-File` 使用上更好輸出 UTF-8 no Bom
[IO.File]::WriteAllLines("$HOME\.minttyrc", "
BoldAsFont=-1
Locale=zh_TW
Charset=UTF-8
Transparency=high
OpaqueWhenFocused=no
CursorType=line
Font=Consolas
FontHeight=14
FontWeight=400
FontIsBold=no
ForegroundColour=210,210,210
BackgroundColour=48,48,48
FontSmoothing=default
AllowBlinking=no
RightClickAction=menu
CursorColour=255,255,255")


## 安裝 WSLtty
# 模擬 Linux 使用習慣的命令行
# https://blog.miniasp.com/post/2019/02/09/Useful-tool-WSLtty-Mintty-as-a-terminal-for-WSL
scoop bucket add extras
scoop install wsltty
Set-Location $env:SCOOP\apps\wsltty\current
.\install.bat
# .\uninstall.bat

# 鏈接用戶資料夾內的命令行視窗外觀設定文件
# NOTE: 雖然產生的鏈接檔無法開啟但在 mintty 中卻是正確的 `ln -s` 格式
cmd /c mklink /j $env:APPDATA\wsltty\config $HOME\.minttyrc

