#!/usr/bin/env zsh

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

if [ -x $(command -v "lsd") ]; then
    alias ls="lsd --config-file $XDG_CONFIG_HOME/lsd/config.yml"
    alias ll='ls --blocks=permission,size,date,name'
    alias tree='ls --tree'
else
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls -gho'
fi
alias lall='ll -A'

alias grep='grep --color=auto'

alias sudo='nocorrect sudo'

alias vi='vim'
[ -x "$(command -v nvim)" ] && alias vim='nvim'

alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
