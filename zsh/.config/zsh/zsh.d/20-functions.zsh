#!/usr/bin/env zsh

dots() {
  cd $DOTFILES
}

# autols do an ls after each cd
autols() (
    ls
)
chpwd_functions=(${chpwd_functions[@]} "autols")
