call plug#begin('~/.vim/plugged')           " Plugins are downloaded into this directory

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'tomasr/molokai'
" Ones for the future
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim'                    
Plug 'voldikss/vim-floaterm'

" This function (defined in plug.vim) modifies Vim's runtimepath (see :h
" runtimepath) to include the directories where the plug-ins, listed above, are
" installed; for example, if we have Plug 'A/B' above, then the path
" <plug-in-directory>/A/B is added, where <plug-in-directory> is the directory
" set within the plug#begin() function. However, it leaves the packpath variable
" (see :h packpath) alone.
call plug#end()

" ----- floaterm -----
let g:floaterm_wintype = 'split'
let g:floaterm_position = 'rightbelow'
let g:floaterm_height = 0.3
let g:floaterm_autoclose = 2
let g:floaterm_title = 'floaterm($1|$2)'

" ----- vim-rooter -----
set noautochdir     " This just messes stuff up; turn it off
let g:rooter_manual_only = 0
let g:rooter_patterns = ['.git', '.ccls']
let g:rooter_targets = '/,*'
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_change_directory_for_project_files = 'current'
let g:rooter_silent_chdir = 1

" Versions of fzf.vim's `Rg`, `Files` commands which launch from the project
" root of the current buffer, as defined by vim-rooter's `FindRootDirectory`
" function.
" The only difference from the default versions of the commands: here, I
" supply fzf#vim#with_preview a Dict providing the project directory.
" When vim-rooter can't find a project root, `FindRootDirectory` outputs the
" empty string. In this case, the below commands behaves identically to their
" default versions: they launch from vim's current directory.

" ----- fzf.vim -----
" Make `:Rg` better! Copied from fzf.vim's README.
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

" ----- coc ------
let g:coc_global_extensions = ['coc-pyright', 'coc-json']

" ----- lightline -----
let g:lightline = {
    \ 'colorscheme': 'molokai',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
    \ }
