" Better window navigation
" tmux-navigator plug-in defines <C-H>, <C-J> etc to move across tmux/vim
" panes/windows frictionlessly
" However, the plug-in doesn't create mappings for vim's terminal buffers, so I
" do that manually here
tnoremap <silent> <C-H> <C-W>:TmuxNavigateLeft<CR>
tnoremap <silent> <C-J> <C-W>:TmuxNavigateDown<CR>
tnoremap <silent> <C-K> <C-W>:TmuxNavigateUp<CR>
tnoremap <silent> <C-L> <C-W>:TmuxNavigateRight<CR>
tnoremap <silent> <C-\> <C-W>:TmuxNavigatePrevious<CR>

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

" Making window resizing work for integrated terminals
function! TerminalResize(hchange, wchange)
    if &filetype ==# 'floaterm'
        let b:floaterm_height += a:hchange
        if b:floaterm_height > 0.9
            let b:floaterm_height = 0.9
        elseif b:floaterm_height < 0.1
            let b:floaterm_height = 0.1
        endif
        let b:floaterm_width += a:wchange
        if b:floaterm_width > 0.9
            let b:floaterm_width = 0.9
        elseif b:floaterm_width < 0.1
            let b:floaterm_width = 0.1
        endif
        FloatermUpdate --width=b:floaterm_width --height=b:floaterm_height
    else
        if a:hchange > 0
            resize +2
        elseif a:hchange < 0
            resize -2
        elseif a:wchange > 0
            vertical resize +2
        elseif a:wchange < 0
            vertical resize -2
        endif
    endif
endfunction

tnoremap<silent> ≠  <C-W>:call TerminalResize(0.0, 0.05)<CR>
tnoremap<silent> æ  <C-W>:call TerminalResize(0.0, -0.05)<CR>
tnoremap<silent> ± <C-W>:call TerminalResize(0.05, 0.0)<CR>
tnoremap<silent> Æ  <C-W>:call TerminalResize(-0.05, 0.0)<CR>


