#!/bin/bash

# Installs the LazyGit application
# https://github.com/jesseduffield/lazygit

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
rm -f ${HOME}/apps/lazygit/lazygit.tar.gz
rm -f ${HOME}/bin/lazygit
mkdir -p ${HOME}/apps/lazygit
pushd ${HOME}/apps/lazygit
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit ${HOME}/bin
popd
