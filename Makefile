# Usage:
#   make work-mac       # Full macOS setup (brew, apps, dotfiles)
#   make work-ubuntu    # Full Ubuntu setup (apps, dotfiles)
#   make common_apps    # Install all tools (cross-platform)
#   make common_dots    # Symlink dotfiles via stow
#   make nvim           # Install/upgrade neovim only
#
# Options:
#   STOW_SIMULATE=true  # Dry-run stow (no changes)
#   STOW_VERBOSE=true   # Verbose stow output
#   NVIM_VERSION=v0.12.0  FZF_VERSION=0.72.0  etc.

# Main targets

work-mac: mac_apps common_apps common_dots

work-ubuntu: linux_apps common_apps common_dots _sh-ubuntu



##### Supporting targets

##############################################
# dotfiles (using GNU Stow)
##############################################

# Desired target (if not supplied the target is the parent dir)
STOW_TARGET ?= ${HOME}
# Verbose output, useful with simlulate for troubleshooting
STOW_VERBOSE ?= false
# Useful for pruning obsolete links
STOW_RESTOW ?= true
# Do not perform operations, useful for troubleshooting
STOW_SIMULATE ?= false

_STOW_TARGET = --target=${STOW_TARGET}
_STOW_VERBOSE=
_STOW_RESTOW=
_STOW_SIMULATE=
ifeq ($(STOW_VERBOSE), true)
	_STOW_VERBOSE = --verbose
endif
ifeq ($(STOW_RESTOW), true)
	_STOW_RESTOW = --restow
endif
ifeq ($(STOW_SIMULATE), true)
	_STOW_SIMULATE = --simulate
endif

STOW_ARGS ?= ${_STOW_TARGET} ${_STOW_RESTOW} ${_STOW_VERBOSE} ${_STOW_SIMULATE}

common_dots: _alacritty _misc _tmux _neovim _flake8 _git _zsh _sh-common

_%:
	stow ${STOW_ARGS} $*

##############################################
# Install apps
##############################################
OS=$(uname -s)
HOSTNAME=$(uname -n)

common_apps:
	_bootstrap/install-zsh.sh
	_bootstrap/install-nvim.sh
	_bootstrap/install-fonts.sh
	_bootstrap/install-tmux.sh
	_bootstrap/install-fzf.sh
	_bootstrap/install-delta.sh
	_bootstrap/install-tig.sh
	_bootstrap/install-awscli.sh
	_bootstrap/install-asdf.sh

linux_apps:  # placeholder for Linux-only installs

mac_apps:
	_bootstrap/brew.sh
	_bootstrap/macos-defaults.sh

# Specific apps
nvim:
	_bootstrap/install-nvim.sh
