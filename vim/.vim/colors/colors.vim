
let g:colors = {}

" Main colors
let g:colors.main = {
\ 'white': '#EEFFFF',
\ 'gray': '#717CB4',
\ 'black': '#000000',
\ 'red': '#F07178',
\ 'green': '#C3E88D',
\ 'yellow': '#FFCB6B',
\ 'blue': '#82AAFF',
\ 'paleblue': '#B0C9FF',
\ 'cyan': '#89DDFF',
\ 'purple': '#C792EA',
\ 'orange': '#F78C6C',
\ 'darkred': '#DC6068',
\ 'darkgreen': '#ABCF76',
\ 'darkyellow': '#E6B455',
\ 'darkblue': '#6E98EB',
\ 'darkcyan': '#71C6E7',
\ 'darkpurple': '#B480D6',
\ 'darkorange': '#E2795B'
\ }

" Editor colors
let g:colors.editor = {
\ 'link': '#80CBC4',
\ 'cursor': '#FFCC00',
\ 'title': '#EEFFFF',
\ 'bg': '#0F111A',
\ 'bg_alt': '#090B10',
\ 'fg': '#A6ACCD',
\ 'fg_dark': '#717CB4',
\ 'selection': '#1F2233',
\ 'contrast': '#090B10',
\ 'active': '#1A1C25',
\ 'border': '#232637',
\ 'line_numbers': '#3B3F51',
\ 'highlight': '#1F2233',
\ 'disabled': '#464B5D',
\ 'accent': '#84FFFF'
\ }
" Please translate the following lua script into VimScript, such that it will work in Vim 8.2, using the colors your provided in your last message:
" LSP colors
let g:colors.lsp = {
\ 'error': '#FF5370',
\ 'warning': g:colors.main.yellow,
\ 'info': g:colors.main.paleblue,
\ 'hint': g:colors.main.purple
\ }

" Syntax colors
let g:colors.syntax = {
\ 'comments': '#464B5D',
\ 'variable': g:colors.editor.fg,
\ 'field': g:colors.editor.fg,
\ 'keyword': g:colors.main.purple,
\ 'value': g:colors.main.orange,
\ 'operator': g:colors.main.cyan,
\ 'fn': g:colors.main.blue,
\ 'string': g:colors.main.green,
\ 'type': g:colors.main.purple
\ }

" Git colors
let g:colors.git = {
\ 'added': g:colors.main.green,
\ 'removed': g:colors.main.red,
\ 'modified': g:colors.main.blue
\ }

" Background colors
let g:colors.backgrounds = {
\ 'sidebars': g:colors.editor.bg,
\ 'floating_windows': g:colors.editor.bg,
\ 'non_current_windows': g:colors.editor.bg,
\ 'cursor_line': g:colors.editor.active
\ }

