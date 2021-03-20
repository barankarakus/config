#!/usr/bin/env bash

# Set CONFIGDIR

if [[ $# -eq 0 ]]; then
    CONFIGDIR=~/config
else
    CONFIGDIR=$1
fi

echo "CONFIGDIR=$CONFIGDIR"

# Create zshrc

if [[ -f ~/.zshrc ]]; then
    rm ~/.zshrc
    echo "Deleted existing ~/.zshrc"
fi

echo "export CONFIGDIR=$CONFIGDIR" >> ~/.zshrc
echo 'source $CONFIGDIR/zsh/zshrc' >> ~/.zshrc

echo "Created ~/.zshenv"

# Create vanilla vimrc

if [[ -f ~/.vimrc ]]; then
    rm ~/.vimrc
    echo "Deleted existing ~/.vimrc"
fi

echo 'let &rtp = $CONFIGDIR . "/vim" . "," . &rtp . "," . $CONFIGDIR . "/vim/after"' >> ~/.vimrc
echo 'source $CONFIGDIR/vim/vimrc' >> ~/.vimrc

echo "Created ~/.vimrc"

# Create neovim vimrc

if [[ -f ~/.config/nvim/init.vim ]]; then
    rm ~/.config/nvim/init.vim
    echo "Deleted existing ~/.config/nvim/init.vim"
fi

echo 'let &rtp = $CONFIGDIR . "/vim" . "," . &rtp . "," . $CONFIGDIR . "/vim/after"' >> ~/.config/nvim/init.vim
echo 'source $CONFIGDIR/vim/vimrc' >> ~/.config/nvim/init.vim

echo "Created ~/.config/nvim/init.vim"

# Symlink .tmux.conf

if [[ -e ~/.tmux.conf ]] || [[ -L ~/.tmux.conf ]]; then
    rm ~/.tmux.conf
    echo "Deleted existing ~/.tmux.conf"
fi

/usr/bin/env ln -s $CONFIGDIR/tmux/tmux.conf ~/.tmux.conf

echo "Created symlink ~/.tmux.conf -> $CONFIGDIR/tmux/tmux.conf"
