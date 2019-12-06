# pre-init script
[ -f  $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# zplugin
local -A ZPLGM
ZPLGM[HOME_DIR]=$HOME/.zplugin
ZPLGM[BIN_DIR]=$ZPLGM[HOME_DIR]/bin
ZPLGM[ZSCRIPT_DIR]=$HOME/.zsh
ZPLGM[PLUGIN_SCRIPT_DIR]=$ZPLGM[ZSCRIPT_DIR]/zplugin
. $ZPLGM[PLUGIN_SCRIPT_DIR]/init.zsh


# Order of execution of related Ice-mods: atinit -> atpull! -> make'!!' -> mv -> cp -> make! -> atclone/atpull -> make -> (plugin script loading) -> src -> multisrc -> atload.

# shim tool https://github.com/zplugin/z-a-bin-gem-node
zplugin light zplugin/z-a-bin-gem-node

# theme
[ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/theme.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/theme.zsh

# lang/runtimes
[ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/lang_runtime.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/lang_runtime.zsh

#  completions
[ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/comp.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/comp.zsh

# common command line programs
[ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/cmdline_prog.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/cmdline_prog.zsh

case `uname` in
  Darwin)
    # font
    zplugin ice from'gh-r' bpick'FiraCode.zip' \
      atclone'mkdir -p $HOME/Library/Fonts; ln -sf $PWD $HOME/Library/Fonts/FiraCode;' \
      atpull'%atclone'
    zplugin light ryanoasis/nerd-fonts

    # command line programs
    [ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/cmdline_prog_mac.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/cmdline_prog_mac.zsh

    # gui programs
    [ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/gui_prog_mac.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/gui_prog_mac.zsh

    ;;
  Linux)
    # font
    zplugin ice from'gh-r' bpick'FiraCode.zip' \
      atclone'mkdir -p $HOME/.local/share/fonts; ln -sf $PWD $HOME/.local/share/fonts/FiraCode;' \
      atpull'%atclone'
    zplugin light ryanoasis/nerd-fonts

    # command line programs
    [ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/cmdline_prog_manjaro.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/cmdline_prog_manjaro.zsh

    # gui programs
    [ -f  $ZPLGM[PLUGIN_SCRIPT_DIR]/gui_prog.zsh ] && . $ZPLGM[PLUGIN_SCRIPT_DIR]/gui_prog.zsh
    ;;
esac

# needs to be the last plugin
zplugin ice wait lucid
zplugin light zdharma/fast-syntax-highlighting

autoload -Uz compinit
compinit

zplugin cdreplay -q

# other paths
[ -f $ZPLGM[ZSCRIPT_DIR]/paths.sh ] && . $ZPLGM[ZSCRIPT_DIR]/paths.sh

