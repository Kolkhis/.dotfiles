
set nocp            " nocompatible
filetype plugin on  " enable netrw (technically a plugin)
syntax on           " syntax highlighting

" Set undo files to not clutter up pwd
if ! isdirectory(expand('~/.vim/undodir'))
    echo("No undo directory! Fix with `mkdir ~/.vim/undodir`.")
else
    set undodir=~/.vim/undodir
    set undofile
endif



set viminfo='20,<1000,s1000               " Don't truncate yanks/deletes
set completeopt=menuone,noselect,preview  " cot - autocompletion/omnicompletion settings

set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
set t_vb=           " visual bell output code

" FILE SEARCHING:
" Set path to search in subfolders, tab-completion for all file-related tasks
set path+=**


" TAGS:
""" This is basically a fzf, type `:find *.vim<Tab>` and it pulls up all .vim
""" files in the current directory and all subdirectories (with `set path+=**` set)
"no_plugins.vim"
command! MakeTags !ctags -R .
" C-] will jump to tag
" g<C-]> will list all tags
" <C-t> will jump back up the tag stack

let g:mapleader=" "
let g:maplocalleader=" "

nmap <leader>gh ":h ins-completion<CR>"

let g:netrw_banner=0
let g:netrw_altv=1 " Vertical split opens on right instead of left
let g:netrw_alto=1 " Horizontal split opens on bottom instead of top
let g:netrw_preview=1 " Open previews in vertical split




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
" Awesome remap for moving lines around
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

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
set tm=500          " timeoutlen=500
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
    Plug 'whatyouhide/vim-gotham'
    call plug#end()
endif

" func LessInitFunc() abort
"     set nocursorcolumn
" endfunction

colorscheme gotham256


" Make background transparent
" hi Normal guibg=NONE ctermbg=NONE  

