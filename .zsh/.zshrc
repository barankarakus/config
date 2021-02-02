# Modifying ls
# ------------
# Enabling colorized output and configuring the colors (see man ls for details)
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
# Alias ls so that -F and -h flags are always passed (see man ls for details)
# -F ensures directories are suffixed with /, executables with *, symlinks *
alias ls='ls -GFh'

# brew-installed ruby
# -------------------
# Have installed ruby via brew, which leads to the following message:

# # By default, binaries installed by gem will be placed into:
  # # /usr/local/lib/ruby/gems/3.0.0/bin
# # 
# # You may want to add this to your PATH.
# # 
# # ruby is keg-only, which means it was not symlinked into /usr/local,
# # because macOS already provides this software and installing another version in
# # parallel can cause all kinds of trouble.
# # 
# # If you need to have ruby first in your PATH run:
  # # echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
# # 
# # For compilers to find ruby you may need to set:
  # # export LDFLAGS="-L/usr/local/opt/ruby/lib"
  # # export CPPFLAGS="-I/usr/local/opt/ruby/include"

# I want to use brew-installed ruby and gem rather than the default
# Mac installation ruby and gem (the latter leads to obscure errors
# for me... I think it's just there for use by the system, just like
# the system Python interpreter)
# So we follow the instructions given by brew's output:
export PATH="/usr/local/opt/ruby/bin:$PATH"  # Placing brew's 'ruby' and 'gem' in PATH
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"  # This folder is where brew gem-installed binaries are placed

# This is here thanks to the powerlevel10k plug-in
# ------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ----------------------------------------------

# zplug stuff (plug-in manager for zsh)
# -------------------------------------
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

# Source plugins and add commands to $PATH
zplug load
# -------------------------------------

# -------------------------------------
# This is here thanks to the powerlevel10k plug-in: it loads the
# configuration file specifying how the prompt should look; more details above.
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"
# -------------------------------------

# ----------------------
# Anaconda installation put this in my .bash_profile, probably because at
# the time of installation Bash was my default shell.
# I've placed it here so Anaconda works correctly when using zsh.
__conda_setup="$('/Users/barankarakus/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
            if [ -f "/Users/barankarakus/opt/anaconda3/etc/profile.d/conda.sh" ]; then
                        . "/Users/barankarakus/opt/anaconda3/etc/profile.d/conda.sh"
                            else
                                        export PATH="/Users/barankarakus/opt/anaconda3/bin:$PATH"
                                            fi
fi
unset __conda_setup
# ----------------------

# Setting up zsh Vim emulation.
# -----------------------------

# Telling zsh to use vi mode (technically, telling the ZLE to use the
# 'viins' keymap by default; see below...)
bindkey -v

# Defining a new 'no-op' function/widget, doing nothing
# I don't use this but keeping it here for illustrative purposes
zsh-widget-noop () {}
zle -N zsh-widget-noop

# Using 'jk' typed in quick succession to Esc to Normal mode from Insert
bindkey -M viins 'jk' vi-cmd-mode

# Mapping H, L to what they're mapped to in my .vimrc,
# i.e H takes us to first non-blank character in line (alias for ^),
# L to end of line (alias for $)
bindkey -M vicmd 'H' vi-first-non-blank
bindkey -M vicmd 'L' vi-end-of-line

# Mapping <Ctrl-P> and <Ctrl-N> to what one expects: going up and down history.
# By default, this works in Normal mode but not in Insert mode.
bindkey '^P' up-history
bindkey '^N' down-history

# Mapping : so that while in 'Command mode', it does nothing, because: 
# 1) No such thing as Ex mode here, and
# 2) : is opening up a prompt to type a ZLE command, and I don't see a
# use for any of these.
bindkey -M vicmd ':' vi-cmd-mode

# Mapping backspace so that while in 'Insert mode', it works like you'd bloody expect: Deletes the character before the cursor. By default, it doesn't let you delete before the point at which you entered Insert mode (????).
# This 'backward-delete-char' widget also allows us to backspace through new lines.
# The zsh ZLE documentation says \b represents the backspace key, and ^?
# represents 'delete'; I've got both here because the first line didn't do the
# job (but it might on other systems?) and the second did.
bindkey -M viins '\b' backward-delete-char
bindkey -M viins '^?' backward-delete-char

# Documentation on zsh key mappings here:
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html.
# Equivalently, check the man page for zshzle.
# It's quite hard to read... 
# In a Nutshell, ZLE is the Zsh Line Editor: it's what we type stuff into.
# There are several 'keymaps', which are distinct collections of key bindings.
# Think of these keymaps as *modes* (like Vim modes!) which ZLE can be in; it
# switches between them by selecting which keymap is in use.
# There are keymaps corresponding to Vim modes: viins for Insert, vicmd for 
# Command (basically also Normal), visual for, well, visual, etc.
# The bindkey command manipulates keymaps and key bindings - it lets us define
# key bindings. The -M option specifies the keymap to modify. What follows
# is the keys to map - written as a string - and then the command (or 'widget',
# in the language of the documentation) to map to.
# Later on in the documenation, under 'Standard Widgets', many of the possible
# 'commands' - or 'widgets' - are listed, as well as which (sequence of) keys
# map to them and in which modes, by default. It is from this list that I've
# found the above commands, like 'vi-cmd-mode' (which takes us to command mode).

# Here's a Git repo of some-one else's dot files - they have lots of Vim
# key-bindings for zsh: https://github.com/mkomitee/dotfiles. Good to look at
# for inspiration and for an understanding of how to define key bindings for
# zsh.
# -----------------------------

# Setting up zsh to invoke Vim's built-in manpager for viewing man pages
# ----------------------------------------------------------------------
export MANPAGER="vim -M +MANPAGER -"
# Two benefits:
# 1) man pages are syntax highlighted - as if they needed to be more fun to
# read :)
# 2) man pages are opened up in Vim - so all my keybindings apply
# More details: see :help manpager and :help man within Vim
