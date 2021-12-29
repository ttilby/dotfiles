#   Change Prompt
#   ------------------------------------------------------------

# prompt 1
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# prompt 2
# export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
# export PS2="| => "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

. "$HOME/.cargo/env"
