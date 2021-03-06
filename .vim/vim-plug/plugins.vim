call plug#begin('~/.vim/plugged')           " Plugins are downloaded into this directory

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Installing my own fork until my PR gets approved
" Plug 'airblade/vim-rooter'
Plug 'barankarakus/vim-rooter'

Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
" Indentation support & syntax highlighting for various filetypes
Plug 'sheerun/vim-polyglot'
" Colorscheme
Plug 'tomasr/molokai'
" Ones for the future
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-surround'
" Easily (un)comment lines across various filetypes
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim'
Plug 'voldikss/vim-floaterm'
" Shows a live preview of a markdown document in the browser as it's being
" edited from vim
" Needs node and yarn to be installed; only load if both of these can be found
if system('command -v node') != '' && system('command -v yarn') != ''
    " Installing my own fork until my PR gets approved
    " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'barankarakus/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    let g:mkdp_loaded = 1
else
    let g:mkdp_loaded = 0
endif

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

" ----- markdown-preview -----
if g:mkdp_loaded
    " Don't automatically open the preview window when a markdown file is
    " entered
    let g:mkdp_auto_start = 0
    " Don't autoclose the preview window when switching away from a markdown
    " buffer
    let g:mkdp_auto_close = 0
    " Continuously refresh the preview window as we edit; set to 1 to only
    " refresh upon writing the buffer
    let g:mkdp_refresh_slow = 0
    " Only make the mkdp commands (like :MarkdownPreview) available for
    " markdown files
    let g:mkdp_command_for_global = 0
endif
