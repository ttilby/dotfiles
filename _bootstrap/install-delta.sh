#!/bin/bash
set -euo pipefail

DELTA_VERSION="${DELTA_VERSION:-0.19.2}"

current=$(delta --version 2>/dev/null | awk '{print $2}' || true)
if [[ "$current" == "$DELTA_VERSION" ]]; then
    echo "delta is already v${DELTA_VERSION}"
    exit 0
fi

[[ -n "$current" ]] && echo "Upgrading delta v${current} → v${DELTA_VERSION}..." || echo "Installing delta v${DELTA_VERSION}..."

if [[ "$(uname -s)" == "Darwin" ]]; then
    brew install git-delta
else
    tmp=$(mktemp --suffix=.deb)
    trap "rm -f $tmp" EXIT
    curl -fsSL -o "$tmp" "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
    sudo dpkg -i "$tmp"
fi

echo "delta v${DELTA_VERSION} ready: $(delta --version)"
