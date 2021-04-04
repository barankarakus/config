" Telling vim not to pretend it's vi.
" PLACE THIS AT THE TOP since it resets a bunch of other settings
set nocompatible
" Place vanilla vim's `viminfo` file at same directory as vimrc
if !has('nvim')
    let _ = split($MYVIMRC, '/')
    let _[-1] = "viminfo"
    let _ = join(_, '/')
    if $MYVIMRC[0] == '/'
        let _ = '/' . _
    endif
    execute "set viminfo+=n" . _
endif

"----- Console UI & Text Display -----"

set termguicolors   " Enable 24-bit colors
set number          " Line numbers
set cmdheight=1     " Height of command line
set showcmd         " Show command being typed
set scrolloff=5     " Keep at least 5 lines around the cursor
set nowrap          " When displaying long lines, don't wrap
if has('linebreak') " But if we do ever wrap, wrap intelligently
    set linebreak
endif
syntax on           " Highlight syntax
set laststatus=2    " Always display the status line
set noshowmode      " Don't show mode we're in on the command line
                    " The lightline status line will show this
set shortmess+=F  " Don't show file name on command line
set cursorline      " Highlight the line cursor is on
                    " The highlighting depends on the colorscheme
set wildmenu        " Turn on command line completion when typing Ex commands;
                    " simply type : followed by some stuff (e.g. 'se') and
                    " <Tab>/<Shift-Tab> to trigger completion and cycle through
                    " the options
" The signcolumn is where coc indicates errors
" 'number' is the best option, but nvim doesn't allow this value as at time
" of writing
if !has('nvim')
    set signcolumn=number
endif

"----- Text Editing and Searching Behaviour -----"

set hlsearch        " Highlight search results
set ignorecase      " Ignore case in search
set smartcase       " Unless there's a capital letter in front
set backspace=2     " Make backspace work properly in Insert mode
set autoindent      " Automatic indenting: If the current line begins with
                    " whitespace and we move onto a new line with <Enter>, the
                    " same whitespace is applied to the new line

"----- Indents, Shifts and Tabs -----"

" Controls the number of spaces to display in place of a <Tab> character
set tabstop=4
" With this set, any operation which would by default enter a <Tab> character
" into the text instead enters the number of space characters that a <Tab>
" character would be displayed as (this is set by the `tabstop` option; the
" default value is 8); we're essentially saying we do *not* want to be
" entering any <Tab> characters into the text
set expandtab
" # of spaces each shift or unshift operation (> or <) corresponds to
set shiftwidth=4
" When shifting, don't just naively enter/remove `shiftwidth` number of spaces;
" adjust the whitespace (in units of spaces) to be a multiple of `shiftwidth`
set shiftround
" This modifies how the <Tab> key is treated by vim in insert mode
" By default, this is 0 and whenever vim receives a <Tab> key in insert mode
" it adds `tabstop` number of spaces (if `expandtab` is not set, it'll
" actually add a real <Tab> character)
" If this is a positive number, say 4, then <Tab>'ing in insert mode will
" instead enter 4 spaces (if `expandtab` is not set, it'll actually add a
" mixture of <Tab>s and spaces, but on-screen it'll look like 4 spaces),
" independent of what `tabstop` is set to
" This allows you to have <Tab> characters be displayed as a different number
" of spaces to the number of spaces you actually want to see entered on-screen
" when you press <Tab>
" The real killer feature of having `softtabstop` on is that vim will keep
" track of blocks of spaces that it added because you pressed <Tab>, and will
" allow a backspace to clear all of those spaces. This is particularly useful
" when `expandtab` is set: it means that if we press <Tab> and 4 spaces are
" entered, we don't have to press backspace 4 times to get rid of that
" whitespace, we can just press it once
" Setting softtabstop to a negative number keeps the feature on but tells vim
" to use the value of `shiftwidth` as the value of `softtabstop`; this is a
" good way to ensure consistent behaviour across <Tab>'ing in insert mode and
" shifting in normal mode
set softtabstop=-1


"----- Miscellaneous -----"

set hidden          " For smoothly transitioning between buffers
set updatetime=300
set splitright      " Vertical splits create new window on the right
set splitbelow      " Horizontal splits create new window at bottom
" Enable mouse to be used
" This is great for resizing windows and scrolling, but other uses are that
" it allows for highlighting text to be copied with the mouse
set mouse=a
