#!/usr/bin/env bash

line=$1
filename=${line%%:*}
temp=${line#*:}
linenumber=${temp%%:*}

let temp=$FZF_PREVIEW_LINES/2
let start=$linenumber-temp
let end=$linenumber+temp

if [[ start -le 0 ]]; then
    let start=0
    let end=$FZF_PREVIEW_LINES
fi

bat --style=numbers --color=always --highlight-line $linenumber \
    --line-range $start:$end $filename
