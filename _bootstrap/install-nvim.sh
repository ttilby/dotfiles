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
    CURRENT_VERSION='v0.7.0' # or 'nightly'
    curl -L https://github.com/neovim/neovim/releases/download/$CURRENT_VERSION/nvim.appimage -o $HOME/Downloads/nvim-$CURRENT_VERSION
    chmod u+x ~/Downloads/nvim-$CURRENT_VERSION
    mv $HOME/Downloads/nvim-$CURRENT_VERSION $HOME/bin/nvim
    # Should vim-plug be manually installed here?
fi

