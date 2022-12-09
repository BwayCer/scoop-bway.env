# Scoop 可攜版


param($portableScoopPath)

# 未指定路徑 ;
if ($portableScoopPath -eq $null) {
  throw "Not found `-Path` option."
}

# 未包含執行命令 ;
if ($args.Length -lt 1) {
  throw "No command ?"
}


$originEnvPATH = $env:PATH
$originEnvSCOOP = $env:SCOOP

if (-not (Test-Path $portableScoopPath)) {
  New-Item $portableScoopPath -ItemType Directory | Out-Null
}
if (-not (Test-Path "$portableScoopPath\buckets")) {
  New-Item "$portableScoopPath\buckets" `
    -ItemType Junction -Target "$originEnvSCOOP\buckets" | Out-Null
}


try {
  # 避免被覆寫.
  $zzzzzzOriginEnvPATH = $originEnvPATH
  $zzzzzzOriginEnvSCOOP = $originEnvSCOOP
  $zzzzzzOriginUserEnvPATH = [Environment]::GetEnvironmentVariable('PATH', 'User')

  $env:PATH = "$portableScoopPath\shims;" + $originEnvPATH
  $env:SCOOP = $portableScoopPath

  switch ($args[0]) {
    { @("install", "uninstall", "list") -contains $_ } {
      scoop @args
      break
    }
    default {
      PowerShell.exe @args
    }
  }
} finally {
  $newUserEnvPATH = [Environment]::GetEnvironmentVariable('PATH', 'User')
  if ($newUserEnvPATH -ne $zzzzzzOriginUserEnvPATH) {
    [Environment]::SetEnvironmentVariable('PATH', $zzzzzzOriginUserEnvPATH, 'User')
  }
  $env:PATH = $zzzzzzOriginEnvPATH
  $env:SCOOP = $zzzzzzOriginEnvSCOOP
}

