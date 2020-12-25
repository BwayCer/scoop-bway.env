#!/bin/bash
# 在 mintty 中另開 PowerShell 執行命令
# `start` 類似背景執行，不會等待
# `-NoExit` 選項可使命令執行完後不退出
# `-Command` 選項與 `sh -c "..."` 功能相同
start powershell.exe "$@"

