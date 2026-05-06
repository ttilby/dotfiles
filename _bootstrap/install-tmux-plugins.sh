#!/bin/bash
set -euo pipefail

# Run after stow — requires tmux.conf to be linked

OS="$(uname -s)"

# Install TPM if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install TPM plugins (headless)
echo "Installing TPM plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

# Build tmux-mem-cpu-load if present but not compiled
MEMCPU="$HOME/.tmux/plugins/tmux-mem-cpu-load"
if [ -d "$MEMCPU" ] && [ ! -f "$MEMCPU/tmux-mem-cpu-load" ]; then
    if ! command -v cmake >/dev/null 2>&1; then
        echo "Installing cmake..."
        if [[ "$OS" == "Darwin" ]]; then
            brew install cmake
        else
            sudo apt install -y cmake
        fi
    fi
    echo "Building tmux-mem-cpu-load..."
    cd "$MEMCPU"
    cmake .
    make
fi
