#!/bin/bash
# 定型化可攜命令


# 文件路徑資訊
__filename=`realpath "$0"`
_dirsh=`dirname "$__filename"`
_fileName=`basename "$__filename"`

_projectDirsh=`dirname "$_dirsh"`


#help:fnSh_main
# 定型化可攜命令
# [[USAGE]]
# [[SUBCMD]]
#   setEnv       寫入 Windows 環境變數
#   exportEnv    改變當前的環境變數
#   completion   命令列舉自動補齊
# [[OPT]]
#   -h, --help   幫助。
#pleh
fnSh_main() {
  subCmd="$1"
  if [[ "$subCmd" =~ ^(setEnv|exportEnv|completion)$ ]]; then
    "fnSh_main_${subCmd}" "${@:2}"
  else
    shs_showHelp "$__filename" "fnSh_main"
  fi
}

#help:fnSh_main_setEnv
# 寫入 Windows 環境變數
# [[USAGE]]
# [[OPT]]
#   -r, --restore   清除被寫入的環境變數。
#   -h, --help      幫助。
#pleh
fnSh_main_setEnv() {
  local optionMethod="set"

  while true
  do
    case "$1" in
      -r | --restore )
        optionMethod="restore"
        shift 1
        ;;
      -h | --help )
        shs_showHelp "$__filename" "fnSh_main_setEnv"
        return
        ;;
      * ) break ;;
    esac
  done

  fnSetEnv "set" "$optionMethod" "$_dirsh/pkg.envEnum" "$_projectDirsh" "$_fileName"
}

#help:fnSh_main_exportEnv
# 改變當前的環境變數
# 執行 \`source <(<命令名> exportEnv)\` 命令改變當前的環境變數。
# [[USAGE]]
# [[OPT]]
#   -h, --help   幫助。
#pleh
fnSh_main_exportEnv() {
  local optionMethod="set"

  while true
  do
    case "$1" in
      -r | --restore )
        optionMethod="restore"
        shift 1
        ;;
      -h | --help )
        shs_showHelp "$__filename" "fnSh_main_exportEnv"
        return
        ;;
      * ) break ;;
    esac
  done

  fnSetEnv "export" "$optionMethod" "$_dirsh/pkg.envEnum" "$_projectDirsh" "$_fileName"
}

#help:fnSh_main_completion
# 命令列舉自動補齊
# 執行 \`source <(<命令名> completion)\` 命令建立命令自動補齊功能。
# [[USAGE]]
# [[OPT]]
#   -h, --help   幫助。
#pleh
fnSh_main_completion() {
  while true
  do
    case "$1" in
      -h | --help )
        shs_showHelp "$__filename" "fnSh_main_completion"
        return
        ;;
      * ) break ;;
    esac
  done

  if type __ysBashComplete_register &> /dev/null ; then
    echo 'Not found `__ysBashComplete_register` command.' >&2
    exit 1
  fi

  for filePath in $(ls -1 "$_dirsh"/*.completion.cmdEnum)
  do
    echo "__ysBashComplete_register \"$filePath\""
  done
}


fnSetEnv() {
  option="$1" # set, export
  method="$2" # set, restore
  envEnumFilePath="$3"
  appDirPath="$4"
  appName="$5"

  if ! type cygpath &> /dev/null ; then
    echo "Not found \"cygpath\" command." >&2
    exit 1
  fi
  if ! type shTemplate &> /dev/null ; then
    echo "Not found \"shTemplate\" command." >&2
    exit 1
  fi

  if [ ! -f "$envEnumFilePath" ]; then
    echo "Not found \"$envEnumFilePath\" file path." >&2
    exit 1
  fi

  appDirWindowPath=$(cygpath -w "$appDirPath" | sed 's/\\/\\\\/g')
  envEnumTxt=$(
    cat "$envEnumFilePath" |
      grep "^[A-Za-z0-9_-]\+=" |
      "shTemplate" --template - \
        --argu "dir=$appDirWindowPath" \
        --argu "app=$appName"
  )

  local key value
  while read line
  do
    key=`  cut -d "=" -f 1  <<< "$line"`
    value=`cut -d "=" -f 2- <<< "$line"`
    case "${option}_${method}_${key}" in
      set_set_PATH )
        echo "Not set \"$key\" env key."
        ;;
      set_set_* )
        powershell \
          -Command "[Environment]::SetEnvironmentVariable('$key', '$value', 'User')"
        ;;
      set_restore_PATH )
        ;;
      set_restore_* )
        powershell \
          -Command "[Environment]::SetEnvironmentVariable('$key', '', 'User')"
        ;;
      export_set_PATH )
        echo "echo 'Not set \"$key\" env key.'"
        ;;
      export_set_* )
        echo "export $key='$value'"
        ;;
      export_restore_PATH )
        ;;
      export_restore_* )
        echo "unset $key"
        ;;
    esac
  done <<< "$envEnumTxt"
}


shs_showHelp() {
  local filename="$1"
  local cmdName="$2"

  local helpMarkTxt=`
    grep -n "^#\(help:\w\+\|pleh\)$" "$filename" |
      grep -m 1 -A 1 "#help:$cmdName\$" |
      cut -d : -f 1
  `
  [ -n "$helpMarkTxt" ] || return

  local startNum=`sed -n 1p <<< "$helpMarkTxt"`
  local endNum=`  sed -n 2p <<< "$helpMarkTxt"`
  local txtHelp=`sed -n "$((startNum + 1)),$((endNum - 1))p" "$filename" | sed "s/^# //"`

  local usage
  local bisUsage=` echo "$txtHelp" | grep "\[\[USAGE\]\]"`
  local bisSubCmd=`echo "$txtHelp" | grep "\[\[SUBCMD\]\]"`
  local bisOpt=`   echo "$txtHelp" | grep "\[\[OPT\]\]"`

  if [ -n "$bisUsage" ]; then
    usage="用法："
    [ -n "$bisSubCmd" ] && usage+=" [命令]"
    [ -n "$bisOpt" ] && usage+=" [選項]"

    txtHelp=`echo "$txtHelp" | sed "s/\[\[USAGE\]\]/\n$usage/"`
  fi

  [ -n "$bisSubCmd" ] && \
    txtHelp=`echo "$txtHelp" | sed "s/\[\[SUBCMD\]\]/\\n\\n命令：\\n/"`

  [ -n "$bisOpt" ] && \
    txtHelp=`echo "$txtHelp" | sed "s/\[\[OPT\]\]/\\n\\n選項：\\n/"`

  echo "$txtHelp$_br"
  return
}


fnSh_main "$@"

