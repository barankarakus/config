let g:fzf_preview_window = ['up:50%:hidden', 'ctrl-/' ]
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" TODO: Reduce duplication
function! s:Files(...)
    let l:command = 'rg --no-config ' . join(a:000, ' ') . ' --files'
    let l:dir = getcwd()
    let l:spec = {
        \ 'source': l:command,
        \ 'options': ['--prompt', l:dir . '/'],
        \ 'dir': l:dir
        \ }
    call fzf#run(fzf#vim#with_preview(fzf#wrap(l:spec)))
endfunction

function! s:ProjectFiles(...)
    let l:command = 'rg --no-config ' . join(a:000, ' ') . ' --files'
    let l:dir = FindRootDirectory()
    let l:spec = {
        \ 'source': l:command,
        \ 'options': ['--prompt', l:dir . '/'],
        \ 'dir': l:dir
        \ }
    call fzf#run(fzf#vim#with_preview(fzf#wrap(l:spec)))
endfunction

function! s:Rg(...)
    let l:command = 'rg --no-config ' . join(a:000, ' ') . ' --no-heading --color=always --line-number '
    let l:dir = getcwd()
    let l:spec = {
        \ 'source': l:command . "''",
        \ 'options': [
        \   '--bind', 'change:reload:' . l:command . ' {q} || true', '--phony'
        \ ],
        \ 'dir': l:dir
        \ }
    call fzf#vim#grep(l:command . "''", 1, fzf#vim#with_preview(l:spec), 0)
endfunction

function! s:ProjectRg(...)
    let l:command = 'rg --no-config ' . join(a:000, ' ') . ' --no-heading --color=always --line-number '
    let l:dir = FindRootDirectory()
    let l:spec = {
        \ 'source': l:command . "''",
        \ 'options': [
        \   '--bind', 'change:reload:' . l:command . ' {q} || true', '--phony'
        \ ],
        \ 'dir': l:dir
        \ }
    call fzf#vim#grep(l:command . "''", 1, fzf#vim#with_preview(l:spec), 0)
endfunction


command! -nargs=* -bang Files if <bang>0 | call s:ProjectFiles(<f-args>) | else | call s:Files(<f-args>) | endif
command! -nargs=* -bang Rg if <bang>0 | call s:ProjectRg(<f-args>) | else | call s:Rg(<f-args>) | endif
