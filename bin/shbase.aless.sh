#!/bin/bash
# 腳本基礎 - 較少的腳本


##shStyle fColor


# _fColor <顏色表示值>
# 顏色表示值：
#   共四碼，分別表示： 字體色、粗體、背景色、底線。
#   字體色、背景色： 可表示值有 9 種
#     * N： 無設定
#     * 0： 黑 black
#     * 1： 紅 red
#     * 2： 綠 green
#     * 3： 黃 yellow
#     * 4： 藍 blue
#     * 5： 粉 magenta
#     * 6： 青 cyan
#     * 7： 白 white
#   粗體、底線： 可表示值有 2 種
#     * 0： 否
#     * 1： 是
#   例如：
#     * 紅色粗體： _fColor 11、_fColor 11N0
#     * 紅色粗體白底： _fColor 117、_fColor 1170
#     * 紅色粗體白底底線： _fColor 1171
_fColor() {
  local bgcolor underline
  local setFont=$1
  local color=${setFont:0:1}
  local bold=${setFont:1:1}

  [ $_fColor_usable -eq 0 ] && return

  if [ "$setFont" == "N" ]; then
    printf "\e[00m"
    return
  fi

  case "$color" in
    [01234567] )
      printf "\e[3${color}m"
      ;;
  esac

  if [ "$bold" == "1" ]; then
    printf "\e[01m"
  fi

  [ $setFont -lt 100 ] && return

  bgcolor=${1:2:1}
  underline=${1:3:1}

  case "$bgcolor" in
    [01234567] )
      printf "\e[4${bgcolor}m"
      ;;
  esac

  if [ "$underline" == "1" ]; then
    printf "\e[04m"
  fi
}

_fColor_usable=`[ -t 1 ] && echo 1 || echo 0`

# 提供 3+1 種基本色變量
#   * _fN： 無色
#   * _fRedB： 粗體紅色
#   * _fGreB： 粗體綠色
#   * _fYelB： 粗體黃色
_fN=`_fColor N`
_fRedB=`_fColor 11`
_fGreB=`_fColor 21`
_fYelB=`_fColor 31`


# ##shStyle fColor-easy
# _fN=`printf "\e[00m"`
# _fRedB=`printf "\e[31;01m"`
# _fGreB=`printf "\e[32;01m"`
# _fYelB=`printf "\e[33;01m"`


##shStyle parseOption


shs_poShift=0
shs_poArgs=()
shs_poErrMsgs=()
shs_poOpt=""
shs_poVal=""
shs_parseOption() {
  local cutLen=0

  local prevOpt=$shs_poOpt
  local prevVal=$shs_poVal
  shs_poOpt=""
  shs_poVal=""

  case $shs_poShift in
    # 0 ) ;; # 0 視為開始
    # 已使用 1 個參數
    1 ) cutLen=1 ;;
    # 已使用 2 個參數
    2 ) cutLen=2 ;;
    3 )
      cutLen=1
      shs_poErrMsgs+=("找不到 \"$prevOpt\" 選項。")
      ;;
    4 )
      if [ -n "$prevVal" ]; then
        cutLen=2
        prevVal="\"$prevVal\""
      else
        cutLen=1
        prevVal="null"
      fi
      shs_poErrMsgs+=("$prevVal 不符合 \"$prevOpt\" 選項的預期值。")
      [ -n "$prevVal" ] && prevVal="\"$prevVal\"" || prevVal="null"
      ;;
  esac
  [ $cutLen -gt 0 ] && shs_poArgs=("${shs_poArgs[@]:$cutLen}")

  local nextOpt
  local opt=${shs_poArgs[0]}
  local val=${shs_poArgs[1]}

  if [ "$opt" == "--" ] || [[ ! "$opt" =~ ^- ]]; then
    [ "$opt" == "--" ] && shs_poArgs=("${shs_poArgs[@]:1}")
    shs_poOpt="--"
    return
  fi

  if [[ "$opt" =~ ^-[^-]. ]]; then
    nextOpt="-${opt:2}"
    opt=${opt:0:2}
    val=""
    shs_poArgs=("$nextOpt" "${shs_poArgs[@]:1}")
  elif [[ "$val" =~ ^-. ]]; then
    val=""
  fi

  shs_poOpt="$opt"
  shs_poVal="$val"
}
shs_parseOption_start() {
  shs_poShift=0
  shs_poArgs=("$@")
  shs_poErrMsgs=()
}
shs_parseOption_end() {
  local filename="$1"

  local argu
  if [ ${#shs_poArgs[@]} -gt 0 ]; then
    for argu in "${shs_poArgs[@]}"
    do
      [[ ! "$argu" =~ ^_- ]] && continue
      shs_poErrMsgs+=('不符合 "[命令] [選項] [參數]" 的命令用法。')
      break
    done
  fi

  local errMsg
  local formatArgus="$_fRedB[$filename]: %s$_fN$_br"
  if [ ${#shs_poErrMsgs[@]} -gt 0 ]; then
    for errMsg in "${shs_poErrMsgs[@]}"
    do
      printf "$formatArgus" "$errMsg" >&2
    done

    return 1
  fi
}


##shStyle showHelp


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


##shStyle abase


_PWD=$PWD
_br="
"

shs_ynHasSubCmd=0
shs_route() {
  local cmdPrefix="$1"; shift

  local fnRoute="fnShRoute_$cmdPrefix"
  local shCmd=""
  local subCmd=""

  while [ -n "y" ]
  do
    subCmd=$1
    shs_ynHasSubCmd=0
    "$fnRoute" "${shCmd}_$subCmd"
    [ $shs_ynHasSubCmd -eq 1 ] && shift || break
    shCmd+="_$subCmd"
  done

  if [ -n "$shCmd" ]; then
    shs_ynHasSubCmd=1
    "fnSh_$cmdPrefix$shCmd" "$@" || :
  else
    shs_ynHasSubCmd=0
  fi
}

