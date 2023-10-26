
set nocp            " nocompatible
filetype plugin on  " enable netrw (technically a plugin)
syntax on           " syntax highlighting

if filereadable(expand("~/.vim/colors.vim"))
    source ~/.vim/colors.vim
endif

if isdirectory(expand("~/.vim/undodir/"))
    set undodir=~/.vim/undodir
    set undofile
else
    echo("No undo directory! Fix with `mkdir ~/.vim/undodir`.")
endif

if isdirectory(expand("~/.vim/vimswap/"))
    set dir=~/.vim/vimswap//
else
    echo("There is no swap directory! Fix with `mkdir ~/.vim/vimswap`.")
endif


set viminfo='20,<1000,s1000                " Don't truncate yanks/deletes
set completeopt=menuone,noselect,preview   " cot - autocompletion/omnicompletion settings
set t_vb=       " visual bell output code
set t_Co=256    " number of colors

set path+=**
command! MakeTags !ctags -R .

let g:mapleader=" "
let g:maplocalleader=" "

" put that banner away, netrw. no one wants to see that.
let g:netrw_banner=0
let g:netrw_alto=1      " split opens on bottom instead of top
let g:netrw_altv=1      " vsplit opens on right instead of left
let g:netrw_preview=1   " open previews in vsplit


" Format Options:
" :h formatoptions
set fo+=croqnlmM1j
set fo-=twa2vbB]p


" REMAPS:
" Specify a register to delete/yank/etc into, e.g., `"a` for register a
nnoremap <leader>dd "add 
vnoremap <leader>d "ad 
" Don't overwrite current register when replacing a word with `p`
vnoremap <leader>p "_dP
noremap <leader>pv :Ex<CR>
noremap <leader>pV :Sex!<CR>
" Copy to system clipboard
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap! zj <Esc>
vnoremap zj <Esc>
" Awesome remap for moving lines around
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap X y/<C-R>"<CR>
" hot-reloading .vimrc
nnoremap <leader>ar :source ~/.vimrc<CR>
nmap <leader>gh :h ins-completion<CR>

set nu              " number
set rnu             " relativenumber
set so=5            " scrolloff=5
set siso=5          " sidescrolloff=5
set enc=utf-8       " encoding=utf-8
set tgc             " termguicolors
set ws              " wrapscan - Searches wrap around the file
set is              " incsearch
set nohls           " nohlsearch
set noeb            " noerrorbells
set novb            " novisualbell
set bo=all          " belloff=all
set ww+=,~          " whichwrap+=,~  - Which movement keys can go to next line 
set ru              " ruler
set smd             " showmode
set lbr             " linebreak - only visually break lines
set spc=            " spellcapcheck
set hi=200          " history - Command History
set tf              " ttyfast
set sc              " showcmd - show typed chars in the bottom right 
set hid             " hidden - don't unload a buffer when it's 'abandoned'
set icon
set tm=274          " timeoutlen=500 - This is annoying
set ttm=5           " ttimeoutlen=-1 
set ic              " ignorecase
set scs             " smartcase

" Indentation:
set sw=4            " shiftwidth=4
set ts=4            " tabstop=4
set sts=4           " softtabstop=4
set et              " expandtab
set ai              " autoindent
set sta             " smarttab - <Tab> inserts spaces


" Plugins:
" Install vim-plug: Download plug.vim and put it in the "autoload" directory.
"
" Install vim-plug on Linux/Unix: 
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Install vim-plug on Windows (PowerShell): 
" iwr -useb https:raw.githubusercontent.cm/junegunn/vim-plug/master/plugvim |`
"   ni $HOME/vimfiles/autoload/plug.vim -Force

if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.local/share/vim/plugins')
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'dense-analysis/ale'
    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
    call plug#end()
endif

