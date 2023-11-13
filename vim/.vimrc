set nocp            " nocompatible
filetype plugin on  " enable netrw (technically a plugin)
syntax on           " syntax highlighting

" TODO: Set directories to appropriate OS path: if has('linux') / if has('win32')
" $HOME/vimfiles/undodir
if isdirectory(expand("~/.vim/undodir/"))
    set undodir=~/.vim/undodir
    set undofile
else
    echo("No undo directory! Creating it...")
    silent !mkdir -p ~/.vim/undodir
    set undodir=~/.vim/undodir
    set undofile
endif

if isdirectory(expand("~/.vim/vimswap/"))
    set dir=~/.vim/vimswap//
else
    echo("There is no swap directory! Creating it...")
    silent !mkdir -p ~/.vim/vimswap
    set dir=~/.vim/vimswap//
endif


set viminfo='20,<1000,s1000         " Don't truncate yanks/deletes
set cot=menuone,noselect,popup      " completeopt - autocompletion/omnicompletion settings
set t_vb=       " visual bell output code
set t_Co=256    " number of colors

set path+=**
command! MakeTags !ctags -R .
 
" put that banner away, netrw. no one wants to see that.
" let g:netrw_banner=0
let g:netrw_alto=1        " split opens on bottom instead of top
let g:netrw_altv=1        " vsplit opens on right instead of left
let g:netrw_preview=1     " open previews in vsplit
let g:netrw_liststyle=3   " tree view
let g:netrw_hide=0        " show all files (including hidden. default 1)


" Format Options:
" :h formatoptions
set fo+=croqnlmM1j
set fo-=twa2vbB]p


" Remaps:
" :h :nme
" :h mapmode

" Set Space to do nothing, and set it as mapleader
nnoremap <silent> <Space> <Nop>
let g:mapleader=" "
let g:maplocalleader=" "


" Specify a register to delete/yank/etc into, e.g., `"a` for register a
nnoremap <leader>dd "add 
vnoremap <leader>d "ad 
"
" Don't overwrite current register when replacing a word with `p`
vnoremap <leader>p "_dP
" Get to netrw
noremap <leader>pv :Ex<CR>
noremap <leader>pV :Sex!<CR>

" Fix Y yanking
nnoremap Y y$

" TODO: Fix this (compile with clipboard support)
if has('clipboard')
" Copy to system clipboard (vim must be compiled with clipboard support)
  nnoremap <silent> <leader>y "+y
  nnoremap <silent> <leader>Y "+Y
  vnoremap <silent> <leader>y "+y
  vnoremap <silent> <leader>Y "+Y
endif

" Replace current selection with register without copying it
xnoremap <silent> <leader>p "_dP

" map zj to Esc
nnoremap zj <Esc>
vnoremap zj <Esc>

" Awesome remap for moving lines around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Go the next occurrence of selected text (Same as *)
vnoremap X *

" hot-reloading .vimrc
nnoremap <leader>ar :source ~/.vimrc<CR>

" Search help files for word under cursor
nnoremap <leader>gh :call kolkhis#GetHelpCurrentWord()<CR>

" Get the identifier needed for highlights
nnoremap <leader>si :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
" insert a capture group in command mode
cnoremap <leader>\ \(\)<Left><Left>
 
" Auto-center cursor on screen when jumping
nnoremap <C-u> <C-u>zz
vnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
vnoremap <C-d> <C-d>zz

" Resize current window
nnoremap <leader>- :resize -5<CR>
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>= :resize +5<CR>

" Navigate line wraps normally
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Refactor current word (global substitution)
nnoremap <silent> <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Yank entire file
nnoremap <silent> <leader>yf <Cmd>%y" <CR> 

inoremap <C-c> <Esc>:call kolkhis#ToggleCase()<CR>
nnoremap <C-c> <Esc>:call kolkhis#ToggleCase()<CR>

" Options:
set fdm=marker      " foldmethod
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
set tm=274          " timeoutlen=500 - This is annoying
set ttm=5           " ttimeoutlen=-1 
set ic              " ignorecase
set scs             " smartcase
set scl=number      " signcolumn
set ut=400          " updatetime
set wmnu            " wildmenu - show matching files on tab complete
set icon

" Indentation:
set sw=4            " shiftwidth=4
set ts=4            " tabstop=4
set sts=4           " softtabstop=4
set et              " expandtab
set ai              " autoindent
set sta             " smarttab - <Tab> inserts spaces
set ls=2            " laststatus=2 - enable statusline

" Add '' to-do checkboxes in markdown files
augroup MarkdownAug
  autocmd!
  autocmd BufEnter,BufWinEnter *.md :
    nnoremap <buffer> ;td :call kolkhis#AddMarkdownCheckbox()<CR>$
    inoremap <buffer> ;td <Esc>:call kolkhis#AddMarkdownCheckbox()<CR>A
augroup END

" Highlight on yank:
if v:version >= 801
  aug highlightYankedText
    au!
    au TextYankPost * call kolkhis#YankHighlight()
  aug end
endif


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

    " Syntax
    Plug 'sheerun/vim-polyglot'
    " Colorscheme
    Plug 'joshdick/onedark.vim'
    " Status Line
    Plug 'itchyny/lightline.vim'
    call plug#end()

    " Configure plugin options
    call kolkhis#SetAleOptions()
    call kolkhis#SetVimGoOptions()
    call kolkhis#SetLightlineOptions()
endif

call kolkhis#SetColors()
colorscheme onedark
execute 'DM'

