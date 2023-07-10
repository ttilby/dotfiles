#!/bin/bash

# Usage from project root:
# NEOVIM_VERSION=v0.9.1 _bootstrap/install-nvim.sh

set +x

_NEOVIM_VERSION="${NEOVIM_VERSION:-v0.8.0}" # v0.8.0 or nightly
_NEOVIM_INSTALL_LOCATION="${NEOVIM_INSTALL_LOCATION:-$HOME/apps/nvims}"
_NEOVIM_LOCATION="${NEOVIM_LOCATION:-$HOME/bin}"
_NAME="nvim-${_NEOVIM_VERSION}"

if [ ! -d "${_NEOVIM_INSTALL_LOCATION}" ];
then
    echo "Creating folder: ${_NEOVIM_INSTALL_LOCATION}"
    mkdir -p "${_NEOVIM_INSTALL_LOCATION}"
fi

echo "version: ${_NEOVIM_VERSION}"

# check if desired version is already on this machine
_NEOVIM_PATH="${_NEOVIM_INSTALL_LOCATION}/${_NAME}"
echo "looking for ${_NEOVIM_PATH}"
if [ -d "${_NEOVIM_PATH}" ];
then
    echo "Found version: ${_NEOVIM_PATH}"
else
    pushd ${_NEOVIM_INSTALL_LOCATION} || exit
    wget https://github.com/neovim/neovim/releases/download/$_NEOVIM_VERSION/nvim-linux64.tar.gz
    tar xzf nvim-linux64.tar.gz
    mv nvim-linux64/ "${_NAME}/"
    rm nvim-linux64.tar.gz
    popd || exit
    echo "Downloaded new version: ${_NEOVIM_PATH}"
fi

# Change installed version
if [ -f "${_NEOVIM_LOCATION}/nvim" ];
then
    echo "Removing old neovim link"
    rm "${_NEOVIM_LOCATION}/nvim"
fi

echo "Linking ${_NEOVIM_VERSION} to ${_NEOVIM_LOCATION}/nvim"
ln -s "${_NEOVIM_PATH}/bin/nvim" "${_NEOVIM_LOCATION}/nvim"

echo "Done"
