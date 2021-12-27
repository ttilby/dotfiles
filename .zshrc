# debugging shell startup
# Uncomment this line to load the the profiler, then run `zprof` to see how zsh is spending time during startup.
# zmodload zsh/zprof

# used to specify the system to control which lines are executed on which
# system
system_type=$(uname -s)
host=$(uname -n)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerlevel9k/powerlevel9k"

# link the spaceship theme into .oh-my-zsh/custom/themes folder
# ln -s ~/.themes/zsh-spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
ZSH_THEME="spaceship"
source ~/.themes/spaceship-prompt


# Powerlevel9k is the best theme for prompt, I like to keep it in dark gray colors
# DEFAULT_USER=todd
# # POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# # POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context)
# # POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
# POWERLEVEL9K_DIR_BACKGROUND='238'
# POWERLEVEL9K_DIR_FOREGROUND='252'
# POWERLEVEL9K_STATUS_BACKGROUND='238'
# POWERLEVEL9K_STATUS_FOREGROUND='252'
# POWERLEVEL9K_CONTEXT_BACKGROUND='240'
# POWERLEVEL9K_CONTEXT_FOREGROUND='252'
# POWERLEVEL9K_TIME_BACKGROUND='238'
# POWERLEVEL9K_TIME_FOREGROUND='252'
# POWERLEVEL9K_HISTORY_BACKGROUND='240'
# pt
# POWERLEVEL9K_HISTORY_FOREGROUND='252'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew node npm sudo ng zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

source $HOME/.exports
if [[ "$host" == "toddt-SH370"* || "$host" == "Precision-3240" ]]; then
    # source $HOME/.exports_cp
    source $HOME/CProjects/environ/default.env
    # source $HOME/.confluent.env
    source $HOME/.cp_functions
fi

# These can be in source control
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Sets the path for tmux plugins (tpm)
export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins

#export JAVA_HOME=$(/usr/libexec/java_home)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=nvim
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/sbin:$PATH"
# export PATH="/usr/local/opt/node@6/bin:$PATH"
export PATH="$PATH:$HOME/bin"
# export PATH="/home/todd/.npm-global/bin:$PATH"
# this was added for global npm packages
# export PATH="/usr/local/bin/lib/node_modules:$PATH"
# also for global npm packages
# export PATH="/usr/local/bin/bin:$PATH"
export PATH="/home/todd/.local/bin:$PATH"

# this was added for pyenv, not needed on silverbullet
if [[ "$host" == "toddt-SH370"* || "$host" == "Precision-3240" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="/home/todd/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# used to define where global npm packages are installed
# Note that the n executable is at $HOME/bin/n
export N_PREFIX=$HOME/n
export PATH="$HOME/n/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
