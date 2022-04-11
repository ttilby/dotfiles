#!/bin/bash

echo "Installing NeoVim"
CURRENT_VERSION='v0.5.0' # or 'nightly'
curl -L https://github.com/neovim/neovim/releases/download/$CURRENT_VERSION/nvim.appimage -o $HOME/Downloads/nvim-$CURRENT_VERSION
chmod u+x ~/Downloads/nvim-$CURRENT_VERSION
mv $HOME/Downloads/nvim-$CURRENT_VERSION $HOME/bin/nvim
