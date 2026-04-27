#!/bin/bash
set -euo pipefail

# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

tmp=$(mktemp -d)
trap "rm -rf $tmp" EXIT

if [[ "$(uname -s)" == "Darwin" ]]; then
    curl -fsSL -o "$tmp/AWSCLIV2.pkg" "https://awscli.amazonaws.com/AWSCLIV2.pkg"
    if command -v aws &>/dev/null; then
        echo "Updating AWS CLI..."
    else
        echo "Installing AWS CLI..."
    fi
    sudo installer -pkg "$tmp/AWSCLIV2.pkg" -target /
else
    curl -fsSL -o "$tmp/awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
    unzip -q "$tmp/awscliv2.zip" -d "$tmp"
    if command -v aws &>/dev/null; then
        echo "Updating AWS CLI..."
        sudo "$tmp/aws/install" --update
    else
        echo "Installing AWS CLI..."
        sudo "$tmp/aws/install"
    fi
fi

echo "AWS CLI ready: $(aws --version)"
