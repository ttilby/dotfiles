#!/bin/bash

# TODO If already installed, consider going to the git directory and updating

set +x
if type fzf 2>/dev/null;
then
    echo "fzf already installed"
else
    echo "Installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    sh $HOME/.fzf/install
fi
