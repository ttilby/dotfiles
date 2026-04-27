#!/bin/bash
set -euo pipefail

# https://asdf-vm.com/guide/getting-started.html

ASDF_VERSION="${ASDF_VERSION:-0.16.7}"
ASDF_BIN="$HOME/bin/asdf"
ASDF_DIR="$HOME/.asdf"

OS="$(uname -s)"
ARCH="$(uname -m)"
if [[ "$OS" == "Darwin" ]]; then
    PLATFORM="darwin-arm64"
else
    PLATFORM="linux-amd64"
fi

current=$("$ASDF_BIN" --version 2>/dev/null | awk '{print $NF}' | tr -d 'v' || true)
if [[ "$current" == "$ASDF_VERSION" ]]; then
    echo "asdf is already v${ASDF_VERSION}"
else
    [[ -n "$current" ]] && echo "Upgrading asdf v${current} → v${ASDF_VERSION}..." || echo "Installing asdf v${ASDF_VERSION}..."
    tmp=$(mktemp -d)
    trap "rm -rf $tmp" EXIT
    curl -fsSL -o "$tmp/asdf.tar.gz" \
        "https://github.com/asdf-vm/asdf/releases/download/v${ASDF_VERSION}/asdf-v${ASDF_VERSION}-${PLATFORM}.tar.gz"
    tar xzf "$tmp/asdf.tar.gz" -C "$tmp"
    mkdir -p "$HOME/bin"
    mv "$tmp/asdf" "$ASDF_BIN"
    chmod +x "$ASDF_BIN"
    echo "asdf v${ASDF_VERSION} ready: $(asdf --version)"
fi

# Install plugins if missing
plugins="nodejs=https://github.com/asdf-vm/asdf-nodejs.git
terraform=https://github.com/asdf-community/asdf-hashicorp.git
terragrunt=https://github.com/ohmer/asdf-terragrunt
tflint=https://github.com/skyzyx/asdf-tflint"

echo "$plugins" | while IFS='=' read -r name url; do
    if ! asdf plugin list 2>/dev/null | grep -q "^${name}$"; then
        echo "Adding asdf plugin: ${name}..."
        asdf plugin add "$name" "$url"
    fi
done

echo "asdf plugins: $(asdf plugin list | tr '\n' ' ')"
echo "Run 'asdf install' to install versions from ~/.tool-versions"
