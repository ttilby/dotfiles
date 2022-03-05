#!/bin/bash

set +x
#### Tmux
if type tmux 2>/dev/null;
then
    echo "$(tmux -V) already installed"
else
    echo "Installing Tmux"
    sudo apt update
    sudo apt install -y build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison byacc
    rm -rf /tmp/tmux
    git clone https://github.com/tmux/tmux.git /tmp/tmux
    pushd /tmp/tmux
    git checkout 3.2a
    sh autogen.sh
    ./configure && make
    sudo make install
    popd

    # https://github.com/tmux-plugins/tpm/blob/master/docs/managing_plugins_via_cmd_line.md
    echo "Installing Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

#### NeoVim
if type nvim 2>/dev/null;
then
    echo "nvim already installed"
else
    echo "Installing NeoVim"
    CURRENT_VERSION='v0.5.0' # or 'nightly'
    curl -L https://github.com/neovim/neovim/releases/download/$CURRENT_VERSION/nvim.appimage -o $HOME/Downloads/nvim-$CURRENT_VERSION
    chmod u+x ~/Downloads/nvim-$CURRENT_VERSION
    mv $HOME/Downloads/nvim-$CURRENT_VERSION $HOME/bin/nvim
    # Should vim-plug be manually installed here?
fi

if type fzf 2>/dev/null;
then
    echo "fzf already installed"
else
    echo "Installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    sh $HOME/.fzf/install
fi
