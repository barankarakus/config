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

# Download zplug if not already downloaded

ZPLUG_HOME=$CONFIGDIR/zsh/zplug
if [[ ! -d $ZPLUG_HOME ]]; then
    echo "Downloading zplug to $ZPLUG_HOME"
    git clone https://github.com/zplug/zplug $CONFIGDIR/zsh/zplug
    echo "Downloaded zplug"
fi

# Install zsh plugins

echo "Installing zsh plugins"
source $CONFIGDIR/zsh/zshplugins.sh
zplug install

# Download vim-plug if not already downloaded

VIMPLUG_FILE=$CONFIGDIR/vim/autoload/plug.vim
if [[ ! -f $VIMPLUG_FILE ]]; then
    echo "Downloading vimplug to $VIMPLUG_FILE"
    curl -fLo $VIMPLUG_FILE --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "Downloaded vimplug"
fi

# Run :PlugInstall within vim

echo "Installing vim plugins"
/usr/bin/env vim +PlugInstall +qa!

# Finally, load zshrc
source ~/.zshrc
