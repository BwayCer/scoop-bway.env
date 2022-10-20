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

  $env:PATH = "$portableScoopPath\shims;" + $originEnvPATH
  $env:SCOOP = $portableScoopPath

  switch ($args[0]) {
    { @("install", "uninstall", "list") -contains $_ } {
      $originUserEnvPATH = [Environment]::GetEnvironmentVariable('PATH', 'User')
      scoop @args
      [Environment]::SetEnvironmentVariable('PATH', $originEnvPATH, 'User')
      break
    }
    default {
      @args
    }
  }
} finally {
  $env:PATH = $zzzzzzOriginEnvPATH
  $env:SCOOP = $zzzzzzOriginEnvSCOOP
}

