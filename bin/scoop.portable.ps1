# Scoop 可攜版


param($Path)

# 未指定路徑 ;
if ($Path -eq $null) {
  throw "Not found `-Path` option."
}

# 未包含執行命令 ;
if ($args.Length -lt 1) {
  throw "No command ?"
}

# 未發現 Scoop 命令
$origEnvScoopPath = $env:SCOOP
if (-not (Test-Path "$origEnvScoopPath\shims") -Or -not (Test-Path "$origEnvScoopPath\apps\scoop")) {
  throw "Not found `scoop` command."
}

# 是否為新的 Scoop 安裝路徑
if (-not (Test-Path "$Path\shims") -Or -not (Test-Path "$Path\apps\scoop")) {
  $runTimes = 0
  do {
    $isUseThePath = Read-Host "Is to use ""$Path"" path [Y/N]"
    if ($isUseThePath -match "^(y|Y|yes|Yes)$") {
      break
    } elseif ($isUseThePath -match "^(n|N|no|No)$") {
      exit
    }
    if ($runTimes -ge 2) {
      echo "Please provide `-Path` options."
      exit
    }
    $runTimes += 1
  } until (false)

  if (-not (Test-Path "$Path\shims")) {
    New-Item "$Path\shims" -ItemType Directory | Out-Null
  }
  if (-not (Test-Path "$Path\apps\scoop")) {
    if (-not (Test-Path "$Path\apps")) {
      New-Item "$Path\apps" -ItemType Directory | Out-Null
    }
    Copy-Item "$origEnvScoopPath\apps\scoop" "$Path\apps" -Force -Recurse
  }
  if (-not (Test-Path "$Path\buckets\bway")) {
    if (-not (Test-Path "$Path\buckets")) {
      New-Item "$Path\buckets" -ItemType Directory | Out-Null
    }
    Copy-Item "$PSScriptRoot\.." "$Path\buckets\bway" -Force -Recurse
  }
}

try {
  $env:SCOOP = $Path
  powershell.exe scoop $args
} finally {
  $env:SCOOP = $origEnvScoopPath
}

