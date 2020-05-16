# android
case `uname` in
  Darwin)
    sdk_root=$HOME/Library/Android/sdk
    ;;
  Linux)
    sdk_root=$HOME/Android/Sdk
    ;;
esac

if [ -d "$sdk_root" ]; then
  export ANDROID_SDK_ROOT=$sdk_root
  ndk_root="$ANDROID_SDK_ROOT/ndk_bundle"
  if [ -d "$ndk_root" ]; then
    export ANDROID_NDK_HOME=$ndk_root
  fi
  PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin
fi
