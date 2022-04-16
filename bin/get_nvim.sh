#!/bin/bash

echo "Installing NeoVim"
CURRENT_VERSION='v0.7.0' # or 'nightly'
curl -L https://github.com/neovim/neovim/releases/download/$CURRENT_VERSION/nvim.appimage -o $HOME/Downloads/nvim-$CURRENT_VERSION
chmod u+x ~/Downloads/nvim-$CURRENT_VERSION
sudo mv $HOME/Downloads/nvim-$CURRENT_VERSION usr/local/bin/nvim
