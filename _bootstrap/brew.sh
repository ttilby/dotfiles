#!/usr/bin/env bash
set -euo pipefail

# Install tools / apps via Homebrew

brew update
brew upgrade

# Shell and core tools
brew install bash
brew install git
brew install stow
brew install zsh-syntax-highlighting
brew install tmux
