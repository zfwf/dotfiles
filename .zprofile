# command for login shell only (load order for dotfiles: .zshenv, .zprofile, .zlogin, .zlogout (on logout))
source /etc/profile
# Ubuntu make installation of Ubuntu Make binary symlink
PATH=/home/cchou/.local/share/umake/bin:$PATH

