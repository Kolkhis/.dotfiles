vim.cmd('colo material-deep-ocean')

vim.api.nvim_set_hl(0, 'Cursor', { fg = 'White', bg = 'Red' })

vim.g.netrw_banner = false
vim.g.netrw_alto = false
vim.g.netrw_altv = true
vim.g.netrw_preview = 1 -- open previews in vsplit

-- Fix dumb python indenting
vim.g.python_indent = {
    open_paren = 4,
    nested_paren = 4,
    continue = 4,
    closed_paren_align_last_line = false
}

-- Modify path for better find/completion
vim.o.path = vim.o.path .. '**'

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

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Timeout for hotkeys
vim.o.timeout = true
vim.o.timeoutlen = 350

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,' -- preview

-- Enable 24-bit RGB
vim.o.termguicolors = true

-- Indentation
vim.o.smarttab = true -- Smart tabbing
vim.o.smartindent = false -- Smart indenting (for C-like programs?)
-- vim.o.tabstop = 4

vim.o.softtabstop = 4
vim.o.shiftwidth = 4 -- Set Tab to 4 spaces.
vim.o.expandtab = true

vim.o.showbreak = '> ' -- Show a > when lines wrap
vim.o.autoread = true -- Automatically reload file when it was changed elsewhere.
vim.o.textwidth = 100 -- cuz PEP8 lol
-- vim.o.wrapmargin = -1000 -- Attempt to make python format correctly with `gq`

-- Autosaving
vim.o.updatecount = 50
vim.o.updatetime = 200

-- Matching paren QOL
vim.o.showmatch = true
vim.o.matchtime = 1


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- vim.cmd('au! TextYankPost * silent! lua vim.highlight.on_yank()') -- vimscript+lua implementation
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
