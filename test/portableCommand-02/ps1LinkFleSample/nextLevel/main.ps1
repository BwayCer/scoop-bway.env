
"b: PSScriptRoot:  {0}" -f $PSScriptRoot
"b: PSCommandPath: {0}" -f $PSCommandPath
"b: MyInvocation:  {0}" -f $MyInvocation.MyCommand.Path
"b: isHasInput: {0}" -f $MyInvocation.expectingInput
"b: Count: {0} args: {1}" -f $args.Count, ($args -join ", ")
"b: tmp: {0}" -f $tmp

$path = join-path $PSScriptRoot ".\nextLevel\main.ps1"
if ($MyInvocation.expectingInput) { $input | & $path @args } else { & $path @args }

