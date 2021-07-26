# source from $HOME/.zshenv for zsh and $HOME/.profile for bash

case `uname` in
  Darwin)
    # brew path
    PATH="/usr/local/bin":$PATH
    if [ ! -f $HOME/.gitconfig ]; then

      # create symlinks
      ln -sf $HOME/.gitconfig_mac $HOME/.gitconfig
      ln -sf $HOME/.config/alacritty/alacritty_mac.yml $HOME/.config/alacritty/alacritty.yml
      ln -sf $HOME/Brewfile_mac $HOME/Brewfile

    fi

    # install brew if not found
    if [[ $(command -v brew) == "" ]] ; then
      # Install Homebrew
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      brew bundle --no-lock
    fi

    ;;
  Linux)
    if [ ! -f $HOME/.gitconfig ]; then
      # create symlinks
      ln -sf $HOME/.gitconfig_linux $HOME/.gitconfig
      ln -sf $HOME/.config/alacritty/alacritty_linux.yml $HOME/.config/alacritty/alacritty.yml

      eval "OS_$(cat /etc/*-release | grep "^ID=")"
      case "$OS_ID" in
        "clear-linux-os")
          ;;
        "manjaro")
          ;;
      esac

      # show desktop icons in gnome
      if [[ $(command -v gsettings) ]] ; then
        gsettings set org.gnome.desktop.background show-desktop-icons true
      fi
    fi
    ;;
esac



# install asdf if not found
if [ ! -d $HOME/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
  . ~/.asdf/asdf.sh;
  asdf plugin-add nodejs;
  asdf plugin-add rust;
  asdf plugin-add sbt;
  export NODEJS_CHECK_SIGNATURES=no;
  cd $HOME; asdf install; asdf reshim;
  asdf global nodejs $(asdf list nodejs);
  asdf global rust $(asdf list rust);
  asdf global sbt $(asdf list sbt);
else
  . ~/.asdf/asdf.sh;
  # completions handled by zinit
  export NODEJS_CHECK_SIGNATURES=no;
fi

