# compile zsh to zwc
alias source='builtin source "$HOME/compile-source-file" source "$#" "$@"'
alias      .='builtin .      "$HOME/compile-source-file" .      "$#" "$@"'

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
  MSYS* | MINGW*)
    # x-cmd
	[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

    ;;
esac
