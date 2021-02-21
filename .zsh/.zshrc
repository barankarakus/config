# Load utility functions/items for use when configuring zsh; these start with U_
# ---------------------------------------------------------------------------
source $ZDOTDIR/utils.sh

# Using `uname` to distinguish between MacOS and Linux systems and load appropriate
# OS-specific configuration files
# ---------------------------------------------------------------------------
failure_msg="Could not detect operating system: Can't configure zsh properly\n"
if ! U_command_exists uname; then
    # Can't find `uname` utility
    printf $failure_msg
else
    system=$(uname -s)
    if [ $system = "Darwin" ]; then
        U_source_if_exists $ZDOTDIR/maczshrc.sh
    elif [ $system = "Linux" ]; then
        U_source_if_exists $ZDOTDIR/linuxzshrc.sh
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

# Source zsh keybindings configuration file
# ---------------------------------------------------------------------------
source $ZDOTDIR/keybindings.sh

# Load fzf (command-line fuzzy-finder)
# ---------------------------------------------------------------------------
U_source_if_exists ~/.fzf.zsh
U_source_if_exists $ZDOTDIR/fzf_config.sh

# Setting up zsh to invoke Vim's built-in manpager for viewing man pages
# Two benefits:
# ---------------------------------------------------------------------------
# 1) man pages are syntax highlighted - as if they needed to be more fun to
# read :)
# 2) man pages are opened up in Vim - so all my keybindings apply

# Originally, I had the following line, obtained from :help man and :help manpager within Vim:
# export MANPAGER="vim -M +MANPAGER -"
# This works fine but has one problem: Once you open a man page and then quit, you see
# "Reading from stdin..." printed at the command-line - very annoying.
# Here's a fix obtained from
# https://vi.stackexchange.com/questions/4682/how-can-i-suppress-the-reading-from-stdin-message-from-within-vim:
# export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'
# I used this for a while, but then it messed up when I installed the vim-polyglot plug-in.
# Lesson: Don't use code snippets when you don't have a clue how they work :)
# Here's an alternative:
export MANPAGER="vim -M +MANPAGER --not-a-term -"
# This doesn't show the "Reading from stdin..." but there's still a new line that's printed;
# not worth fretting over.

# Recent directory management/navigation
# ---------------------------------------------------------------------------
# cd to a directory just by typing its name; no 'cd' needed
# if what you type is a command name, it'll be treated as a command instead
setopt autocd
# zsh has a 'directory stack'; by default, 'cd' does not add to this stack
# this option makes cd push to the directory stack
setopt autopushd
# don't push multiple copies of the same directory onto the stack
setopt pushdignoredups
# keep the directory stack from getting too large
DIRSTACKSIZE=10
## this caches the directory stack so it persists over multiple sessions
## the chpwd function is a post-cd HOOK: it's called immediately after every
## time we cd; it's how we keep this directory stack cache file updated
#DIRSTACKFILE=$ZDOTDIR/.zdirs
#if [[ -f $DIRSTACKFILE ]] # && [[ $#dirstack -eq 0 ]]; 
#then
  #echo $dirstack
  #dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  #echo $dirstack
  #echo $dirstack[1]
  #[[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
  #echo $dirstack
#fi
#chpwd() {
  #print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
  #dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#}
# view directory history (stack) quickly
# can then use cd -<number> to move to the desired directory
# alternatively, write cd -, then press <Tab> to do this quicker
alias dh="dirs -v"  # directory history

# Some environment configuration
# ---------------------------------------------------------------------------
export EDITOR="vim"

# Some aliases
# ---------------------------------------------------------------------------
alias evrc="$EDITOR ~/.vim/vimrc"  # edit vimrc

alias ezrc="$EDITOR $ZDOTDIR/.zshrc"  # edit zshrc
alias elzrc="$EDITOR $ZDOTDIR/localzshrc"  # edit local zshrc
alias szrc="source $ZDOTDIR/.zshrc"  # source zshrc

alias g="git"
alias gs="git status"
alias gss="git status -s"
alias gcmt="git commit"

alias la="ls -a"  # list all

# Source local zshrc file
# ---------------------------------------------------------------------------
U_source_if_exists $ZDOTDIR/localzshrc.sh

# Unset util items
# ---------------------------------------------------------------------------
source $ZDOTDIR/unset_utils.sh
