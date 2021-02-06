
source_if_exists () {
    [ -f $1 ] && source $1
}

add_to_PATH_if_exists () {
    [ -d $1 ] && export PATH="$1:$PATH"
}
