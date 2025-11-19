# $HOME/.profile: executed by Bourne-compatible login shells.
# pre-init script
[ -f  $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

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

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
