# compile zsh to zwc
alias source='builtin source "$HOME/compile-source-file" source "$#" "$@"'
alias      .='builtin .      "$HOME/compile-source-file" .      "$#" "$@"'

# pre-init script
[ -f $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# non-interactive init
case `uname` in
  Darwin)
    # mise
    [[ -x "$(command -v mise)" ]] && eval "$(mise activate zsh --shims)" > /dev/null 2>&1

    ;;
  Linux)
    # brew 
    [[ -d "$HOME/linuxbrew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" > /dev/null 2>&1

    # mise
    [[ -x "$(command -v mise)" ]] && eval "$(mise activate zsh --shims)" > /dev/null 2>&1

    ;;
  MINGW64_NT-*)
    # mise
    [[ -x "$(command -v mise)" ]] && eval "$(mise activate zsh --shims)" > /dev/null 2>&1

    ;;
esac
