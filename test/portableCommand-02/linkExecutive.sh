#!/bin/sh

# 略過Pipe輸入測試。

case "$1" in
  exe ) srcPath='../windowsExecutive/TinyPE.exe' ;;
  * )   srcPath='./ps1LinkFleSample/main.ps1'
esac

_dirsh=$(dirname "$(realpath "$0")")
path=$(wslpath -w "$_dirsh/$srcPath")
powershell.exe "$path" "$@"

