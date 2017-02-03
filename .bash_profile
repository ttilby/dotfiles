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
