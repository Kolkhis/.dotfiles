-- set colorscheme
vim.cmd('colo material-deep-ocean')

-- Stop persistent highlight after search
vim.o.hlsearch = false

-- Set line numbers
vim.o.number = true
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
vim.o.completeopt = 'menuone,noselect'

-- Enable 24-bit RGB
vim.o.termguicolors = true

-- Indentation
vim.go.smarttab = false -- Smart tabbing
vim.o.smartindent = true -- Smart indenting (for C-like programs?)
vim.o.shiftwidth = 4 -- Set Tab to 4 spaces.
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
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
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
