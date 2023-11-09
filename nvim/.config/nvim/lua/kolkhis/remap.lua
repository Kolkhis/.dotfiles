-- set space to do nothing, then add it as map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- local opts = { silent = true, noremap = true }  -- Maybe streamline this stuff into a module/loop
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'zp', '<C-u>zz', { silent = true, noremap = true }) -- jump up
vim.keymap.set({ 'n', 'v' }, 'zn', '<C-d>zz', { silent = true, noremap = true }) -- jump down
vim.keymap.set({ 'i', 'v' }, 'zj', '<Esc>', { silent = true, noremap = true })   -- remap escape key (for awful keyboards)
-- Keep cursor centered
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', { silent = true, noremap = true })

-- hella sexy remap (by me). paste in insert mode
vim.keymap.set('i', '<C-Space>', function()
    local w = vim.fn.getreg('*')
    vim.api.nvim_put({ w }, 'c', true, true) -- after, follow)
end, { silent = true, noremap = true })

-- Navigate word wraps
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Formatting
vim.keymap.set(
    { 'n', 'v' },
    '<leader>fm',
    '<cmd>lua vim.lsp.buf.format({ async = true })<CR>',
    { desc = 'LSP formatting', silent = true, noremap = true }
)

-- Enable streamer mode
vim.keymap.set('n', '<leader>sm', '<cmd>SM<CR>', { silent = true, noremap = true })

-- Get to netrw
vim.keymap.set('n', '<leader>pv', '<cmd>Ex<CR>')
vim.keymap.set('n', '<leader>pV', '<cmd>Sex!<CR>')

-- Clipboard integreity
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y', { silent = true, noremap = true }) -- Copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { silent = true, noremap = true })
vim.keymap.set('x', '<leader>p', [["_dP]], { silent = true, noremap = true })       -- Replace in select mode without overwriting register/clipboard

-- Kinda like refactoring, start %s for current word
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = true, noremap = true })

local os = require('kolkhis.detect_os')
-- Give current file execute permissions
if os.is_linux or os.is_phone then
    vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, noremap = true })
end

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>yf', '<cmd>%y+<CR>', { silent = true, desc = 'Yank entire file', noremap = true })

vim.keymap.set(
    'c',
    [[<leader>\]],
    [[\(\)<Left><Left>]],
    { silent = false, desc = 'Put Capture Group in expression in command mode.', noremap = true }
)

-- Add a Markdown bullet point and checkbox "[ ]"
local md_aug_id = vim.api.nvim_create_augroup('MarkdownAug', { clear = false })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.md' },
    callback = function()
        vim.keymap.set({ 'n', 'i' }, ';td', function()
            vim.api.nvim_put({ '* [ ]' }, 'c', true, true)
        end, { silent = true, noremap = true, })
    end,
    group = md_aug_id,
    desc = 'Add a keybinding (<leader>td) to add a bullet point and TODO checkbox.',
})


-- case toggling in insert mode
vim.keymap.set({ 'i' }, '<C-l>', function()
    local cword = vim.fn.expand('<cword>')
    local lcase = cword:match('%l*')
    local ucase = cword:match('%u*')
    if lcase then
        if lcase == cword then
            vim.cmd('normal! viwUei')
            return
        end
    end
    if ucase then
        vim.cmd('normal! viwuei')
    end
end)


