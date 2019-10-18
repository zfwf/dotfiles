# ~/.profile: executed by Bourne-compatible login shells.

[[ -f ~/.zplugin/plugins/asdf-vm---asdf/asdf.sh ]] && . ~/.zplugin/plugins/asdf-vm---asdf/asdf.sh

export JAVA_HOME=$(asdf where java);

if [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_HOME=$HOME/Android/Sdk
  if [ -d "$ANDROID_HOME/ndk_bundle" ]; then
    export NDK_ROOT=$ANDROID_HOME/ndk_bundle
    export ANDROID_NDK_HOME=$NDK_ROOT
  fi
  PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
fi

