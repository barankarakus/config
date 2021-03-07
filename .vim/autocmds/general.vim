" Remove trailing spaces from all lines, but do so intelligently: don't move
" the cursor and don't replace the pattern in the search buffer
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

" Problem I'm trying to solve:
" I have a floaterm buffer (or buffers) (or just standard terminal-type
" buffers), but they're hidden. I want to quit vim. I have only one file open.
" I quit that file via :q or :q!, and I want that to be it: I should now have
" left vim.
" However, this doesn't happen. vim sees the terminal buffers as buffers which
" have changed - like how it would see a file with unsaved changes.
" The cleanest solution would be to tell vim to *ignore* any 'unsaved changes'
" in terminal-type buffers. However, I haven't been able to figure this out
" (I don't even know if it's possible).
"
" My solution: Listen to the QuitPre event (which is launched right before :q
" or :q! is used). If the buffer being quit is the last one that's open
" (meaning: it's the only remaining window in the only remaining tab), then,
" *before* trying to implement the quit action, first get rid of any terminal
" buffers.
function! s:QuitFloatermsIfLastWindow()
    if tabpagenr('$') == 1 && winnr('$') == 1 && !&modified
        let l:bufnames = []
        " We *cannot* just iterate over the buffer NUMBERS and provide these
        " buffer numbers to `bwipeout!`, because deleting a buffer changes the
        " numbers of other buffers, so, we'll first collect the names of
        " floaterm buffers.
        for l:bufnr in range(1, bufnr('$'))
            if getbufvar(l:bufnr, '&filetype') == 'floaterm' || getbufvar(l:bufnr, '&buftype') == 'terminal'
                let l:bufname = bufname(l:bufnr)
                call add(l:bufnames, l:bufname)
            endif
        endfor
        for l:bufname in l:bufnames
            execute 'bwipeout! '.l:bufname
        endfor
    endif
endfunction

augroup general
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd QuitPre * :call s:QuitFloatermsIfLastWindow()
augroup END
