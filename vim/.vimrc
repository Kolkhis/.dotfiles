
set nocp            "Compatible not set"
filetype plugin on  "Enable plugins"


colorscheme koehler
syntax on
set scrolloff=5
set sidescrolloff=5
set clipboard='unnamed'

set viminfo='20,<1000,s1000

" Turn off screen flashing/bells
set incsearch nohls
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set belloff=all

" Switch tabs to 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" (relative) line numbers
set nu
set rnu


" set Search to wrap around EOF
set wrapscan


set undodir=$HOME'/.vim/undodir'
set undofile


