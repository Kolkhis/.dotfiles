syntax enable
hi clear

" General settings
set background=dark

" Basic txt/bg
hi Normal guifg=#B0C4DE guibg=#090B10
hi Cursor guifg=#FFCC00 guibg=#FFCC00

" Syntax
hi Constant guifg=#BB80B3
hi String guifg=#4DB6AC
hi Function guifg=#82AAFF
hi Statement guifg=#89DDFF
hi Comment guifg=#A1ACB3
hi Type guifg=#FFCB6B
hi PreProc guifg=#F07178

" select highlights
hi Search guibg=#F07178 guifg=#000000
hi Visual guifg=Black guibg=#555555

" gutter
hi LineNr guifg=#546E7A
hi Special guifg=#F78C6C

" status line
let s:active_font_color = '#7286D3'
let s:inactive_font_color = '#144272'
let s:inactive_window = '#181D31'
let s:active_window = '#0A2647'
exe 'hi StatusLine guifg=' . s:active_window . ' guibg=' . s:active_font_color
exe 'hi StatusLineNC guifg=' . s:inactive_window . ' guibg=' . s:inactive_font_color
exe 'hi StatusLineTerm guifg=' . s:active_window . ' guibg=' . s:active_font_color

" tabs
exe 'hi TabLine guifg=' . s:inactive_font_color . ' guibg=' . s:inactive_window
exe 'hi TabLineFill guifg=' . s:inactive_window . ' guibg=' . s:active_font_color
exe 'hi TabLineSel guifg=' . s:active_font_color . ' guibg=' . s:active_window

" other stuff
hi MatchParen guifg=#C792EA guibg=#000000
hi NonText guifg=#546E7A

" highlighting
highlight helpHyperTextJump guifg=#82AAFF guibg=NONE
highlight helpHyperTextEntry guifg=#89DDFF guibg=NONE

" netrw
highlight netrwDir guifg=#82AAFF guibg=NONE
highlight netrwClassify guifg=#89DDFF guibg=NONE
highlight netrwLink guifg=#F07178 guibg=NONE
highlight netrwSymLink guifg=#F07178 guibg=NONE
highlight netrwExe guifg=#C3E88D guibg=NONE
highlight netrwComment guifg=#A1ACB3 guibg=NONE
highlight netrwListstyle guifg=#BB80B3 guibg=NONE
highlight netrwCmdSep guifg=#C792EA guibg=NONE
highlight netrwVersion guifg=#80CBC4 guibg=NONE

" vsplit
highlight VertSplit guifg=#546E7A guibg=NONE

" folds
highlight Folded guifg=#A1ACB3 guibg=#263238
highlight FoldColumn guifg=#80CBC4 guibg=#263238
highlight SignColumn guifg=NONE guibg=#263238

" popup menu
highlight Pmenu guifg=#546E7A guibg=#121212
highlight PmenuSel guifg=#80CBC4 guibg=#121212
highlight PmenuSbar guifg=#A1ACB3 guibg=#263238
highlight PmenuThumb guifg=#80CBC4 guibg=#121212

" misc
highlight IncSearch guifg=#FFFFFF guibg=#558EC0
highlight ModeMsg guifg=#80CBC4 guibg=NONE
highlight MoreMsg guifg=#82AAFF guibg=NONE
highlight QuickFixLine guifg=#FFFFFF guibg=#558EC0
highlight Terminal guifg=#A1ACB3 guibg=#1E272C
highlight Title guifg=#80CBC4 guibg=NONE
highlight WarningMsg guifg=#F07178 guibg=NONE

