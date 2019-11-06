# source from $HOME/.zshenv for zsh and $HOME/.profile for bash

# spack
spack_dir=$HOME/spack
if [ ! -d $spack_dir ]; then
  git clone https://github.com/spack/spack.git $spack_dir
  . $spack_dir/share/spack/setup-env.sh
  spack compiler find
  spack bootstrap
  . $spack_dir/share/spack/setup-env.sh
  if [ -f $HOME/spack.yaml ]; then
    cd $HOME
    spack install
  else
    spack env create -d $HOME
  fi
fi

# load spack
. $spack_dir/share/spack/setup-env.sh
if [ ! -f $HOME/loads ]; then
  spack env activate -d $HOME
  . $spack_dir/share/spack/setup-env.sh
  spack env loads -r
fi

spack env activate -d $HOME
# load spack env
. $spack_dir/share/spack/setup-env.sh
. $HOME/loads
