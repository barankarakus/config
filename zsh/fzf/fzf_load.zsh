# Upon installation, fzf creates ~/.fzf.zsh. This is just that file with the
# paths adapted.

# Setup fzf
# ---------
export PATH="$CONFIGDIR/fzf/bin:$PATH"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$CONFIGDIR/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$CONFIGDIR/fzf/shell/key-bindings.zsh"
