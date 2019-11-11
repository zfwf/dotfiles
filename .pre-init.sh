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

if [ ! -f $HOME/.gitconfig ]; then
  # create symlink to a gitconfig
  case `uname` in
    Darwin)
      # brew path
      PATH="/usr/local/bin":$PATH
      # install brew if not found
      which -s brew
      if [[ $? != 0 ]] ; then
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew bundle
      fi
      ln -sf $HOME/.gitconfig_mac $HOME/.gitconfig
      ln -sf $HOME/.alacritty_mac.yml $HOME/.alacritty.yml
      ;;
    Linux)
      eval "OS_$(cat /etc/*-release | grep "^ID=")"
      if [ "$OS_ID" = "clear-linux-os" ]; then
        ln -sf $HOME/.gitconfig_clr $HOME/.gitconfig
        ln -sf $HOME/.alacritty_clr.yml $HOME/.alacritty.yml
      fi
      ;;
  esac

fi
