export FZF_DEFAULT_OPTS="--height 70% --reverse --border --ansi"
export FZF_DEFAULT_COMMAND="ag -g ''"

if U_command_exists bat; then
    Rg () {
        rg $@ '' | fzf --prompt='Rg> ' --bind "change:reload:rg $@ {q} || true" --phony \
                    --preview='invoke_bat.sh {}' \
                    --preview-window='up:50%' --delimiter=':' --bind 'ctrl-/:toggle-preview'
    }
else
    Rg () {
        rg $@ '' | fzf --prompt='Rg> ' --bind "change:reload:rg $@ {q} || true" --phony
    }
fi

if U_command_exists bat; then
    FILES_PREVIEW_COMMAND="bat --style=numbers --color=always"
else
    FILES_PREVIEW_COMMAND="cat"
fi

Files () {
    ag $@ -g '' | fzf --prompt=$PWD/ --preview=$FILES_PREVIEW_COMMAND' {}' --preview-window='up:50%:hidden' \
                      --bind 'ctrl-/:toggle-preview'
}
