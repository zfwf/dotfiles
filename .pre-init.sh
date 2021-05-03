# source from $HOME/.zshenv for zsh and $HOME/.profile for bash

case `uname` in
  Darwin)
    # brew path
    PATH="/usr/local/bin":$PATH
    if [ ! -f $HOME/.gitconfig ]; then

      # create symlinks
      ln -sf $HOME/.gitconfig_mac $HOME/.gitconfig
      ln -sf $HOME/.alacritty_mac.yml $HOME/.alacritty.yml
      ln -sf $HOME/Brewfile_mac $HOME/Brewfile

    fi

    ;;
  Linux)
    # brew path
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    if [ ! -f $HOME/.gitconfig ]; then
      # create symlinks
      ln -sf $HOME/.gitconfig_linux $HOME/.gitconfig

      eval "OS_$(cat /etc/*-release | grep "^ID=")"
      case "$OS_ID" in
        "clear-linux-os")
          ln -sf $HOME/.alacritty_clr.yml $HOME/.alacritty.yml
          ;;
        "manjaro")
          ln -sf $HOME/Brewfile_manjaro $HOME/Brewfile
          ;;
      esac

      # show desktop icons in gnome
      gsettings set org.gnome.desktop.background show-desktop-icons true
    fi
    ;;
esac

# install brew if not found
if [[ $(command -v brew) == "" ]] ; then
  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  brew bundle --no-lock
fi


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
