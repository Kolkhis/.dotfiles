
" Config from 'How to do 90% of what plugins do (with just vim)
" Use vim-plug. Plug 'dense-analysis/ale' - let g:ale_linters = {'go': ['gometalinter', 'gofmt', 'gobuild']}
"                       ^ Pseudo-LSP
" don't pretend to be vi
set nocompatible

" enable netrw (technically a plugin?)
filetype plugin on

" Enable syntax highlights
syntax on

" FILE SEARCHING:
" Set path to search in subfolders, tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete

""" This is basically a fzf, type `:find *.vim<Tab>` and it pulls up all .vim
""" files in the current directory and all subdirectories (with `set path+=**` set)
"no_plugins.vim"
command! MakeTags !ctags -R .
" C-] will jump to tag
" g<C-]> will list all tags
" <C-t> will jump back up the tag stack


" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list


let g:mapleader=" "
let g:maplocalleader=" "

set nu rnu

" FILE BROWSING: (netrw)
" Tweaks for browsing
" can do a lot with netrw. Connect to remote filesystems with ssh, mark files.
" Open in split with v or o (or p)
" :h netrw-browse-maps
let g:netrw_banner=0
let g:netrw_altv=1 " Vertical split opens on right instead of left
let g:netrw_alto=1 " Horizontal split opens on bottom instead of top
let g:netrw_preview=1 " Open previews in vertical split

colorscheme koehler "

set showcmd " show typed chars in the bottom right 


" REGISTERS:
" Specify a register to delete/yank/etc into, e.g., `"a` for register a
nnoremap <leader>dd "add 

" :ls lists buffers
" :b <substring> goes to one of these buffers
" e.g., `:b plug` will go to no_plugins.vim, or :b rc will go to vimrc

set encoding=utf-8

set wrapscan

set incsearch nohls
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set belloff=all


set tabstop=4
set smarttab  " <Tab> inserts spaces
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent


set undodir=$HOME'/.vim/undodir'  " Set undo files to not clutter up pwd
set undofile

set viminfo='20,<1000,s1000  " Allow yanking large stuff..?

" set nocp            "Compatible not set"
" filetype plugin on  "Enable plugins"

" colorscheme koehler "
" syntax on
" set scrolloff=5
" set sidescrolloff=5
" set clipboard='unnamed'
" 

" " Turn off screen flashing/bells
" set incsearch nohls
" set noerrorbells
" set novisualbell
" set t_vb=
" set tm=500
" set belloff=all
" 
" " Switch tabs to 4 spaces
" set shiftwidth=4
" set tabstop=4
" set softtabstop=4
" set expandtab
" 
" " (relative) line numbers
" set nu
" set rnu


" " set Search to wrap around EOF
" set wrapscan
" 
 
" set undodir=$HOME'/.vim/undodir'
" set undofile
" 
" 
