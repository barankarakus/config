augroup vim_ft
    autocmd!
    autocmd FileType vim setlocal colorcolumn=80
augroup END

augroup cpp_ft
    autocmd!
    autocmd FileType cpp set colorcolumn=80
    autocmd FileType c set colorcolumn=80
    " The default commentstring is "/* %s */", where %s is the content of some
    " line
    " I'm changing this to "// %s"
    autocmd FileType cpp setlocal commentstring=//\ %s
    autocmd FileType c setlocal commentstring=//\ %s
augroup END

augroup markdown_ft
    autocmd!
    " Wrap long lines
    autocmd FileType markdown setlocal wrap
augroup END
