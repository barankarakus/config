FZF_DEFAULT_OPTS="--bind ctrl-h:beginning-of-line --bind ctrl-l:end-of-line"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind ctrl-c:cancel"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 70% --reverse --border --ansi"
export FZF_DEFAULT_OPTS

export FZF_DEFAULT_COMMAND="rg --files"

Rg () {
    # Need this TEMP variable because of shell quoting bullshit
    FZF_RG_TEMP=$@
    rg  --no-config --smart-case --column --color=always $FZF_RG_TEMP \
        --no-heading --line-number '' \
    |&  fzf --prompt='Rg> ' \
            --bind "change:reload:rg $FZF_RG_TEMP --line-number {q} || true" \
            --phony \
            --preview="$CONFIGDIR/zsh/fzf/preview.sh {}" \
            --preview-window='up:50%:hidden' \
            --bind 'ctrl-/:toggle-preview' \
            --delimiter : \
            --bind 'ctrl-v:execute($EDITOR {1})' \
            --ansi
    # Do NOT 'unset FZF_RG_TEMP' here - it leads to not being able to quit out
    # of fzf properly
}

Files () {
    rg  $@  --files \
    |&  fzf --prompt=$PWD/ \
            --preview="$CONFIGDIR/zsh/fzf/preview.sh {}" \
            --preview-window='up:50%:hidden' \
            --bind 'ctrl-/:toggle-preview' \
            --bind 'ctrl-v:execute($EDITOR {})'
}
