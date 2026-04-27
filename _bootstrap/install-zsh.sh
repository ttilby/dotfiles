#!/bin/bash
set -euo pipefail

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install zsh via package manager if missing
if ! command -v zsh &>/dev/null; then
    echo "Installing zsh..."
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install zsh
    else
        sudo apt install -y zsh
    fi
fi
echo "zsh: $(zsh --version)"

# Install or update oh-my-zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Updating oh-my-zsh..."
    git -C "$HOME/.oh-my-zsh" pull --rebase --quiet
else
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install or update powerlevel10k
if [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Updating powerlevel10k..."
    git -C "$ZSH_CUSTOM/themes/powerlevel10k" pull --rebase --quiet
else
    echo "Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Install or update zsh-syntax-highlighting
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Updating zsh-syntax-highlighting..."
    git -C "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" pull --rebase --quiet
else
    echo "Installing zsh-syntax-highlighting..."
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "zsh setup complete"
