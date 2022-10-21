
$tmp = 'bway'

"a: PSScriptRoot:  {0}" -f $PSScriptRoot
"a: PSCommandPath: {0}" -f $PSCommandPath
"a: MyInvocation:  {0}" -f $MyInvocation.MyCommand.Path
"a: isHasInput: {0}" -f $MyInvocation.expectingInput
"a: Count: {0} args: {1}" -f $args.Count, ($args -join ", ")
"a: tmp: {0}" -f $tmp

$path = join-path $PSScriptRoot ".\nextLevel\main.ps1"
# `@agrs` 不能替換為 `$args`
if ($MyInvocation.expectingInput) { $input | & $path @args } else { & $path @args }

