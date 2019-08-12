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

# python
# pyenv

if [ ! $POETRY_ACTIVE ]; then
  if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    if [ -d "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
      eval "$(pyenv virtualenv-init -)"
    fi
  fi
fi

# poetry
[[ -d "$HOME/.poetry/bin" ]] && PATH="$HOME/.poetry/bin:${PATH}"


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
    ;;
  Linux) # commands for Linux go here
    # java
    if command -v java &> /dev/null; then
      export JAVA_HOME=${$(readlink -f `command -v java`)%/*/*}
      export JRE_HOME=$JAVA_HOME
    fi
    ;;
esac


# set PATH so it includes user's private bin if it exists
[[ ":$PATH:" != *":$HOME/bin:"* ]] && PATH="$HOME/bin:${PATH}"
[[ ":$PATH:" != *_":$HOME/.local/bin:"_* ]] && PATH="$HOME/.local/bin:${PATH}"
[[ ":$PATH:" != *_":$HOME/opt/bin:"_* ]] && PATH="$HOME/opt/bin:${PATH}"

