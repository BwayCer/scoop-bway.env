# Flutter WSL 適應腳本 Windows & PowerShell 環境


if (!(Test-Path Variable:PSScriptRoot)) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}


$cacheUnixDirPath="$PSScriptRoot\cache.unix"
$cacheWinDirPath="$PSScriptRoot\cache.win"

$flutterBinDirPath="$PSScriptRoot\..\flutter\bin"
$cacheDirPath = "$flutterBinDirPath\cache"
$dartSdkDirPath = "$cacheDirPath\dart-sdk\bin"
$dartUnixPath = "$dartSdkDirPath\dart"
$dartWinPath = "$dartSdkDirPath\dart.exe"


if (-not (Test-Path $dartWinPath)) {
  # $cacheDirPath 路徑下若未存在 $dartUnixPath 或 $dartWinPath 文件
  # 則判斷為可刪除文件。.
  if ((Test-Path $cacheDirPath) -and -not (Test-Path $dartUnixPath)) {
    Remove-Item $cacheDirPath
  }
  if (Test-Path $cacheDirPath) {
    throw "Unable to judge the importance of the cache file. ($cacheDirPath)"
  }
  if (Test-Path $cacheWinDirPath) {
    New-Item $cacheDirPath -ItemType Junction -Target $cacheWinDirPath > $null
  } else {
    throw "cache folder for Win not found."
  }
}
if (-not (Test-Path $dartWinPath)) {
  throw "dart for Win not found."
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

