#!/bin/bash

# TODO - consider installing to $HOME/bin/nvim-$CURRENT_VERSION/nvim and use
# "stow" to symlink to $HOME/bin/nvim

set +x
#### NeoVim
if type nvim 2>/dev/null;
then
    echo "nvim already installed"
else
    echo "Installing NeoVim"
    CURRENT_VERSION='v0.8.0' # or 'nightly'

    # Use the tar.gz file and place in apps directory
    pushd ~/apps
    wget https://github.com/neovim/neovim/releases/download/$CURRENT_VERSION/nvim-linux64.tar.gz
    tar xzfv nvim-linux64.tar.gz
    ln -s ~/apps/nvim-linux64/bin/nvim ~/bin/nvim
    rm nvim-linux64.tar.gz
    popd
fi

