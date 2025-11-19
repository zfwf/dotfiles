# compile zsh to zwc
alias source='builtin source "$HOME/compile-source-file" source "$#" "$@"'
alias      .='builtin .      "$HOME/compile-source-file" .      "$#" "$@"'

# pre-init script
[ -f $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# non-interactive init
case `uname` in
  Darwin)
    # x-cmd
	[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

    ;;
  Linux)
    # x-cmd
	[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

    ;;
  MINGW64_NT-*)
    # x-cmd
	[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

    ;;
esac
