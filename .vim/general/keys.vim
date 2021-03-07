" The most important keybinding
inoremap jk <Esc>

" Leader keys
let mapleader = ','
let maplocalleader = '\'

" making j, k move up one DISPLAY LINE, rather than true line
nnoremap j gj
nnoremap k gk

" Better tabbing
vnoremap > >gv
vnoremap < <gv

" Making H, J, K, L more powerful versions of h, j, k, l in Normal, Visual, and
" Operator-Pending modes:
" H moves to start of line, J down half a page, K up half a page, L to end of
" line, with the exception that I don't map J and K in Operator-Pending mode
" since 'half a page' isn't a very precise thing so I don't want to be
" applying operations on such a motion
nnoremap H ^
vnoremap H ^
onoremap H ^
nnoremap L $
vnoremap L $
onoremap L $
nnoremap J <C-D>
vnoremap J <C-D>
nnoremap K <C-U>
vnoremap K <C-U>

" By default, J joins the next line onto the current
" This is useful, so I remap it to <leader>j
nnoremap <leader>j J
vnoremap <leader>j J

nnoremap <C-Q> :Quit<CR>
