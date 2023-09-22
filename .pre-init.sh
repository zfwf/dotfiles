# source from $HOME/.zshenv for zsh and $HOME/.profile for bash

if [ ! -f $HOME/.os-init ]; then
  case `uname` in
    Darwin)
      if [ ! -f $HOME/.gitconfig ]; then
        # symlinks
        ln -sf $HOME/.gitconfig_mac $HOME/.gitconfig
        ln -sf $HOME/Brewfile_mac $HOME/Brewfile
      fi

      # brew
      if [[ $(command -v brew) == "" && ! -d /opt/homebrew ]] ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew bundle --no-lock
      fi

      # add brew path
      PATH="/usr/local/bin":$PATH
      ;;
    Linux)
      if [ ! -f $HOME/.gitconfig ]; then
        # create symlinks
        ln -sf $HOME/.gitconfig_linux $HOME/.gitconfig

        eval "OS_$(cat /etc/*-release | grep "^ID=")"
        case "$OS_ID" in
          "clear-linux-os")
            sudo swupd bundle-add devpkg-bzip2 devpkg-openssl devpkg-readline devpkg-sqlite-autoconf devpkg-libffi x11-tools package-utils
            ;;
          "manjaro")
            # xclip for clipboard support
            sudo pacman -S base-devel xclip
            ;;
          "ubuntu")
            ;& # fall through
          "debian")
            sudo apt install libssl-dev build-essential pkg-config unzip
            # git credential management
            sudo apt install pass gpg
            ;;
        esac

        # show desktop icons in gnome
        if [[ $(command -v gsettings) ]] ; then
          gsettings set org.gnome.desktop.background show-desktop-icons true
        fi
      fi
      ;;
  esac

  # os init complete
  touch $HOME/.os-init
fi

if [ "$(uname)" == *"Linux"* ] || [ "$(uname)" == *"Darwin"* ]; then
  # asdf
  if [ ! -d $HOME/.asdf ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    . ~/.asdf/asdf.sh;
    asdf plugin-add nodejs;
    asdf plugin-add python;
    asdf plugin-add rust;
    cd $HOME; asdf install; asdf reshim;
  else
    . ~/.asdf/asdf.sh;
    # integrate with java
    [ -f "$HOME/.asdf/plugins/java/set-java-home.zsh" ] && . ~/.asdf/plugins/java/set-java-home.zsh
  fi
fi

if [[ $(command -v sccache) != "" ]] ; then
  # enable sccache
  export RUSTC_WRAPPER="$(command -v sccache)"
fi


