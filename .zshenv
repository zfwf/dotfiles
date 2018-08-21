# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# java
if [ -d "/usr/lib/jvm/default-java" ]; then
  export JAVA_HOME=/usr/lib/jvm/default-java
  export JRE_HOME=$JAVA_HOME/jre
elif [ -d "~/.brew/opt/adoptopenjdk-openjdk8" ]; then
  export JAVA_HOME=~/.brew/opt/adoptopenjdk-openjdk8  
  export JRE_HOME=$JAVA_HOME/jre
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

# yarn installed binaries
if [ -d "$HOME/.yarn/bin" ]; then
  PATH=$PATH:$HOME/.yarn/bin
fi

# # add cargo (rust) 
if [ -d "$HOME/.cargo/bin" ]; then
  PATH=$HOME/.cargo/bin:$PATH
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# use neovim as editor in general
export VISUAL=nvim
export EDITOR="$VISUAL"
alias vi=nvim

# brew
PATH="$HOME/.brew/bin:$PATH"
export MANPATH="$(brew --prefix)/share/man:$MANPATH"
export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"

# alias
alias trash=gvfs-trash
alias avd-16="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_16"
alias avd-21="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_21"
alias avd-23="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_23"

