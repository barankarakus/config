#!/usr/bin/env bash

# Set CONFIGDIR to directory of this script

export CONFIGDIR=$(realpath $(dirname $0))
echo "Detected CONFIGDIR=$CONFIGDIR"
echo

# Create zshrc

if [[ -f ~/.zshrc ]]; then
    rm ~/.zshrc
    echo "Deleted existing ~/.zshrc"
fi

echo "export CONFIGDIR=$CONFIGDIR" >> ~/.zshrc
echo 'source $CONFIGDIR/zsh/zshrc' >> ~/.zshrc

echo "Created ~/.zshenv"
echo

# Create vanilla vimrc

if [[ -f ~/.vimrc ]]; then
    rm ~/.vimrc
    echo "Deleted existing ~/.vimrc"
fi

echo 'let &rtp = $CONFIGDIR . "/vim" . "," . &rtp . "," . $CONFIGDIR . "/vim/after"' >> ~/.vimrc
echo 'source $CONFIGDIR/vim/vimrc' >> ~/.vimrc

echo "Created ~/.vimrc"
echo

# Create neovim vimrc

if [[ -f ~/.config/nvim/init.vim ]]; then
    rm ~/.config/nvim/init.vim
    echo "Deleted existing ~/.config/nvim/init.vim"
fi

if [[ ! -d ~/.config/nvim ]]; then
    mkdir -p ~/.config/nvim
fi

echo 'let &rtp = $CONFIGDIR . "/vim" . "," . &rtp . "," . $CONFIGDIR . "/vim/after"' >> ~/.config/nvim/init.vim
echo 'source $CONFIGDIR/vim/vimrc' >> ~/.config/nvim/init.vim

echo "Created ~/.config/nvim/init.vim"
echo

# Symlink .tmux.conf

if [[ -e ~/.tmux.conf ]] || [[ -L ~/.tmux.conf ]]; then
    rm ~/.tmux.conf
    echo "Deleted existing ~/.tmux.conf"
fi

/usr/bin/env ln -s $CONFIGDIR/tmux/tmux.conf ~/.tmux.conf

echo "Created symlink ~/.tmux.conf -> $CONFIGDIR/tmux/tmux.conf"
echo

# Download zplug if not already downloaded

ZPLUG_HOME=$CONFIGDIR/zsh/zplug
if [[ ! -f $ZPLUG_HOME/init.zsh ]]; then
    echo "Downloading zplug to $ZPLUG_HOME"
    git clone https://github.com/zplug/zplug $CONFIGDIR/zsh/zplug
    echo "Downloaded zplug"
else
    echo "Detected zplug installation at $ZPLUG_HOME"
fi
echo

# Install zsh plugins

echo "Installing zsh plugins"
source $CONFIGDIR/zsh/zshplugins.sh
zplug install
echo

# Download vim-plug if not already downloaded

VIMPLUG_FILE=$CONFIGDIR/vim/autoload/plug.vim
if [[ ! -f $VIMPLUG_FILE ]]; then
    echo "Downloading vimplug to $VIMPLUG_FILE"
    curl -fLo $VIMPLUG_FILE --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "Downloaded vimplug"
else
    echo "Detected vimplug installation at $VIMPLUG_FILE"
fi
echo

# Run :PlugInstall within vim

echo "Installing vim plugins"
/usr/bin/env vim +PlugInstall +qa!
echo

# Finally, load zshrc
source ~/.zshrc
