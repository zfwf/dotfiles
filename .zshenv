# compile zsh to zwc
alias source='builtin source "$HOME/compile-source-file" source "$#" "$@"'
alias      .='builtin .      "$HOME/compile-source-file" .      "$#" "$@"'

# pre-init script
[ -f $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# non-interactive init
case `uname` in
  Darwin)
    ;;
  Linux)
    # brew 
    [[ -d "$HOME/linuxbrew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" > /dev/null 2>&1
    ;;
esac

# mise
[[ -x "$(command -v mise)" ]] && eval "$(mise activate --shims)" > /dev/null 2>&1
