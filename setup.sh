#!/usr/bin/env bash

home=~  # could use HOME environment variable, but ~ is more reliable
for dotfile in $(/usr/bin/env ls -a | /usr/bin/env grep "^\.[^.]"); do
    if [[ $dotfile =~ "git" ]]; then
        continue
    fi
    [ ! -e $home/$dotfile ] &&
    /usr/bin/env ln -s $PWD/$dotfile $home/$dotfile &&
    printf "Created symlink $home/$dotfile -> $PWD/$dotfile\n"
done
unset home
