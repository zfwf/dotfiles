case `uname` in
  Darwin)
    # java
    export JAVA_HOME=$(/usr/libexec/java_home)
    # android
    sdk_root=$HOME/Library/Android/sdk
    ;;
  Linux)
    # android
    sdk_root=$HOME/Android/Sdk
    ;;
esac

if [ -d "$sdk_root" ]; then
  export ANDROID_SDK_ROOT=$sdk_root
  export ANDROID_HOME=$sdk_root # deprecated but required for older tools
  ndk_root="$ANDROID_SDK_ROOT/ndk_bundle"
  if [ -d "$ndk_root" ]; then
    export ANDROID_NDK_HOME=$ndk_root
  fi
  export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
  export PATH=$PATH:$ANDROID_SDK_ROOT/tools
  export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
  export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
fi
