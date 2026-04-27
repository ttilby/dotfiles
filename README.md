# dotfiles

Cross-platform dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

### macOS

```bash
# Install Homebrew (https://brew.sh), then:
brew install make git stow
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
make work-mac
```

### Ubuntu

```bash
sudo apt update && sudo apt install -y make git stow build-essential unzip
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
make work-ubuntu
```

## What's Included

### Dotfiles (stowed to ~)

| Package | Contents |
|---------|----------|
| alacritty | Terminal config (macOS side) |
| git | `.gitconfig`, global ignore, delta themes |
| tmux | `.tmux.conf`, status bar scripts, TPM plugins |
| neovim | nvim config |
| zsh | `.zshrc`, oh-my-zsh customizations, p10k config |
| sh-common | Shared aliases, exports, functions |
| sh-ubuntu | Ubuntu-specific shell config |
| flake8 | Python linter config (max-line-length=88) |
| misc | Misc scripts in ~/bin |

### Bootstrap Scripts (`_bootstrap/`)

All scripts are cross-platform (macOS + Linux) and support upgrades.

| Script | macOS | Linux |
|--------|-------|-------|
| install-zsh.sh | brew | apt |
| install-nvim.sh | arm64 tarball | x86_64 tarball |
| install-tmux.sh | brew | build from source |
| install-fzf.sh | git clone | git clone |
| install-delta.sh | brew | .deb package |
| install-tig.sh | brew | build from source |
| install-awscli.sh | .pkg installer | zip installer |
| install-asdf.sh | arm64 binary | amd64 binary |
| install-fonts.sh | ~/Library/Fonts | fc-cache |
| brew.sh | Homebrew packages (macOS only) |
| macos-defaults.sh | macOS system prefs (macOS only) |

Version overrides via env vars: `NVIM_VERSION=v0.12.0`, `TMUX_VERSION=3.6a`, `FZF_VERSION=0.72.0`, etc.

## Make Targets

```bash
make work-mac       # Full macOS setup (brew, apps, dotfiles)
make work-ubuntu    # Full Ubuntu setup (apps, dotfiles)
make common_apps    # Install all tools (cross-platform)
make common_dots    # Symlink dotfiles via stow
make nvim           # Install/upgrade neovim only
```

Options: `STOW_SIMULATE=true` (dry-run), `STOW_VERBOSE=true`

## Post-Install

### Neovim

Neovim v0.12+ with native `vim.pack` plugin manager (no lazy.nvim/packer). First launch will clone all plugins automatically.

**Python virtualenv** (required for pynvim provider — created automatically by `install-nvim.sh`):

```bash
# Manual setup if needed:
python3 -m venv ~/.virtualenvs/nvimvenv
~/.virtualenvs/nvimvenv/bin/pip install pynvim
```

**LSP servers** are managed by Mason. On first launch:

```vim
:Mason
```

Mason auto-installs: bashls, dockerls, pylsp, jsonls, marksman, lua_ls, terraformls, yamlls, helm_ls.

**Plugin management:**

```vim
:lua vim.pack.update()           " Update all plugins
:lua vim.pack.update("trouble")  " Update a single plugin
```

### Zsh

Zsh with oh-my-zsh, Powerlevel10k prompt, and zsh-syntax-highlighting.

**Components** (installed by `install-zsh.sh`):
- oh-my-zsh — framework
- powerlevel10k — prompt theme
- zsh-syntax-highlighting — command highlighting

**Plugins** (in `.zshrc`): `git`, `sudo`, `asdf`, `zsh-syntax-highlighting`

**Post-install:**
- Run `p10k configure` to set up the prompt on a new machine
- The `.p10k.zsh` config is stowed from the repo, so reconfiguring will overwrite it

**Host-specific config:** `.zshrc` sources files from two drop-in directories:

- `~/.zshrc.d/*.zsh` — shell config (functions, aliases, sourcing other files). Sourced in alphabetical order.
- `~/.env-cp.d/*.env` — plain `KEY=VALUE` env files (no shell logic).

Example `~/.zshrc.d/cradlepoint.zsh`:
```bash
[ -f "$HOME/.cp_functions" ] && source "$HOME/.cp_functions"
[ -f "$HOME/.cp_aliases" ] && source "$HOME/.cp_aliases"
```

These directories are not managed by this repo — populate them per-machine or via a separate dotfiles repo (e.g., `~/.dotfiles-cp`).

### tmux-mem-cpu-load

Requires cmake. After TPM installs the plugin:

```bash
cd ~/.tmux/plugins/tmux-mem-cpu-load
cmake .
make
sudo make install
```

### Alacritty terminfo

Only needed if `alacritty` terminfo is missing on the remote host:

```bash
sudo tic -xe alacritty,alacritty-direct Documents/alacritty.info
```

### True Color (Alacritty → SSH → tmux)

Expected `$TERM` values:

```
Local (Alacritty):  alacritty
SSH session:        alacritty
tmux session:       tmux-256color
```

See [truecolor setup guide](https://gist.github.com/Pocco81/2ea37d5b1e31ce068d98774e907096d0).

## Fonts

MesloLGS NF (for Powerlevel10k) — install on the machine running the terminal emulator, not the remote host. Handled by `install-fonts.sh`.

## Windows Host

Use Windows Terminal (Alacritty doesn't send mouse events properly over SSH).
