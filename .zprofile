# command for login shell only (load order for dotfiles: .zshenv, .zprofile, .zlogin, .zlogout (on logout))
[[ -s /etc/profile ]] && source /etc/profile
[[ -s ~/.profile ]] && source ~/.profile
