
switch ($args[0]) {
  "exe" {
    $srcPath='..\windowsExecutive\TinyPE.exe'
    break
  }
  default {
    $srcPath='.\ps1LinkFleSample\main.ps1'
  }
}

$path = Join-Path "$PSScriptRoot" "$srcPath"
if($myinvocation.expectingInput) {
  $input | & $path @args
} else {
  & $path @args
}

