#!/bin/sh

# start zsh (wait for initialization to complete...)
zsh

# set zsh as login shell (optional)
command -v zsh | sudo tee -a /usr/share/defaults/etc/shells; sudo chsh -s $(command -v zsh) $USER
