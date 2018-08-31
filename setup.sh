#! /usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# symlink configs
cd $HOME

USER_CONFIG_FILES=('.zprofile' '.zshrc' '.tmux.conf.local')
NUM_ELEMENTS=${#USER_CONFIG_FILES[@]}

for ((i=0; i < $NUM_ELEMENTS; i++)); do
  if [ -e "${USER_CONFIG_FILES[${i}]}" ]; then
    # rename
    mv "${USER_CONFIG_FILES[${i}]}" "${USER_CONFIG_FILES[${i}]}.orig"
  fi

  # link
  ln -s "$SCRIPT_DIR/${USER_CONFIG_FILES[${i}]}"
done

if [ -e ".config/nvim/init.vim" ]; then
  # rename
  mv ".config/nvim/init.vim" ".config/nvim/init.vim.orig"
fi

# link
cd $HOME/.config/nvim
ln -s "$SCRIPT_DIR/init.vim"

