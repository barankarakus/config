# DO NOT MODIFY THIS FILE
# -----------------------
# zsh uses the ZDOTDIR environment variable in a variety of ways:
# 1. Where to place .zsh_history
# 2. Where to look for start-up files like .zshrc
# If ZDOTDIR is not set (default), HOME is used in place of ZDOTDIR.
# To minimize clutter in HOME folder, I've created a $HOME/.zsh directory to
# store zsh-related stuff.
# This file (.zshenv) is the second file to be read when zsh starts up and it
# is ALWAYS read (irrespective of how zsh was started up, i.e. whether as a
# login/non-login or interactive/non-interactive shell) (after /etc/zshenv,
# which, if it exists, is a system file and shouldn't be modified). zsh looks
# for it in $HOME/ (because at the point of looking for it $ZDOTDIR isn't set),
# so KEEP THIS FILE in the home directory. 
# The below line simply modifies ZDOTDIR to point to $HOME/.zsh.
export ZDOTDIR="$HOME/.zsh"
