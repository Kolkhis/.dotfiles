set nocp            " nocompatible
filetype plugin on  " enable netrw (technically a plugin)
syntax on           " syntax highlighting

colo ocean

" TODO: Set directories to appropriate OS path: if has('linux') / if has('win32')
" $HOME/vimfiles/undodir
if isdirectory(expand("~/.vim/undodir/"))
    set undodir=~/.vim/undodir
    set undofile
else
    echo("No undo directory! Creating it...")
    silent !mkdir -p ~/.vim/undodir
endif

if isdirectory(expand("~/.vim/vimswap/"))
    set dir=~/.vim/vimswap//
else
    echo("There is no swap directory! Creating it...")
    silent !mkdir -p ~/.vim/vimswap
endif


set viminfo='20,<1000,s1000         " Don't truncate yanks/deletes
set cot=menuone,noselect,popup      " completeopt - autocompletion/omnicompletion settings
set t_vb=       " visual bell output code
set t_Co=256    " number of colors

set path+=**
command! MakeTags !ctags -R .
 
let g:mapleader=" "
let g:maplocalleader=" "

" put that banner away, netrw. no one wants to see that.
" let g:netrw_banner=0
let g:netrw_alto=1        " split opens on bottom instead of top
let g:netrw_altv=1        " vsplit opens on right instead of left
let g:netrw_preview=1     " open previews in vsplit
let g:netrw_liststyle=3   " tree view


" Format Options:
" :h formatoptions
set fo+=croqnlmM1j
set fo-=twa2vbB]p


" Remaps:
" :h :nme
" :h mapmode
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
nnoremap <leader>gh :h ins-completion<CR> |"
" Get the identifier needed for highlights
nnoremap <leader>si :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
" insert a capture group in command mode
cnoremap <leader>\ \(\)<Left><Left>

" Resize current window
nnoremap <leader>- :resize -5<CR>
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>= :resize +5<CR>

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


" Highlight on yank:
if v:version >= 801
    aug highlightYankedText
        au!
        au TextYankPost * call YankHighlight()
    aug end

    fu! YankHighlight()
        if v:event['operator'] == 'y'
            if (!exists('g:yanked_text_matches'))
                let g:yanked_text_matches = []
            endif

            let g:yank_match_id = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
            let g:yank_window_id = winnr()
            call add(g:yanked_text_matches, [g:yank_match_id, g:yank_window_id])
            call timer_start(100, 'DelYankHighlight')
        endif
    endf

    fu! DelYankHighlight(timer_id)
        while !empty(g:yanked_text_matches)
            let l:match = remove(g:yanked_text_matches, 0)
            let l:match_id = l:match[0]
            let l:window_id = l:match[1]
            try
                call matchdelete(l:match_id, l:window_id)
            endtry
        endwhile
    endf

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
    call plug#end()

    call ale_config#SetAleOptions()
    call vim_go_config#SetVimGoOptions()
endif

