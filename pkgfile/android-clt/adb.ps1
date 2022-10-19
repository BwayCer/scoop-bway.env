$path = join-path "$PSScriptRoot" "..\platform-tools\adb.exe"
if ($myinvocation.expectingInput) { $input | & $path @args }
else { & $path @args }

