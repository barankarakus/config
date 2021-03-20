* This directory contains stuff related to my .zsh configuration.

* Of course, the main file of concern is .zshrc.
* The .zshrc file contains global settings - 'global' meaning across all of the different machines I use zsh on - and loads any local/system-specific settings.

* The maczshrc, linuxzshrc files contain system-specific global settings, i.e. settings I want across all MacOS systems or across all Linux systems that I'm working on.
* .zshrc tries to detect which system (Mac or Linux) it's on and sources maczshrc or linuxzshrc as appropriate.

* The keybindings file configures my zsh keybindings. In particular, it sets up zsh's vim emulation mode.
* .zshrc sources this file.

* The localzshrc file is for storing configuration options specific (local) to a particular machine.
* .zshrc loads localzshrc ((almost) before doing anything else) if it exists.
* localzshrc is .gitignore'd.
* This is where I store, for example, work-specific stuff on my work machine.

* utils defines some items that are repeatedly used during zsh configuration.
* Each of these items begins with "U_" so it's clear they belong to utils.
* The first thing .zshrc does is source utils.
* The last thing .zshrc does is source unset_utils, which unsets the items defined by utils.

* Notes on set-up:
    * Once this .zsh directory and .zshenv are sym-linked to ~ (home) from scratch, it is necessary to start a zsh process and run `zplug install` within it. This loads the plug-ins defined by zplug.
    * For the powerline10k command prompt plug-in to 'look right', zsh needs to be running in a terminular emulator with a nerd font installed. I use the MesloLGS NF within iTerm2.
    * Further, things might not look pretty if the terminal emulator is not true-color.
