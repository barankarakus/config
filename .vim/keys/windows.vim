" Better window navigation with tmux-navigator (can move not only across vim
" windows but also tmux panes)
nnoremap <silent> <C-H> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-J> :TmuxNavigateDown<CR>
nnoremap <silent> <C-K> :TmuxNavigateUp<CR>
nnoremap <silent> <C-L> :TmuxNavigateRight<CR>

" Better window resizing
" Mapping <Alt-=> to horizontal size increase
nnoremap<silent> ≠ :vertical resize +2<CR>
" Mapping <Alt--> to horizontal size decrease
" æ was originally <Alt-'>; map <Alt--> to this on iTerm end
nnoremap<silent> æ :vertical resize -2<CR>
" Mapping <Alt-Shift-=> to vertical size increase
" ± was originally <Alt-Shift-=>; map <Ctrl-Alt-=> to this on iTerm end
nnoremap<silent> ± :resize +2<CR>
" Mapping <Alt-Shift--> to vertical size decrease
" Æ was originally <Alt-Shift-'>; map <Ctrl-Alt--> to this on iTerm end
nnoremap<silent> Æ :resize -2<CR>
