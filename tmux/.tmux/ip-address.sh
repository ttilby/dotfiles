#!/bin/bash
if [[ "$(uname -s)" == "Darwin" ]]; then
    ipconfig getifaddr en0 2>/dev/null || echo "no ip"
else
    ip -4 addr show eno1 2>/dev/null | awk '/inet / {split($2,a,"/"); print a[1]}' || echo "no ip"
fi
