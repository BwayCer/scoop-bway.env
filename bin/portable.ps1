# 定型化可攜命令


param($subCmd)


$help_main = '
Stereotyped portable command

USAGE: [setEnv [--help]],
       [exportEnv [--help]],
       [completion [--help]],
       [-h, --help]
'

$help_main_setEnv = '
Write windows environmental variables

USAGE: [-r, --restore], [-h, --help]
'
function main_setEnv() {
  echo $args
}

$help_main_exportEnv = '
Change current environmental variables
sh  run `source <(<command> exportEnv --sh)`
ps1 run `<command> exportEnv | ForEach-Object { Invoke-Expression $_ }`

USAGE: [-r, --restore], [-h, --help]
'

$help_main_completion = '
shell command completion.
sh run `source <(<command> completion)`

USAGE: [-h, --help]
'
function fnSh_main_completion() {
  $completionFilePathTxt = "$realPortableRoot\*.completion.cmdEnum"
  if (-not (Test-Path $completionFilePathTxt)) {
    echo "echo 'Not found ""$completionFilePathTxt"" file path.' >&2"
    return
  }

  $txt =            "if type __ysBashComplete_register &> /dev/null ; then"

  Get-ChildItem $completionFilePathTxt | ForEach-Object {
    $txt += $_br + ("  __ysBashComplete_register '{0}'" -f $_)
  }

  $txt +=   $_br + "else"
  $txt +=   $_br + "  echo 'Not found `__ysBashComplete_register` command.' >&2"
  $txt +=   $_br + "fi"
  echo $txt
}


$_br = "
"
if ($realPortableScriptPath -eq $null) {
  $realPortableRoot = $PSScriptRoot
  $realPortablePath = $PSCommandPath
} else {
  $realPortableRoot = Split-Path $realPortableScriptPath
  $realPortablePath = $realPortableScriptPath
}

function setEnv($option, $method, $isPowerShellFormat) {
  $envEnumFilePath = "$realPortableRoot\pkg.envEnum"
  $appDirPath = Split-Path $realPortableRoot
  $appName = (Get-Item $realPortablePath).Basename

  if (-not (Test-Path $envEnumFilePath)) {
    throw "Not found ""$envEnumFilePath"" file path."
  }

  $envEnumTxt = Get-Content $envEnumFilePath |
    Select-String -Pattern '^[A-Za-z0-9_-]+='
  $envEnumTxt = $envEnumTxt -replace '\{\{dir\}\}', $appDirPath
  $envEnumTxt = $envEnumTxt -replace '\{\{app\}\}', $appName

  foreach ($line in $envEnumTxt) {
    $key = $line.split("=")[0]
    $value = $line.split("=")[1]
    switch -Wildcard ("${option}_${method}_${key}") {
      "set_set_PATH" {
        echo "Not set ""$key"" env key."
        break
      }
      "set_set_*" {
        [Environment]::SetEnvironmentVariable($key, $value, 'User')
        break
      }
      "set_restore_PATH" {break}
      "set_restore_*" {
        [Environment]::SetEnvironmentVariable($key, '', 'User')
        break
      }
      "export_set_PATH" {
        echo "echo 'Not set ""$key"" env key.'"
        break
      }
      "export_set_*" {
        if ($isPowerShellFormat) {
          echo ('$env:{0} = "{1}"' -f $key, $value)
        } else {
          echo ('{0}="{1}"' -f $key, $value)
        }
        break
      }
      "export_restore_PATH" {break}
      "export_restore_*" {
        if ($isPowerShellFormat) {
          echo ('$env:{0} = ""' -f $key)
        } else {
          echo ('unset {0}' -f $key)
        }
        break
      }
    }
  }
}


if (@('setEnv', 'exportEnv') -contains $subCmd) {
  if ($args -contains '-h' -or $args -contains '--help') {
    if ($subCmd -eq 'setEnv') {
      echo $help_main_setEnv
    } else {
      echo $help_main_exportEnv
    }
    exit
  }
  $option = if ($subCmd -eq 'setEnv') {'set'} else {'export'}
  $method =
    if ($args -contains '-r' -or $args -contains '--restore') {'restore'}
    else {'set'}
  $isPowerShellFormat =
    if ($args -contains '--sh') {$false}
    else {$true}
  setEnv $option $method $isPowerShellFormat
} elseif  ($subCmd -eq 'completion' ) {
  if ($args -contains '-h' -or $args -contains '--help') {
    echo $help_main_completion
    exit
  }
  fnSh_main_completion
} else {
  echo $help_main
}

