# Some utility functions for use when configuring zsh
# The unset_utils file unsets the items defined here

U_source_if_exists () {
    [ -f $1 ] && source $1
}

U_add_to_PATH_if_exists () {
    [ -d $1 ] && export PATH="$1:$PATH"
}

U_command_exists () {
    command -v $1 &> /dev/null
}
