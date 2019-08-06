


# fnm
if [ -d "$HOME/.fnm" ]; then
  export PATH="$HOME/.fnm":$PATH
  eval "`fnm env --multi`"
fi

# android
if [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_HOME=$HOME/Android/Sdk
  if [ -d "$ANDROID_HOME/ndk_bundle" ]; then
    export NDK_ROOT=$ANDROID_HOME/ndk_bundle
    export ANDROID_NDK_HOME=$NDK_ROOT
  fi
  PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
fi

# add cargo (rust)
if [ -d "$HOME/.cargo/bin" ]; then
  PATH=$HOME/.cargo/bin:$PATH
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  if [ -d "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi


case `uname` in
  Darwin) # commands for OS X go here
    if [ -d "/Library/java" ]; then
      export JAVA_HOME=/Library/java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home
      export JRE_HOME=$JAVA_HOME
    fi

    # brew
    if [ -d "$HOME/.brew" ]; then
      PATH="$HOME/.brew/bin:$PATH"
      export MANPATH="$(brew --prefix)/share/man:$MANPATH"
      export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
    fi

    # python pip user install
    if [ -d "$HOME/Library/Python/3.7" ]; then
      PATH="$PATH:$HOME/Library/Python/3.7/bin"
    fi

    ;;
  Linux) # commands for Linux go here
    # java
    if [ type java &> /dev/null ]; then
      export JAVA_HOME=${$(readlink -f `type -p java`)%/*/*}
      export JRE_HOME=$JAVA_HOME
    fi
    ;;
esac


# work with snapd
[[ ":$PATH:" != *":/snap/bin:"* ]] && PATH="/snap/bin:${PATH}"


# install from source
[[ ":$PATH:" != *":/usr/local/bin:"* ]] && PATH="/usr/local/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[[ ":$PATH:" != *":$HOME/bin:"* ]] && PATH="$HOME/bin:${PATH}"
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && PATH="$HOME/.local/bin:${PATH}"
[[ ":$PATH:" != *":$HOME/opt/bin:"* ]] && PATH="$HOME/opt/bin:${PATH}"


