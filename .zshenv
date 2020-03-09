# pre-init script
[ -f $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# zinit
local -A ZINIT_VAR
ZINIT_VAR[HOME_DIR]=$HOME/.zinit
ZINIT_VAR[BIN_DIR]="$ZINIT_VAR[HOME_DIR]/bin"
ZINIT_VAR[ZSCRIPT_DIR]="$HOME/.zsh"
ZINIT_VAR[PLUGIN_SCRIPT_DIR]=$ZINIT_VAR[ZSCRIPT_DIR]/zplugin
. $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/init.zsh

# Order of execution of related Ice-mods: atinit -> atpull! -> make'!!' -> mv -> cp -> make! -> atclone/atpull -> make -> (plugin script loading) -> src -> multisrc -> atload.

# shim tool https://github.com/zinit/z-a-bin-gem-node
zinit light zinit-zsh/z-a-bin-gem-node
# patch tool
zinit light zinit-zsh/z-a-patch-dl


# theme
[ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/theme.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/theme.zsh

#  completions
[ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/comp.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/comp.zsh

# lang/runtimes
[ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/lang_runtime.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/lang_runtime.zsh

# common command line programs
[ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog.zsh

# common gui programs
[ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog.zsh


case `uname` in
  Darwin)
    # font
    zinit ice from'gh-r' bpick'FiraCode.zip' \
      atclone'mkdir -p $HOME/Library/Fonts; ln -sf $PWD $HOME/Library/Fonts/FiraCode;' \
      atpull'%atclone'
    zinit light ryanoasis/nerd-fonts

    # command line programs
    [ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog_mac.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog_mac.zsh

    # gui programs
    [ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog_mac.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog_mac.zsh

    ;;
  Linux)
    # font
    zinit ice from'gh-r' bpick'FiraCode.zip' \
      atclone'mkdir -p $HOME/.local/share/fonts; ln -sf $PWD $HOME/.local/share/fonts/FiraCode;' \
      atpull'%atclone'
    zinit light ryanoasis/nerd-fonts

    # command line programs
    [ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog_manjaro.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog_manjaro.zsh

    # gui programs
    [ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog_manjaro.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog_manjaro.zsh
    ;;
esac

# needs to be the last plugin
zinit ice wait lucid
zinit light zdharma/fast-syntax-highlighting

autoload -Uz compinit
compinit

zinit cdreplay -q

# other paths
[ -f $ZINIT_VAR[ZSCRIPT_DIR]/paths.sh ] && . $ZINIT_VAR[ZSCRIPT_DIR]/paths.sh

