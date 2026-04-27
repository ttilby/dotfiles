#!/bin/bash
# Memory pressure indicator for tmux status bar (macOS only)
# Levels: 1=normal(green), 2=warn(yellow), 4=critical(red)

if [[ "$(uname -s)" != "Darwin" ]]; then
    exit 0
fi

level=$(sysctl -n kern.memorystatus_vm_pressure_level 2>/dev/null)

case "$level" in
    1) echo "#[fg=green]●#[fg=default]" ;;
    2) echo "#[fg=yellow]●#[fg=default]" ;;
    4) echo "#[fg=red]●#[fg=default]" ;;
    *) echo "#[fg=grey]●#[fg=default]" ;;
esac
