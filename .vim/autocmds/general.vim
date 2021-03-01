" Remove trailing spaces from all lines, but do so intelligently: don't move
" the cursor and don't replace the pattern in the search buffer
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

augroup all_files
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
