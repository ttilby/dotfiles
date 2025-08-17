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
    git checkout 3.5a
    sh autogen.sh
    ./configure && make
    sudo make install
    popd

    # https://github.com/tmux-plugins/tpm/blob/master/docs/managing_plugins_via_cmd_line.md
    echo "Installing Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi
