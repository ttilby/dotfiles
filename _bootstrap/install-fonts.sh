#!/bin/bash

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf\?raw\=true
curl -fLo "MesloLGS NF Bold.ttf"  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf\?raw\=true
curl -fLo "MesloLGS NF Italic.ttf"  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf\?raw\=true
curl -fLo "MesloLGS NF Bold Italic.ttf"  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf\?raw\=true

OS=$(uname -s)

if [[ $OS == "Darwin" ]]; then
    cp ~/.local/share/fonts/* ~/Library/Fonts
elif [[ $OS == "Linux" ]]; then
    fc-cache -f -v
fi
