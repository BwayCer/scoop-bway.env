# 建立對 scoop/shims 的鏈接文件


$binRelativePath = "..\buckets\bway\bin"
$shimsDirPath = Join-Path "$PSScriptRoot" "..\..\..\shims"
if (-not (Test-Path $shimsDirPath)) {
  throw "Pleace install project in Scoop bucket."
}


$_br = '
'
function copyToShim($ext, $srcPath, $targetPath, $isNeedSh = $false, $isNeedPs1 = $false) {
  if ($isNeedSh) {
    $shTxt = '#!/bin/sh' + $_br
    $shTxt += 'path="{0}\{1}"' -f '$(cygpath -w "$(dirname "$(realpath "$0")")")', $srcPath
    if ($ext -eq "sh") {
      $shTxt += $_br + 'exec "$path" "$@"'
    } else {
      $shTxt += $_br + 'powershell.exe -noprofile -ex unrestricted "$path" "$@"'
    }
    [IO.File]::WriteAllLines($targetPath, $shTxt)
  }
  if ($isNeedPs1) {
    $shTxt = 'if (!(Test-Path Variable:PSScriptRoot))'
    $shTxt += ' { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }'
    $shTxt += $_br + '$path = Join-Path "$PSScriptRoot" "' + $srcPath + '"'
    $shTxt += $_br + 'if($myinvocation.expectingInput) { $input | & $path @args }'
    $shTxt += ' else { & $path @args }'
    [IO.File]::WriteAllLines("${targetPath}.ps1", $shTxt)
  }
}


@(
  ("ps1.sh",          "sh",  $true, $false, "ps1.sh"),
  ("scoop.portable",  "ps1", $true, $true,  "scoop.portable.ps1"),
  ("portable",        "ps1", $false, $true, "portable.ps1"),
  ("portable.sh",     "ps1", $true, $false, "portable.ps1")
) | ForEach-Object {
  copyToShim $_[1] ("$binRelativePath\{0}" -f $_[4]) ("$shimsDirPath\{0}" -f $_[0]) $_[2] $_[3]
}

Copy-Item "$PSScriptRoot\ysBashComplete" "$shimsDirPath\ysBashComplete" -Force

