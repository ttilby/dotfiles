# dotfiles

## Install

    yadm submodule update --init --recursive

If there are errors with the submodules, these can usually be fixed by deleting
the submodules locally and re-running the command above. 

Submodules are in the following directories

1. ~/apps/
2. ~/.tmux/plugins/

## Fonts

Install the patched Hack font from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf\?raw\=true
curl -fLo "Hack Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf\?raw\=true
curl -fLo "Hack Bold Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete.ttf\?raw\=true
curl -fLo "Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf\?raw\=true
fc-cache -f -v
```

If on macos
```bash
cp ~/.local/share/fonts/* ~/Library/Fonts
```
