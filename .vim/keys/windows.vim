" Better window navigation
" tmux-navigator plug-in defines <C-H>, <C-J> etc to move across tmux/vim
" panes/windows frictionlessly
" However, the plug-in doesn't create mappings for vim's terminal buffers, so I
" do that manually here
tnoremap <silent> <C-H> <C-W>:TmuxNavigateLeft<CR>
tnoremap <silent> <C-J> <C-W>:TmuxNavigateDown<CR>
tnoremap <silent> <C-K> <C-W>:TmuxNavigateUp<CR>
tnoremap <silent> <C-L> <C-W>:TmuxNavigateRight<CR>

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
