" Tab management/navigation
" œ was originally <Alt-q>; map <Ctrl-Alt-h> to this on iTerm end
nnoremap<silent> œ :tabprev<CR>
tnoremap<silent> œ <C-W>N:tabprev<CR>
" Œ was originally <Alt-Shift-q>; map <Ctrl-Alt-l> to this on iTerm end
nnoremap<silent> Œ :tabnext<CR>
tnoremap<silent> Œ <C-W>N:tabnext<CR>
" vim's native tabmove function doesn't wrap around, so here's a workaround
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    let s:current_tab=tabpagenr()
    let s:total_tabs = tabpagenr("$")
    " Wrap to end
    if s:current_tab == 1 && a:direction == -1
        tabmove
    " Wrap to start
    elseif s:current_tab == s:total_tabs && a:direction == 1
        tabmove 0
    " Normal move
    else
        execute (a:direction > 0 ? "+" : "-") . "tabmove"
    endif
endfunction
" ® was originally <Alt-r>; map <Ctrl-Alt-Shift-h> to this on iTerm end
nnoremap<silent> ® :call TabMove(-1)<CR>
tnoremap<silent> ® <C-W>N:call TabMove(-1)<CR>i
" Â was originally <Alt-R>; map <Ctrl-Alt-Shift-l> to this on iTerm end
nnoremap<silent> Â :call TabMove(1)<CR>
tnoremap<silent> Â <C-W>N:call TabMove(1)<CR>i
" New tab creation and current tab closing
nnoremap<silent> <C-N> :tabnew<CR>
nnoremap<silent> <C-Q> :tabclose<CR>
