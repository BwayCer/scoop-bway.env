# 解除安裝 Scoop


function pleaseCheckCurrentError($isCompleteOfCommand) {
  if (!$isCompleteOfCommand) {
    'Please check current error.'
    exit 1
  }
}


Where.exe scoop *> $null
$isHasScoopCommand = $?
if ($isHasScoopCommand) {
  $($existedPkgList = scoop list) *> $null
  $existedPkgList | ForEach-Object {
    $pkgName = $_.Name
    $isGlobal = $_.Info -eq "Global install"

    if ($isGlobal) { $globalOptionTxt = " -g" }
    else { $globalOptionTxt = "" }

    'PS > scoop uninstall{0} {1}' -f $globalOptionTxt, $pkgName
    if ($isGlobal) {
      scoop uninstall -g $pkgName
    } else {
      scoop uninstall $pkgName
    }
    pleaseCheckCurrentError $?
  }
}

$scoopPath = [Environment]::GetEnvironmentVariable("SCOOP", "User")
$scoopGlobalPath = [Environment]::GetEnvironmentVariable("SCOOP_GLOBAL", "User")

if ($scoopGlobalPath -ne $null) {
  # if (Test-Path $scoopGlobalPath) {
  #   'PS > Remove-Item -Recurse -Force "{0}"' -f $scoopGlobalPath
  #   Remove-Item -Recurse $scoopGlobalPath
  #   pleaseCheckCurrentError $?
  # }

  'PS > [Environment]::SetEnvironmentVariable("SCOOP_GLOBAL", "", "User")'
  [Environment]::SetEnvironmentVariable("SCOOP_GLOBAL", "", "User")
  pleaseCheckCurrentError $?
}
if ($scoopPath -ne $null) {
  if (Test-Path $scoopPath) {
    'PS > Remove-Item -Recurse -Force "{0}"' -f $scoopPath
    Remove-Item -Recurse -Force $scoopPath
    pleaseCheckCurrentError $?
  }

  'PS > [Environment]::SetEnvironmentVariable("SCOOP", "", "User")'
  [Environment]::SetEnvironmentVariable("SCOOP", "", "User")
  pleaseCheckCurrentError $?
}

$newEnvPathList = New-Object System.Collections.Generic.List[System.Object]
$envPath = [Environment]::GetEnvironmentVariable("PATH", "User")
$envPath -split ";" | ForEach-Object {
  if ($_.IndexOf($scoopPath) -ne -1) {
    'Remove Environment Path: {0}' -f $_
  } elseif ($_.IndexOf($scoopGlobalPath) -ne -1) {
    'Remove Environment Path: {0}' -f $_
  } else {
    $newEnvPathList.Add($_)
  }
}
$newEnvPath = $newEnvPathList -join ';'
if ($envPath -ne $newEnvPath) {
  '[Environment]::SetEnvironmentVariable("PATH", "{0}", "User")' -f $newEnvPath
  [Environment]::SetEnvironmentVariable("PATH", $newEnvPath, "User")
}

