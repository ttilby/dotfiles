#!/usr/bin/env bash
# Network speed sparkline for tmux status bar
# Usage: net-speed-graph.sh [interface]
# Stores history in /tmp/tmux-net-speed-*

IFACE="${1:-en0}"
HIST_DOWN="/tmp/tmux-net-speed-down-$IFACE"
HIST_UP="/tmp/tmux-net-speed-up-$IFACE"
PREV="/tmp/tmux-net-speed-prev-$IFACE"
WIDTH=10
SPARKS=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

# Get current cumulative bytes
if [[ "$(uname -s)" == "Darwin" ]]; then
    read -r rx tx <<< "$(netstat -ib -I "$IFACE" | awk 'NR==2 {print $7, $10}')"
else
    rx=$(cat "/sys/class/net/$IFACE/statistics/rx_bytes" 2>/dev/null)
    tx=$(cat "/sys/class/net/$IFACE/statistics/tx_bytes" 2>/dev/null)
fi

[[ -z "$rx" || -z "$tx" ]] && exit 0

# Calculate rate from previous sample
if [[ -f "$PREV" ]]; then
    read -r prev_rx prev_tx prev_time < "$PREV"
    now=$(date +%s)
    elapsed=$((now - prev_time))
    [[ $elapsed -lt 1 ]] && elapsed=1
    rate_down=$(( (rx - prev_rx) / elapsed ))
    rate_up=$(( (tx - prev_tx) / elapsed ))
    [[ $rate_down -lt 0 ]] && rate_down=0
    [[ $rate_up -lt 0 ]] && rate_up=0

    # Append to history, keep last WIDTH entries
    echo "$rate_down" >> "$HIST_DOWN"
    echo "$rate_up" >> "$HIST_UP"
    tail -n "$WIDTH" "$HIST_DOWN" > "$HIST_DOWN.tmp" && mv "$HIST_DOWN.tmp" "$HIST_DOWN"
    tail -n "$WIDTH" "$HIST_UP" > "$HIST_UP.tmp" && mv "$HIST_UP.tmp" "$HIST_UP"
fi

echo "$rx $tx $(date +%s)" > "$PREV"

# Render sparkline from history file
sparkline() {
    local file="$1"
    [[ ! -f "$file" ]] && return
    local -a vals
    while IFS= read -r line; do
        vals+=("$line")
    done < "$file"
    local max=1
    for v in "${vals[@]}"; do
        [[ $v -gt $max ]] && max=$v
    done
    local out=""
    for v in "${vals[@]}"; do
        local idx=$(( v * 7 / max ))
        [[ $idx -gt 7 ]] && idx=7
        out+="${SPARKS[$idx]}"
    done
    echo -n "$out"
}

# Format rate as human readable
fmt() {
    local b=$1
    if [[ $b -ge 1048576 ]]; then
        echo -n "$(( b / 1048576 ))M"
    elif [[ $b -ge 1024 ]]; then
        echo -n "$(( b / 1024 ))K"
    else
        echo -n "${b}B"
    fi
}

# Get latest rates for label
last_down=$(tail -1 "$HIST_DOWN" 2>/dev/null)
last_up=$(tail -1 "$HIST_UP" 2>/dev/null)
[[ -z "$last_down" ]] && last_down=0
[[ -z "$last_up" ]] && last_up=0

echo -n "↓$(fmt $last_down) $(sparkline "$HIST_DOWN") ↑$(fmt $last_up) $(sparkline "$HIST_UP")"
