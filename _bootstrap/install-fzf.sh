#!/bin/bash
set -euo pipefail

FZF_VERSION="${FZF_VERSION:-0.72.0}"
FZF_DIR="$HOME/.fzf"
FZF_REPO="https://github.com/junegunn/fzf.git"

install_fzf() {
    echo "Installing fzf v${FZF_VERSION}..."
    git clone --depth 1 --branch "v${FZF_VERSION}" "$FZF_REPO" "$FZF_DIR"
    "$FZF_DIR/install" --bin
}

upgrade_fzf() {
    local current
    current=$("$FZF_DIR/bin/fzf" --version 2>/dev/null | awk '{print $1}' || true)
    if [[ "$current" == "$FZF_VERSION" ]]; then
        echo "fzf is already v${FZF_VERSION}"
        return 0
    fi
    echo "Upgrading fzf v${current} → v${FZF_VERSION}..."
    cd "$FZF_DIR"
    git fetch --depth 1 origin "tag" "v${FZF_VERSION}"
    git checkout "v${FZF_VERSION}"
    ./install --bin
}

if [[ -d "$FZF_DIR/.git" ]]; then
    upgrade_fzf
else
    [[ -d "$FZF_DIR" ]] && rm -rf "$FZF_DIR"
    install_fzf
fi

echo "fzf v${FZF_VERSION} ready: $("$FZF_DIR/bin/fzf" --version)"
