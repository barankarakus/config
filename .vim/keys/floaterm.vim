nnoremap   <silent>   <leader>t   :FloatermToggle<CR>
" Escape to Terminal-Normal mode using <C-\><C-N> because it's vim/nvim
" agnostic
tnoremap   <silent>   <leader>t <C-\><C-N>:FloatermToggle<CR>
vnoremap <silent> <leader>t :FloatermSend<CR>
