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

## Third-party

### zsh

#### Spaceship Prompt

Installed by cloning the repo and linking the theme. Follow the `Manual`
installation instructions at
[Spaceship Prompt](https://github.com/spaceship-prompt/spaceship-prompt)

To update:

    ```bash
    cd ~/.themes/zsh-spaceship-prompt
    git pull
    ```

To customize, edit the `~/.themes/spaceship-prompt` file.

### Tmux

#### Rust

Installed to support [tmux-thumbs]().

Instructions can be found on [rustup.rs](rustup.rs).

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### neovim

#### terraform-ls

To install, see instructions [here](https://github.com/hashicorp/terraform-ls).
This will install the `terraform-ls` on the local machine. Check the version by
running `terraform-ls -v`.

This is currently installed in the `~/bin` directory.

The configuration can be found in the coc-settings.json file (editable with
`:CocConfig` inside vim).

##### Update

[Releases](https://releases.hashicorp.com/terraform-ls/)

    ```bash
    terraform-ls -v
    cd ~/terraform-ls
    mv ~/bin/terraform-ls ./terraform-ls_<version>
    wget https://releases.hashicorp.com/terraform-ls/0.21.0/terraform-ls_0.21.0_linux_amd64.zip
    unzip terraform-ls_0.21.0_linux_amd64.zip
    mv terraform-ls ~/bin/terraform-ls
    ```

