# source from $HOME/.zshenv for zsh and $HOME/.profile for bash

# # spack
# spack_dir=$HOME/spack
# spack_config_dir=$HOME/.spack
# spack_env_dir=$HOME/spack_env
# spack_env_base_dir=$spack_env_dir/base

# function init-spack() {
#   rm -rf $spack_config_dir
#   . $spack_dir/share/spack/setup-env.sh
#   # make sure we have compilers
#   spack compiler find
#   if [ ! -f $spack_env_base_dir/spack.yaml ]; then
#     mkdir -p $spack_env_base_dir
#     spack env create -d $spack_env_base_dir
#   fi
#   rm -rf $spack_env_base_dir/.spack-env $spack_env_base_dir/spack.lock
#   spack env activate -d $spack_env_base_dir
#   spack bootstrap
#   spack install
# }

# if [ ! -d $spack_dir ]; then
#   git clone https://github.com/spack/spack.git $spack_dir
#   init-spack
# fi

# # load spack env
# . $spack_dir/share/spack/setup-env.sh
# spack env activate -d $spack_env_base_dir 2>/dev/null

  case `uname` in
    Darwin)
      # brew path
      PATH="/usr/local/bin":$PATH
      if [ ! -f $HOME/.gitconfig ]; then

        # create symlinks
        ln -sf $HOME/.gitconfig_mac $HOME/.gitconfig
        ln -sf $HOME/.alacritty_mac.yml $HOME/.alacritty.yml
        ln -sf $HOME/Brewfile_mac $HOME/Brewfile

        # install brew if not found
        if [[ $(command -v brew) == "" ]] ; then
          # Install Homebrew
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
          brew bundle --no-lock
        fi
      fi

      ;;
    Linux)
      if [ ! -f $HOME/.gitconfig ]; then
        eval "OS_$(cat /etc/*-release | grep "^ID=")"
        case "$OS_ID" in
          "clear-linux-os")
            ln -sf $HOME/.alacritty_clr.yml $HOME/.alacritty.yml
            ;;
          "manjaro")
            ;;
        esac

        # create symlinks
        ln -sf $HOME/.gitconfig_linux $HOME/.gitconfig
        ln -sf $HOME/Brewfile_linux $HOME/Brewfile

        # show desktop icons in gnome
        gsettings set org.gnome.desktop.background show-desktop-icons true
      fi
      ;;
  esac

if [ ! -d $HOME/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
  . ~/.asdf/asdf.sh;
  asdf plugin-add nodejs;
  asdf plugin-add python;
  asdf plugin-add rust;
  asdf plugin-add sbt;
  export NODEJS_CHECK_SIGNATURES=no;
  cd $HOME; asdf install; asdf reshim;
  asdf global nodejs $(asdf list nodejs);
  asdf global python $(asdf list python);
  asdf global rust $(asdf list rust);
  asdf global sbt $(asdf list sbt);
else
  . ~/.asdf/asdf.sh;
  # completions handled by zinit
  export NODEJS_CHECK_SIGNATURES=no;
fi





