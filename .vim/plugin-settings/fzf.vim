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
