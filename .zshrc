export TERM="xterm-256color"

# used to specify the system to control which lines are executed on which
# system
system_type=$(uname -s)
host=$(uname -n)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH=/Users/t.tilby/.oh-my-zsh
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
# HIST_STAMPS="mm/dd/yyyy"

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
if [[ "$host" == "toddt-SH370"* ]]; then
#    source $HOME/.exports_cp
    source $HOME/CProjects/environ/default.env
    source $HOME/.confluent.env
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
if [[ "$host" != "SilverBullet"* ]]; then
    alias tldr="~/bin/tldr $1"
fi
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/node@6/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="/home/todd/.npm-global/bin:$PATH"
# this was added for global npm packages
export PATH="/usr/local/bin/lib/node_modules:$PATH"

if type "$nvm" > /dev/null; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

### Kubernetes context prompt ###
if type "$kubectl" > /dev/null; then
    get_kube_context() {
        kubectl config current-context
    }
    get_kube_namespace(){
        NS=$(kubectl config view --minify --output 'jsonpath={..namespace}')
        if [ -z $NS ]; then echo "default"; else echo $NS; fi
    }
    
    # add \[\033[36m\][\$(get_kube_context)|\$(get_kube_namespace)] to your PS1 prompt
    PS1="\[\033[36m\][\$(get_kube_context)|\$(get_kube_namespace)] $PS1"
 
    # add kubectl autocomplete
    if hash kubectl 2>/dev/null; then
        source <(kubectl completion zsh)
    fi    

    # get a new dashboard key
    alias dashboard-rekey="aws eks get-token --cluster-name $(kubectl config current-context) | jq -r .status.token | pbcopy"

    ### kubernetes pods lister ###
    pods() {
        current_context=`kubectl config current-context`
        if [ ! -z "$current_context" ]; then
            current_namespace=`kubectl config view -o=jsonpath="{.contexts[?(@.name==\"$current_context\")].context.namespace}"`
        else
            current_namespace=default
        fi
        echo "($current_context, $current_namespace) pods:"
        kubectl get pods | grep -v Completed | rev | cut -d '-' -f2- | rev | uniq | tail -n +2
    }
fi

if type "$docker" > /dev/null; then
    ### docker-machine completions ###
    fpath=(~/.zsh/completion $fpath)
    autoload -Uz compinit && compinit -i


    function dip() {
        docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'
    }
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
