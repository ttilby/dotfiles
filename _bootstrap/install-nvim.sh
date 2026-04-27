#!/bin/bash
set -euo pipefail

# Usage: NVIM_VERSION=v0.12.0 _bootstrap/install-nvim.sh

NVIM_VERSION="${NVIM_VERSION:-v0.12.0}"
NVIM_INSTALL_DIR="${NVIM_INSTALL_DIR:-$HOME/apps/nvims}"
NVIM_BIN_DIR="${NVIM_BIN_DIR:-$HOME/bin}"
NVIM_NAME="nvim-${NVIM_VERSION}"
NVIM_PATH="${NVIM_INSTALL_DIR}/${NVIM_NAME}"

OS="$(uname -s)"
ARCH="$(uname -m)"
if [[ "$OS" == "Darwin" ]]; then
    NVIM_ARCHIVE="nvim-macos-arm64"
else
    NVIM_ARCHIVE="nvim-linux-x86_64"
fi

current=$(nvim --version 2>/dev/null | head -1 | awk '{print $2}' || true)
if [[ "$current" == "$NVIM_VERSION" && -L "$NVIM_BIN_DIR/nvim" ]]; then
    echo "nvim is already ${NVIM_VERSION}"
    exit 0
fi

[[ -n "$current" ]] && echo "Upgrading nvim ${current} → ${NVIM_VERSION}..." || echo "Installing nvim ${NVIM_VERSION}..."

mkdir -p "$NVIM_INSTALL_DIR" "$NVIM_BIN_DIR"

if [ ! -d "$NVIM_PATH" ]; then
    tmp=$(mktemp -d)
    trap "rm -rf $tmp" EXIT
    curl -fsSL -o "$tmp/${NVIM_ARCHIVE}.tar.gz" \
        "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_ARCHIVE}.tar.gz"
    tar xzf "$tmp/${NVIM_ARCHIVE}.tar.gz" -C "$tmp"
    mv "$tmp/${NVIM_ARCHIVE}" "$NVIM_PATH"
fi

ln -sf "$NVIM_PATH/bin/nvim" "$NVIM_BIN_DIR/nvim"

echo "nvim ${NVIM_VERSION} ready: $(nvim --version | head -1)"

# Ensure pynvim virtualenv exists and is up to date
NVIM_VENV="$HOME/.virtualenvs/nvimvenv"
if [ ! -d "$NVIM_VENV" ]; then
    echo "Creating pynvim virtualenv..."
    mkdir -p "$HOME/.virtualenvs"
    python3 -m venv "$NVIM_VENV"
fi
"$NVIM_VENV/bin/pip" install --quiet --upgrade pynvim
