#   PATH variables
#   -----------------------------------------------------------
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file


#   Change Prompt
#   ------------------------------------------------------------

# prompt 1 
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# prompt 2
# export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
# export PS2="| => "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

#   Aliases
#   -----------------------------------------------------------

alias ls='ls -GFh'
alias ll='ls -FGlAhp'
alias la='ls -aGFh'
alias bashreload='source ~/.bash_profile'

# show 10 most used commands
alias muhistory='history | awk '"'"'{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}'"'"' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10'


# Workspace Management

alias tsync-get='[ -f $HOME/.tsync ] && [ -d "$(cat $HOME/.tsync)" ] && cat $HOME/.tsync'
alias tsync-set='pwd | tee $HOME/.tsync'
alias tsync='[ -f $HOME/.tsync ] && [ -d "$(cat $HOME/.tsync)" ] && cd $(cat $HOME/.tsync)'
