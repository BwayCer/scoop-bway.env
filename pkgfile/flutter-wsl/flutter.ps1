# Flutter WSL 適應腳本 Windows & PowerShell 環境


if (!(Test-Path Variable:PSScriptRoot)) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}


$cacheUnixDirPath="$PSScriptRoot\cache.unix"
$cacheWinDirPath="$PSScriptRoot\cache.win"

$flutterBinDirPath="$PSScriptRoot\..\flutter\bin"
$cacheDirPath = "$flutterBinDirPath\cache"


# 若 $cacheDirPath 路徑存在鏈結文件，
# 則更新其鏈結指向 $cacheWinDirPath 路徑。
# 若遇非鏈結文件，則拋出無法處理的錯誤。
# 若 $cacheWinDirPath 路徑不存在，則拋出文件不存在的錯誤。
$cacheDirItem = Get-Item $cacheDirPath 2> $null
if ($cacheDirItem.Target -ne $cacheWinDirPath) {
  if ($cacheDirItem.LinkType -eq "Junction") {
    fsutil reparsepoint delete $cacheDirItem
    Remove-Item $cacheDirPath
  } elseif (Test-Path $cacheDirPath) {
    throw "Unable to judge the importance of the cache file. ($cacheDirPath)"
  }
  if (Test-Path $cacheWinDirPath) {
    New-Item $cacheDirPath -ItemType Junction -Target $cacheWinDirPath > $null
  } else {
    throw "cache folder for Win not found."
  }
}


if ($args.Count -gt 1) {
  $newArgs = $args[1..($args.Count - 1)]
} else {
  $newArgs = @()
}
switch ($args[0]) {
  "dart" {
    cmd.exe /C "$flutterBinDirPath\dart.bat" @newArgs
    break
  }
  "dartaotruntime" {
    PowerShell.exe `
      "$flutterBinDirPath\cache\dart-sdk\bin\dartaotruntime.exe" @newArgs
    break
  }
  default {
    cmd.exe /C "$flutterBinDirPath\flutter.bat" @args
  }
}

