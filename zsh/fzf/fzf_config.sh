export FZF_DEFAULT_OPTS="--height 70% --reverse --border --ansi"
export FZF_DEFAULT_COMMAND="ag -g ''"

Rg () {
    # Need this TEMP variable because of shell quoting bullshit
    TEMP=$@
    # Making sure to always pass in --line-number flag, irrespective of default
    # arguments set up in .ripgreprc, because this is needed for the preview
    # window
    rg  $@  --line-number '' \
    |&  fzf --prompt='Rg> ' \
            --bind "change:reload:rg $TEMP --line-number {q} || true" \
            --phony \
            --preview="$CONFIGDIR/zsh/fzf/preview.sh {}" \
            --preview-window='up:50%:hidden' --bind 'ctrl-/:toggle-preview'
    unset TEMP
}

Files () {
    ag  $@  -g '' \
    |&  fzf --prompt=$PWD/ \
            --preview="$CONFIGDIR/zsh/fzf/preview.sh {}" \
            --preview-window='up:50%:hidden' \
            --bind 'ctrl-/:toggle-preview'
}
