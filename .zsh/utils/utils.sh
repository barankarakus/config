# Some utility functions for use when configuring zsh
# The unset_utils file unsets the items defined here

U_source_if_exists () {
    [ -f $1 ] && source $1
}

U_add_to_PATH_if_exists () {
    [ -d $1 ] && export PATH="$1:$PATH"
}

# Using the built-in `command` command (instead of, say, `which`) for two
# reasons:
# 1. It's built-in so FAST.
# 2. Its behaviour is defined by the POSIX standard so it's portable; see here
#    for the specification:
#    https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
U_command_exists () {
    command -v $1 &> /dev/null
}
