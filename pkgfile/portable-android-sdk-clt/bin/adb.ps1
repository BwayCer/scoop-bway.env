portable-android-sdk-clt.ps1 exportEnv | ForEach-Object { Invoke-Expression $_ }
if (!(Test-Path Variable:PSScriptRoot)) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
$path = join-path "$PSScriptRoot" "..\platform-tools\adb.exe"
if($myinvocation.expectingInput) { $input | & $path @args } else { & $path @args }

