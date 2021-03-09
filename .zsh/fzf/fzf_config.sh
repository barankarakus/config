export FZF_DEFAULT_OPTS="--height 70% --reverse --border --ansi"
export FZF_DEFAULT_COMMAND="ag -g ''"

Rg () {
    rg $@ --line-number '' | fzf --prompt='Rg> ' --bind "change:reload:rg $@ {q} || true" --phony \
                --preview="$ZDOTDIR/fzf/preview.sh {}" \
                --preview-window='up:50%:hidden' --bind 'ctrl-/:toggle-preview'
}

Files () {
    ag $@ -g '' | fzf --prompt=$PWD/ --preview="$ZDOTDIR/fzf/preview.sh {}" --preview-window='up:50%:hidden' \
                      --bind 'ctrl-/:toggle-preview'
}
