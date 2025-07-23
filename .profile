# $HOME/.profile: executed by Bourne-compatible login shells.
# pre-init script
[ -f  $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# non-interactive init
case `uname` in
  Darwin)
    # mise
    [[ -x "$(command -v mise)" ]] && eval "$(mise activate bash --shims)" > /dev/null 2>&1

    ;;
  Linux)
    # brew
    [[ -d "/home/linuxbrew/.linuxbrew/bin" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" > /dev/null 2>&1

    # mise
    [[ -x "$(command -v mise)" ]] && eval "$(mise activate bash --shims)" > /dev/null 2>&1

    ;;
  MINGW64_NT-*)
    # mise
    [[ -x "$(command -v mise)" ]] && eval "$(mise activate bash --shims)" > /dev/null 2>&1

    ;;
esac

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
