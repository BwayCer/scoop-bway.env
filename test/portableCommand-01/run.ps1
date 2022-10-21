
$binPath = "$PSScriptRoot\bin"
$env:PATH = "$binPath;$env:PATH"

"PS > $binPath\portable-pkg.ps1 exportEnv"
portable-pkg.ps1 exportEnv | ForEach-Object { "  $_" }

""
"PS > $binPath\portable-pkg.ps1 completion"
$($(portable-pkg.ps1 completion) -split "\n") | ForEach-Object { "  $_" }

""
"PS > $binPath\pkgCommand.ps1"
"  (run project/test/windowsExecutive/TinyPE.exe then pop up a window.)"
pkgCommand.ps1

