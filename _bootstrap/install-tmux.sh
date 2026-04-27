#!/bin/bash
set -euo pipefail

# Usage: TMUX_VERSION=3.6a _bootstrap/install-tmux.sh

TMUX_VERSION="${TMUX_VERSION:-3.6a}"
OS="$(uname -s)"

if tmux -V 2>/dev/null | grep -q "$TMUX_VERSION"; then
    echo "tmux $TMUX_VERSION already installed"
else
    if [[ "$OS" == "Darwin" ]]; then
        echo "Installing tmux via Homebrew..."
        brew install tmux
    else
        echo "Installing build dependencies..."
        sudo apt update
        sudo apt install -y build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison byacc

        echo "Building tmux $TMUX_VERSION from source..."
        tmp=$(mktemp -d)
        trap "rm -rf $tmp" EXIT
        git clone --branch "$TMUX_VERSION" --depth 1 https://github.com/tmux/tmux.git "$tmp"
        cd "$tmp"
        sh autogen.sh
        ./configure && make -j"$(nproc)"
        sudo make install
    fi
    echo "Installed: $(tmux -V)"
fi

# Install TPM if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
