#!/bin/sh

# clone to ~/.cfg as bare repo
git clone --bare https://github.com/zfwf/dotfiles $HOME/.cfg

# checkout `main` branch
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout main
