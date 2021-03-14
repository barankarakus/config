" Plugins are downloaded into this directory
call plug#begin('~/.vim/plugged')

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

" Colorschemes
Plug 'tomasr/molokai'

" Ones for the future
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-surround'

" Easily (un)comment lines across various filetypes
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim'
Plug 'voldikss/vim-floaterm'

" Snippet 'engine'
Plug 'SirVer/ultisnips'
" Snippet definitions
Plug 'honza/vim-snippets'

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

Plug 'mengelbrecht/lightline-bufferline'

" This function (defined in plug.vim) modifies Vim's runtimepath (see :h
" runtimepath) to include the directories where the plug-ins, listed above, are
" installed; for example, if we have Plug 'A/B' above, then the path
" <plug-in-directory>/A/B is added, where <plug-in-directory> is the directory
" set within the plug#begin() function. However, it leaves the packpath variable
" (see :h packpath) alone.
call plug#end()
