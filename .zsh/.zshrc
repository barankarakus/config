# Load utility functions/items for use when configuring zsh; these start with U_
# ---------------------------------------------------------------------------
source $ZDOTDIR/utils

# Using uname to distinguish between MacOS and Linux systems and load appropriate
# OS-specific configuration files
# ---------------------------------------------------------------------------
failure_msg="Could not detect operating system: Can't configure zsh properly\n"
if ! command uname &> /dev/null ; then
    # Can't find `uname` utility
    printf $failure_msg
else
    system=$(uname)
    if [ $system = "Darwin" ]; then
        U_source_if_exists $ZDOTDIR/maczshrc
    elif [ $system = "Linux" ]; then
        U_source_if_exists $ZDOTDIR/linuxzshrc
    else
        printf $failure_msg
    fi
    unset system
fi
unset failure_msg

# Modifying (GNU) ls
# ---------------------------------------------------------------------------
# Alias ls so that -F, -h, --color flags are always passed (see man ls for details)
# -F ensures directories are suffixed with /, executables with *, symlinks @
# -h ensures sizes of files are in human-readable form
# --color ensures output is colored. See man ls for details.
alias ls='ls -Fh --color'

# The output of ls depends on the LS_COLORS environment variable.
# The GNU utility `dircolor` is a convenience utility for setting this variable.
# I've got some file describing the color settings I want; passing it to dircolors
# so that dircolors interprets it and sets the LS_COLORS variable.
eval "$(dircolors $HOME/.dircolors/dircolors.ansi-dark)"

# This is here thanks to the powerlevel10k plug-in
# ---------------------------------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zplug stuff (plug-in manager for zsh)
# ---------------------------------------------------------------------------
# Make sure that zplug is installed at this location
ZPLUG_HOME="$HOME/.zplug"

# Run zplug initialisation script; brings 'zplug' function into namespace
# which does all of the plug-in management
source "$ZPLUG_HOME/init.zsh"

# List of plug-ins
# Note that this simply defines the list of plug-ins
# To actually install them, restart the shell session (or, source this
# file) and execute 'zplug install'
# Plug-ins are installed to the .zplug/repos directory

# Super cool command-prompt
# To reconfigure from scratch, run 'p10k configure' at the command line
# to launch the configuration wizard; the p10k function is brought into the
# namespace when the plugin is loaded (via zplug load, below)
# Configuration settings are stored in $ZDOTDIR/.p10k.zsh
# Strategy for configuring command-prompt:
# 1) Run configuration wizard to make it look like something you'd like
# (the individual icons etc will be customised at Step 2)
# 2) Edit the .p10k.zsh file to customise the individual items on the
# prompt, e.g. a section showing the currently active Conda environment
zplug "romkatv/powerlevel10k", as:theme, depth:1

# Syntax highlighting for the shell, e.g. 'ech' at the command
# prompt will be red (because it's an unrecognised command) whereas
# 'echo' will appear green
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Source plugins
zplug load
# ---------------------------------------------------------------------------

# Load the powerlevel10k configuration file specifying how the prompt
# should look: more details above.
# ---------------------------------------------------------------------------
U_source_if_exists $ZDOTDIR/.p10k.zsh

# Source zsh vim emulation configuration
# Also makes vim the MANPAGER
# ---------------------------------------------------------------------------
U_source_if_exists $ZDOTDIR/zshvim

# Load fzf (command-line fuzzy-finder)
# ---------------------------------------------------------------------------
U_source_if_exists ~/.fzf.zsh

# Environment configuration
# ---------------------------------------------------------------------------
export EDITOR="vim"

# Some aliases
# ---------------------------------------------------------------------------
alias ezrc="$EDITOR $ZDOTDIR/.zshrc"  # edit zshrc
alias elzrc="$EDITOR $ZDOTDIR/localzshrc"  # edit local zshrc
alias szrc="source $ZDOTDIR/.zshrc"  # source zshrc

# Source local zshrc file
# ---------------------------------------------------------------------------
U_source_if_exists $ZDOTDIR/localzshrc

# Unset util items
# ---------------------------------------------------------------------------
source $ZDOTDIR/unset_utils
