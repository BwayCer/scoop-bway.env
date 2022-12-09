# 安裝 Scoop & Bway bucket

# https://scoop.sh/
# https://github.com/lukesampson/scoop


param($paramScoopPath, $paramScoopGlobalPath)


$defaultScoopPath = "$HOME\ph\scoop"


# 允許執行腳本權限.
$allowExecutionPolicyList = @('AllSigned', 'Bypass', 'RemoteSigned')
$currExecutionPolicy = Get-ExecutionPolicy
if (-not ($allowExecutionPolicyList -contains $currExecutionPolicy)) {
  "Current execution policy: $originExecutionPolicy"
  'Please set execution policy: {0}' -f ($allowExecutionPolicyList -join ", ")
  'ex: Set-ExecutionPolicy RemoteSigned -scope CurrentUser'
} else {
  # 安裝 scoop 程式包管理工具.
  Where.exe scoop *> $null
  $isHasScoopCommand = $?
  if ($isHasScoopCommand) {
    'scoop command is existed.'
    $scoopPath = $env:SCOOP
  } else {
    # 設定 Scoop 安裝程式包目錄路徑.
    $userEnvSCOOP = [Environment]::GetEnvironmentVariable('SCOOP', 'User')
    $userEnvSCOOPGLOBAL = [Environment]::GetEnvironmentVariable('SCOOP_GLOBAL', 'User')
    if ($paramScoopPath -ne $null) {
      $scoopPath = $paramScoopPath
    } elseif ($userEnvSCOOP -ne $null) {
      $scoopPath = $userEnvSCOOP
    } else {
      $scoopPath = $defaultScoopPath
    }
    if ($paramScoopGlobalPath -ne $null) {
      $scoopGlobalPath = $paramScoopGlobalPath
    } elseif ($userEnvSCOOPGLOBAL -ne $null) {
      $scoopGlobalPath = $userEnvSCOOPGLOBAL
    }

    # 設定環境變量.
    'Set env SCOOP: {0}' -f $scoopPath
    [Environment]::SetEnvironmentVariable('SCOOP', $scoopPath, 'User')
    $env:SCOOP = $scoopPath
    if ($scoopGlobalPath -ne $null) {
      # 以管理員身分安裝時為全域安裝.
      'Set env SCOOP_GLOBAL: {0}' -f $scoopGlobalPath
      [Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $scoopGlobalPath, 'User')
      $env:SCOOP_GLOBAL = $scoopGlobalPath
    }

    # 如果目錄存在則視為再次安裝，只需補齊環境變數.
    $scoopShimsPath = "$scoopPath\shims"
    if (Test-Path $scoopShimsPath) {
      $envPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
      if (-not ($envPath -split ";" -contains $scoopShimsPath)) {
        'Set env path: "{0}"' -f $scoopShimsPath
        $newEnvPath = '{0};{1}' -f $scoopShimsPath, $envPath
        [Environment]::SetEnvironmentVariable('PATH', $newEnvPath, 'User')
      }
    } else {
      # 安裝 Scoop
      # Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
      # or
      iwr get.scoop.sh | iex
    }
  }

  # 安裝常用程式包
  # - sudo: 取得管理員權限
  # - git: scoop 安裝其他 bucket 的依賴程式包.
  $($existedPkgList = scoop list) *> $null
  $isExistedSudoPkg = $existedPkgList.Name -contains "sudo"
  $isExistedGitPkg = $existedPkgList.Name -contains "git"
  if (-not ($isExistedSudoPkg -and $isExistedGitPkg)) {
    'Install "sudo", "git" package:'
    scoop install sudo git
  } elseif (-not $isExistedSudoPkg) {
    'Install "sudo" package:'
    scoop install sudo
  } elseif (-not $isExistedGitPkg) {
    'Install "git" package:'
    scoop install git
  } else {
    '"sudo", "git" package is existed.'
  }


  # 安裝Bway程式桶.
  $bwayBucketPath = '{0}\buckets\bway' -f $scoopPath
  $envPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
  if (-not (Test-Path $bwayBucketPath)) {
    'Install "Bway" bucket:'
    scoop bucket add bway "https://github.com/BwayCer/scoop-bway.env"
  }
  $bwayBinPath = '{0}\bin' -f $bwayBucketPath
  if ($envPath -split ";" -contains $bwayBinPath) {
    '"{0}" environment path is existed.' -f $bwayBinPath
  } else {
    'Set "{0}" environment path:' -f $bwayBinPath
    $newEnvPath = '{0};{1}' -f $bwayBinPath, $envPath
    [Environment]::SetEnvironmentVariable('PATH', $newEnvPath, 'User')
  }
}

