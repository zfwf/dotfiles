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

# Android
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export JRE_HOME=/usr/lib/jvm/java-8-oracle/jre``
export ANDROID_HOME=$HOME/Android/Sdk
export NDK_ROOT=$ANDROID_HOME/ndk_bundle
export ANDROID_NDK_HOME=$NDK_ROOT
PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin

# add pip installed packages
PATH=$PATH:~/.local/bin

# add intellij to path
PATH=$PATH:/opt/idea-IC/latest/bin

# add cargo (rust) 
PATH=$HOME/.cargo/bin:$PATH

# use vim as editor in general
export VISUAL=vim
export EDITOR="$VISUAL"
