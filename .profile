# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export JRE_HOME=/usr/lib/jvm/java-8-openjdk/jre

# android
export ANDROID_HOME=$HOME/Android/Sdk
export NDK_ROOT=$ANDROID_HOME/ndk_bundle
export ANDROID_NDK_HOME=$NDK_ROOT
PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

# add pip installed packages
PATH=$PATH:~/.local/bin

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# yarn installed binaries
PATH=$PATH:$(yarn global bin)

# add cargo (rust) 
PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# use neovim as editor in general
export VISUAL=nvim
export EDITOR="$VISUAL"


# alias
alias trash=gvfs-trash
alias avd-16="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_16"
alias avd-21="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_21"
alias avd-25="cd ~/Android/Sdk/tools; emulator -avd Nexus_5X_API_25"
