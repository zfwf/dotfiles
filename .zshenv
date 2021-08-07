# compile zsh to zwc
alias source='builtin source "$HOME/compile-source-file" source "$#" "$@"'
alias      .='builtin .      "$HOME/compile-source-file" .      "$#" "$@"'

# pre-init script
[ -f $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# orbiter
declare -A ORBITER_CONST
ORBITER_CONST[HOME_DIR]=$HOME/.orbiter
ORBITER_CONST[BIN_DIR]="$ORBITER_CONST[HOME_DIR]/bin"
ORBITER_CONST[DASHBOARD_DIR]="$ORBITER_CONST[HOME_DIR]/dashboard"
ORBITER_CONST[DASHBOARD_BIN_DIR]="$ORBITER_CONST[DASHBOARD_DIR]/bin"
