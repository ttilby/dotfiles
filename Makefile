# Main targets

personal-mac: common_dots mac_dots

work-mac: common_dots mac_dots
	echo "todo"

work-ubuntu: linux_apps common_dots _sh-ubuntu



##### Supporting targets

##############################################
# dotfiles (using GNU Stow)
##############################################

STOW_TARGET ?= ${HOME}
STOW_VERBOSE ?= false
STOW_RESTOW ?= true
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

common_dots: _misc _tmux _neovim _flake8 _git _zsh _sh-common
mac_dots: _alacritty

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

linux_apps: common_apps
	_bootstrap/install-tmux.sh

mac_apps: common_apps
	_bootstrap/macos-defaults.sh
	_bootstrap/install-fonts.sh
	_bootstrap/brew.sh

# Specific apps
diff_so_fancy:
	_bootstrap/install-diff-so-fancy.sh
