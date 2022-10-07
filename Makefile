# Main targets

personal-mac:
	echo "todo"

work-mac:
	echo "todo"

work-ubuntu: _common _sh-ubuntu



##### Supporting targets

# Stow

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

_common: _bin _apps _tmux _neovim _flake8 _git _zsh _sh-common

_%:
	stow ${STOW_ARGS} $*

# Install apps
OS=$(uname -s)
HOSTNAME=$(uname -n)
get_common_apps:
	ifeq (${OS}, Linux)
		echo "todo Linux"
	else
		ehco "todo mac"
	endif

get_neovim:
	_bootstrap/install-nvim.sh

get_fonts:
	_bootstrap/install-fonts.sh
