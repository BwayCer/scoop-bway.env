# 建立對 scoop/shims 的鏈接文件

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'


$shimsDirPath = join-path "$PSScriptRoot" "..\..\..\shims"
if (-not (Test-Path $shimsDirPath)) {
  throw "Pleace install project in Scoop bucket."
}


$_br = '
'
function copyToShim($srcPath, $targetPath, $isNeedSh = $false, $isNeedPs1 = $false) {
  if ($isNeedSh) {
    $shTxt = '#!/bin/sh' + $_br
    $shTxt += 'powershell.exe -noprofile -ex unrestricted "' + $srcPath + '"  "$@"'
    echo $shTxt > "${targetPath}"
  }
  if ($isNeedPs1) {
    $ps1Txt = 'if (!(Test-Path Variable:PSScriptRoot))'
    $ps1Txt +=   ' { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }'
    $ps1Txt += $_br + '$path = "' + $srcPath + '"'
    $ps1Txt += $_br + 'if($myinvocation.expectingInput) { $input | & $path  @args }'
    $ps1Txt +=   ' else { & $path  @args }'
    echo $ps1Txt > "${targetPath}.ps1"
  }
}


copyToShim "$PSScriptRoot\scoop.portable.ps1" "$shimsDirPath\scoop.portable" $true $true

