augroup vim_ft
    autocmd!
augroup END

augroup cpp_ft
    " The default commentstring is "/* %s */", where %s is the content of some line
    " I'm changing this to "// %s"
    autocmd FileType cpp setlocal commentstring=//\ %s
    autocmd FileType c setlocal commentstring=//\ %s
augroup END

augroup markdown_ft
    " Wrap long lines
    autocmd FileType markdown setlocal wrap
augroup END
