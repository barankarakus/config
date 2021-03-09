let g:fzf_preview_window = ['up:50%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" Make `:Rg` better! Adapted from fzf.vim's README.
function! RipgrepFzf(query, fullscreen, directory)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  if !empty(a:directory)
     let spec['dir'] = a:directory
  endif
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0, '')

" Use vim-rooter's `FindRootDirectory()` to create versions of `:Files` and
" `:Rg` that are launched from the project root
command! -nargs=* -bang ProjectRg call RipgrepFzf(<q-args>, <bang>0, FindRootDirectory())
command! -nargs=0 -bang ProjectFiles
    \ call fzf#vim#files(
    \   FindRootDirectory(),
    \   fzf#vim#with_preview(),
    \   <bang>0
    \ )

" My stuff.
function! s:ProjectFiles(...)
    let l:command = 'ag ' . join(a:000, ' ') . ' -g '
    let l:rootDir = FindRootDirectory()
    let l:spec = {
        \ 'source': l:command . "''",
        \ 'options': [
        \   '--prompt', l:rootDir . '/',
        \   '--preview', '$ZDOTDIR/fzf/preview.sh {}',
        \   '--preview-window', 'up:50%:hidden',
        \   '--bind', 'ctrl-/:toggle-preview'
        \ ],
        \ 'dir': l:rootDir
        \ }
    call fzf#run(fzf#wrap(l:spec))
endfunction

function! s:Files(...)
    let l:command = 'ag ' . join(a:000, ' ') . ' -g '
    let l:dir = getcwd()
    let l:spec = {
        \ 'source': l:command . "''",
        \ 'options': [
        \   '--prompt', l:dir . '/',
        \   '--preview', '$ZDOTDIR/fzf/preview.sh {}',
        \   '--preview-window', 'up:50%:hidden',
        \   '--bind', 'ctrl-/:toggle-preview'
        \ ],
        \ 'dir': l:dir
        \ }
    call fzf#run(fzf#wrap(l:spec))
endfunction

function! s:ProjectFiles(...)
    let l:command = 'ag ' . join(a:000, ' ') . ' -g '
    let l:dir = FindRootDirectory()
    let l:spec = {
        \ 'source': l:command . "''",
        \ 'options': [
        \   '--prompt', l:dir . '/',
        \   '--preview', '$ZDOTDIR/fzf/preview.sh {}',
        \   '--preview-window', 'up:50%:hidden',
        \   '--bind', 'ctrl-/:toggle-preview'
        \ ],
        \ 'dir': l:dir
        \ }
    call fzf#run(fzf#wrap(l:spec))
endfunction

function! s:Rg(...)
    let l:command = 'rg ' . join(a:000, ' ') . ' --line-number '
    let l:dir = getcwd()
    let l:spec = {
        \ 'source': l:command . "''",
        \ 'options': [
        \   '--prompt', 'Rg> ', '--bind', 'change:reload:' . l:command . ' {q} || true',
        \   '--phony',
        \   '--preview', '$ZDOTDIR/fzf/preview.sh {}',
        \   '--preview-window', 'up:50%:hidden',
        \   '--bind', 'ctrl-/:toggle-preview'
        \ ],
        \ 'dir': l:dir
        \ }
    call fzf#run(fzf#wrap(l:spec))
endfunction

function! s:ProjectRg(...)
    let l:command = 'rg ' . join(a:000, ' ') . ' --line-number '
    let l:dir = FindRootDirectory()
    let l:spec = {
        \ 'source': l:command . "''",
        \ 'options': [
        \   '--prompt', 'Rg> ', '--bind', 'change:reload:' . l:command . ' {q} || true',
        \   '--phony',
        \   '--preview', '$ZDOTDIR/fzf/preview.sh {}',
        \   '--preview-window', 'up:50%:hidden',
        \   '--bind', 'ctrl-/:toggle-preview'
        \ ],
        \ 'dir': l:dir
        \ }
    call fzf#run(fzf#wrap(l:spec))
endfunction

command! -nargs=* -bang Files if <bang>0 | call s:ProjectFiles(<f-args>) | else | call s:Files(<f-args>) | endif
command! -nargs=* -bang Rg if <bang>0 | call s:ProjectRg(<f-args>) | else | call s:Rg(<f-args>) | endif
