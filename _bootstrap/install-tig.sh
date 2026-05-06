#!/bin/bash
set -euo pipefail

TIG_VERSION="${TIG_VERSION:-2.6.0}"

current=$(tig --version 2>/dev/null | awk '{print $3}' | cut -d- -f1 || true)
if [[ "$current" == "$TIG_VERSION" ]]; then
    echo "tig is already v${TIG_VERSION}"
    exit 0
fi

[[ -n "$current" ]] && echo "Upgrading tig v${current} → v${TIG_VERSION}..." || echo "Installing tig v${TIG_VERSION}..."

if [[ "$(uname -s)" == "Darwin" ]]; then
    brew install tig
else
    if [[ -d /mnt/lima-cidata ]]; then
        TIG_PREFIX="/usr/local"
    else
        TIG_PREFIX="$HOME"
    fi
    tmp=$(mktemp -d)
    trap "rm -rf $tmp" EXIT
    curl -fsSL "https://github.com/jonas/tig/releases/download/tig-${TIG_VERSION}/tig-${TIG_VERSION}.tar.gz" | tar xz -C "$tmp" --strip-components=1
    cd "$tmp"
    make prefix="$TIG_PREFIX" -j"$(nproc)"
    sudo make prefix="$TIG_PREFIX" install
fi

echo "tig v${TIG_VERSION} ready: $(tig --version)"
