$path = join-path "$PSScriptRoot" "..\platform-tools\fastboot.exe"
if ($myinvocation.expectingInput) { $input | & $path @args }
else { & $path @args }

