# 建立/還原目錄硬連結
# 方便將資料收集在同一資料夾內


param($method, $targetPath, $linkPath)

# NOTE: 遇錯誤時運行中止 (遇到 `Move-Item` 拋出錯誤卻不停止的情況) .
$ErrorActionPreference = "Stop"


$originMark="originByPasson"
$originPath="$targetPath.$originMark"
$currentLinkTarget=""

if (-not (Test-Path $linkPath)) {
  throw ('The "{0}" link path is not exist.' -f $linkPath)
}
if (Test-Path $targetPath) {
  $targetItem = Get-Item $targetPath
  $targetLinkType = $targetItem.LinkType
  if ($targetLinkType -eq "Junction") {
    $currentLinkTarget = $targetItem.Target
  } else {
    if (Test-Path $originPath) {
      throw ('The "{0}" and ".{1}" folder is both exist.' -f `
          $targetPath, $originMark)
    }

    # 如果目標路徑 $targetPath 存在非鏈接文件 Junction
    # 且原始目錄路徑 $originPath 不存在文件，則執行... .
    Move-Item $targetPath $originPath
    New-Item $targetPath -ItemType Junction -Target $originPath | Out-Null
  }
} else {
  if (-not (Test-Path $originPath)) {
    New-Item $originPath -ItemType Directory | Out-Null
  }
  New-Item $targetPath -ItemType Junction -Target $originPath | Out-Null
}

# 移除鏈接文件 Junction 的方法
#   https://learn.microsoft.com/en-us/answers/questions/63800/cannot-delete-junction-that-points-to-directory-th.html
#   https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc785451(v=ws.11)?redirectedfrom=MSDN
function removeTargetPath() {
  fsutil reparsepoint delete $targetPath
  Remove-Item $targetPath
}

switch ($method) {
  "lnk" {
    if ($currentLinkTarget -ne $linkPath) {
      removeTargetPath
      New-Item $targetPath -ItemType Junction -Target $linkPath | Out-Null
    }
  }
  "recover" {
    if ($currentLinkTarget -ne $originPath) {
      removeTargetPath
      New-Item $targetPath -ItemType Junction -Target $originPath | Out-Null
    }
  }
}

