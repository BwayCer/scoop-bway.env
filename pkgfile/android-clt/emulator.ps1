$path = join-path "$PSScriptRoot" "..\emulator\emulator.exe"
if ($myinvocation.expectingInput) { $input | & $path @args }
else { & $path @args }

