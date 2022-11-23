# dotfiles

## Install

```bash
sudo apt get make zsh git stow
# <clone repo>
make common-apps
make work-ubuntu
```

## Fonts

NOTE: These need to be installed on the primary system only. For example, if
accessing Ubuntu from Macbook via ssh, the fonts only need to be
installed on the Macbook. If Ubuntu will be used directly, then they will
need to be installed there as well.
Install the patched Hack font from [Powerlevel10k](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

    ```bash
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf\?raw\=true
    curl -fLo "MesloLGS NF Bold.ttf"  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf\?raw\=true
    curl -fLo "MesloLGS NF Italic.ttf"  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf\?raw\=true
    curl -fLo "MesloLGS NF Bold Italic.ttf"  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf\?raw\=true
    fc-cache -f -v
    ```

If on macos

    ```bash
    cp ~/.local/share/fonts/* ~/Library/Fonts
    ```

## Third-party

### True color in Tmux / Vim / Alacritty

After installing these tools, the `$TERM` value should be as follows:

    ```bash
    # Alacritty on primary machine
    $ echo $TERM     # alacritty

    # ssh to dev machine
    $ echo $TERM     # alacritty

    # tmux session on dev machine
    $ echo $TERM     # tmux-256color
    ```

See [alacritty-tmux-vim_truecolor.md](https://gist.github.com/Pocco81/2ea37d5b1e31ce068d98774e907096d0)
for more info on how to properly set up the environments to achieve this.

### Misc

1. [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
1. [tfenv](https://github.com/tfutils/tfenv)
1. [tig](https://github.com/jonas/tig)
1. [fzf](https://github.com/junegunn/fzf)
1. [tig](https://github.com/jonas/tig)
1. [tldr](https://tldr.sh/)
1. [ripgrep](https://github.com/BurntSushi/ripgrep)

### Alacritty

Download latest [alaritty.info](https://github.com/alacritty/alacritty/blob/master/extra/alacritty.info)
file to `Documents/alacritty.info` if needed.

    ```bash
    sudo tic -xe alacritty,alacritty-direct Documents/alacritty.info
    ```

### ASDF

Used for managing multiple apps

    ```bash
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
    asdf install terraform 1.0.8
    asdf global terraform 1.0.8
    asdf plugin-add terragrunt https://github.com/ohmer/asdf-terragrunt
    asdf plugin-add tflint https://github.com/skyzyx/asdf-tflint
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf current
    ```
### Cmake

    ```bash
    # prereqs
    sudo apt install libssl-dev

    # download
    curl https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4.tar.gz -L -o cmake-3.21.4.tar.gz
    tar -xvzf cmake-3.21.4.tar.gz

    # install
    ./bootstrap
    make
    make install
    ```

### zsh

Install [Zsh](https://gist.github.com/derhuerst/12a1558a4b408b3b2b6e#file-linux-md)
Set zsh as default shell, then log out and back in

    ```bash
    chsh -s /bin/zsh <user>

    # current shell
    echo $0

    # current user
    whoami
    ```

Install [oh-my-zsh](https://ohmyz.sh/#install)
Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)

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

Use the `~/bin/install-tmux.sh` script from this repo

#### tmux-mem-cpu-load

Requires cmake to be installed.

    ```bash
    cd ~/.tmux/plugins/tmux-mem-cpu-load
    cmake .
    make
    make install
    ```

### Neovim

#### LSP info [WIP]

##### bashls

This was failing because `node` was installed via `asdf` and so couldn't be
found:

    ```
    "bash-language-server"	"stderr"	"/usr/bin/env: ‘node’: No such file or directory\n"
    ```

To fix, I symlinked the `asdf` `node` to `/usr/bin`.

    ```bash
    which node
    sudo ln -s /home/todd/.asdf/shims/node /usr/bin/node
    ```

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

### Python

#### pyenv

See [Documentation](https://github.com/pyenv/pyenv)

    ```bash
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    # builds dynamic bash plugin, ok if this fails
    cd ~/.pyenv && src/configure && make -C src

    pyenv install 3.7.8
    pyenv global 3.7.8
    ```
May need to run [get-pip.py](https://bootstrap.pypa.io/get-pip.py)
