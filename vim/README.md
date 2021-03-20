My Vim set-up - everything in one repo.

Some notes:
* Vim searches for the (user-specific) vimrc file within ~/.vimrc and then in ~/.vim/vimrc, in that order. It then sets the $MYVIMRC internal environment variable to the path that is found. I want to keep vim-related things all in one place, so I've got vimrc in ~/.vim. See `:h vimrc` for more details.
* The coc-settings.json file serves as a global configuration file for the coc vim plug-in, because coc looks in ~/.vim/coc-settings.json for this.
