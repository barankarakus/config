" Having issues with 'float' window type in vanilla vim; can't :FloatermToggle
" out of them
if has('nvim')
    let g:floaterm_wintype = 'float'
else
    let g:floaterm_wintype = 'split'
endif
let g:floaterm_position = 'bottom'
let g:floaterm_height = 0.3
let g:floaterm_width = 0.95
let g:floaterm_autoclose = 2
let g:floaterm_title = 'floaterm($1|$2)'
