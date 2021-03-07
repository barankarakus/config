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
" 'number' is the best option, but nvim doesn't provide this value as at time
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

"----- Indents and Tabs -----"

set expandtab
set shiftwidth=4
set softtabstop=-1
set shiftround

"----- Miscellaneous -----"

set hidden          " For smoothly transitioning between buffers
set updatetime=300
