vim.cmd('colo material-deep-ocean')

vim.api.nvim_set_hl(0, 'Cursor', { fg = 'White', bg = 'Red' })

-- Netrw Options
vim.g.netrw_banner = 0
vim.g.netrw_alto = 0
vim.g.netrw_altv = 0
vim.g.netrw_preview = 1 -- open previews in vsplit
vim.g.netrw_liststyle = 0 -- 3 for tree view
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
vim.g.netrw_hide = 0
vim.g.netrw_usetab = 1
vim.g.netrw_winsize = 20
vim.g.netrw_browse_split = 0 -- default = 0

-- Fix dumb python indenting
vim.g.python_indent = {
    open_paren = 4,
    nested_paren = 4,
    continue = 4,
    closed_paren_align_last_line = false,
}

-- Modify path for better find/completion (requires globstar??)
vim.opt.path:append({ '**' })

-- Cursorline highlighting
vim.opt.cursorlineopt = { 'number' }
vim.o.cursorline = true

-- Set how autocompletion behaves
vim.opt.completeopt = { 'menuone', 'noselect', 'preview' }

-- Stop persistent highlight after search
vim.o.hlsearch = false

-- Set line numbers
vim.o.nu = true
vim.o.rnu = true

-- Keep 5 lines before the cursor when scrolling
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between os and nvim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent (linewrap indent)
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching unless there's a capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Only show tab line if there's more than 1 tab
vim.o.showtabline = 1

vim.o.splitkeep = 'screen'

-- Timeout for hotkeys
vim.o.timeout = true
vim.o.ttimeout = true
vim.o.timeoutlen = 350
vim.o.ttimeoutlen = 50

vim.o.termguicolors = true -- Enable 24-bit RGB

-- Indentation
vim.o.smarttab = true -- Smart tabbing
vim.o.smartindent = false -- Smart indenting (for C-like programs?)
vim.o.softtabstop = 4
vim.o.shiftwidth = 4 -- Set Tab to 4 spaces.
vim.o.expandtab = true

vim.o.showbreak = '> ' -- Show a > when lines wrap
vim.o.autoread = true -- Automatically reload file when it was changed elsewhere.
vim.o.textwidth = 100

-- Autosaving
vim.o.updatecount = 50
vim.o.updatetime = 200

-- Matching paren QOL
vim.o.showmatch = true
vim.o.matchtime = 1

-- Turn off visual bell
vim.o.visualbell = false
vim.o.errorbells = false

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.cmd('au! TextYankPost * silent! lua vim.highlight.on_yank()') -- vimscript+lua implementation
local md_highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = md_highlight_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Start vim in netrw in the current directory
local vimstart_group = vim.api.nvim_create_augroup('VimStartup', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    group = vimstart_group,
    callback = function()
        if vim.fn.expand('%') == '' then
            -- vim.cmd.Lex()
            vim.cmd.e('.')
        end
    end,
    desc = 'Open the current directory in netrw if no file or directory is given when running vim.',
})
