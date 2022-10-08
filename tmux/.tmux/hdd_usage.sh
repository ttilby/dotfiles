#!/bin/bash

# Displays hdd usage in the format <current>/<total> <percent used>
# E.g. 608G/983G 66%
# Intended to be used in the tmux status bar

df -H $0 | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print " " $3 "/" $2 " " $5 }'
