# brew-installed command-line tools
# ---------------------------------

# MacOS is derived from Unix, specifically the BSD variant of Unix. In particularly,
# it is not built on Linux. While Linux systems generally ship with the GNU command-line
# tools, MacOS ships with the FreeBSD flavour of tools. Both sets of tools are compliant
# with the POSIX standards (which aim to provide some standardisation among Unix-like
# systems), but they have slight differences which, for me, are quite annoying to have
# to deal with. I'd rather use one or the other *all the time*. Since I sometimes work on 
# Linux machines sometimes, and since there's probably more users of the GNU tools than
# the FreeBSD tools, I've opted to replicate the Linux environment on MacOS.

# To do this, I install GNU tools using brew. As usual, brew symlinks everything
# to /usr/local/bin.
# If an installed tool also exists on MacOS by default (e.g. `ls`), brew pre-pends 'g'
# to the tool's name when symlinking to /usr/local/bin, e.g. 'ls' is 'gls'. When it does
# this, the brew installation output gives us a directory to append to our PATH to be able
# to use the tools with their proper names. That's what the 'export PATH=' lines below are
# doing.

# brew install coreutils tells me to do:
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"  # gets us ls, wc, uniq, mkdir etc

# brew install grep tells me to do;
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"  # gets us grep, egrep, fgrep

# brew install findutils tells me to do:
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"  # gets us find, xargs

# Note: We also, obviously, want `man ls` etc to show us the man page for the
# GNU tools, *not* whatever variation of it MacOS provides. I didn't have to do
# anything extra to enable this behaviour (and brew did not tell me to upon installation).
# Protip: You can tell it's a man page for a GNU tool if credit is given to the
# GNU project; try searching for 'GNU' in the file. 
# Many MacOS tools' man pages mention BSD instead - you know it's not a GNU man page if 
# 'BSD General Commands Manual' is at the top of the man page.

# brew-installed ruby
# -------------------
# If needing ruby/gem, make sure to brew install like so:
# `brew install ruby`
# This'll install ruby in /usr/local/Cellar/ruby and will print a message like this:

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

# Make sure to use brew-installed ruby and gem rather than the default
# Mac installation ruby and gem (the latter leads to obscure errors
# for me... I think it's just there for use by the system, just like
# the system Python interpreter).
# So we follow the instructions given by brew's output:
# export PATH="/usr/local/opt/ruby/bin:$PATH"  # Placing brew's 'ruby' and 'gem' in PATH
# export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"  # This folder is where brew gem-installed binaries are placed

# Modifying ls
# ------------
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

# Mapping <Ctrl-K> and <Ctrl-J> to do nothing in Normal mode,
# because I find myself accidentally pressing them (I'm confusing
# them for <Cmd-K>, <Cmd-J>, which I've set up to move up and down
# within iTerm panes)

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
# Two benefits:
# 1) man pages are syntax highlighted - as if they needed to be more fun to
# read :)
# 2) man pages are opened up in Vim - so all my keybindings apply

# Originally, I had the following line, obtained from :help man and :help manpager within Vim:
# export MANPAGER="vim -M +MANPAGER -"
# This works fine but has one problem: Once you open a man page and then quit, you see
# "Reading from stdin..." printed at the command-line - very annoying.
# Here's a fix obtained from https://vi.stackexchange.com/questions/4682/how-can-i-suppress-the-reading-from-stdin-message-from-within-vim:
 export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'

# Added by fzf installation: https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
# Make sure to have installed fzf at ~/.fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
