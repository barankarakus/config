" <Ctrl-Space> to trigger completion when in insert mode
inoremap <silent><expr> <C-space> coc#refresh()
inoremap <silent><expr> <C-@> coc#refresh()

" Jump forward and backward between 'diagnostics', i.e. lines with errors
nmap <silent> [g <Plug>(coc-diagnostic-next)  
nmap <silent> ]g <Plug>(coc-diagnostic-prev)

" Show documentation for item which cursor is on in a preview window
nnoremap <silent> <leader>sd :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
" This doesn't work for me...?
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Go-to keybindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

" When seleting among auto-complete suggestions, let <CR> (<Enter>) select
" the highlighted completion item (as opposed to literally entering <Enter>);
" by default, the way to 'select' the highlighted item is to simply continue
" typing normally, but I like confirming my selection with <Enter>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

