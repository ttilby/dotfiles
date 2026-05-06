#!/bin/bash
set -euo pipefail

FZF_VERSION="${FZF_VERSION:-0.72.0}"
FZF_REPO="https://github.com/junegunn/fzf.git"

# Use VM-local paths when running inside Lima to avoid conflicts with host binaries
if [[ -d /mnt/lima-cidata ]]; then
    FZF_DIR="/usr/local/lib/fzf"
    FZF_BIN_LINK="/usr/local/bin/fzf"
else
    FZF_DIR="$HOME/.fzf"
    FZF_BIN_LINK=""
fi

SUDO=""
[[ -d /mnt/lima-cidata ]] && SUDO="sudo"

install_fzf() {
    echo "Installing fzf v${FZF_VERSION}..."
    $SUDO git clone --depth 1 --branch "v${FZF_VERSION}" "$FZF_REPO" "$FZF_DIR"
    $SUDO "$FZF_DIR/install" --bin
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
    $SUDO git fetch --depth 1 origin "tag" "v${FZF_VERSION}"
    $SUDO git checkout "v${FZF_VERSION}"
    $SUDO ./install --bin
}

if [[ -d "$FZF_DIR/.git" ]]; then
    upgrade_fzf
else
    [[ -d "$FZF_DIR" ]] && $SUDO rm -rf "$FZF_DIR"
    install_fzf
fi

# Symlink to /usr/local/bin when in Lima VM
if [[ -n "$FZF_BIN_LINK" ]]; then
    $SUDO ln -sf "$FZF_DIR/bin/fzf" "$FZF_BIN_LINK"
fi

echo "fzf v${FZF_VERSION} ready: $("$FZF_DIR/bin/fzf" --version)"
