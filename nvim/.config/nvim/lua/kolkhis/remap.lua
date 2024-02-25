-- set space to do nothing
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'i', 'v' }, 'xj', '<Esc>', { silent = true, noremap = true })


vim.keymap.set('t', '<C-[><C-[>', [[<C-\><C-n>]], { noremap = true })

-- Keep cursor centered
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', { silent = true, noremap = true })

-- paste register in insert mode (handle ^@ control sequence)
vim.keymap.set({ 'i' }, '<C-Space>', [[<Esc>"+p]], { silent = true, noremap = true })


-- Navigate word wraps (swap j/k with gj/gk for wrapped lines)
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })
-- vim.keymap.set('n', 'gj', "v:count == 0 ? 'j' : 'gj'", { expr = true, silent = true, noremap = true })
-- vim.keymap.set('n', 'gk', "v:count == 0 ? 'k' : 'gk'", { expr = true, silent = true, noremap = true })

-- TODO: Combine this with the above, using the pipe operator to separate expressions
vim.keymap.set('n', '/', '<cmd>set hls<cr>/', { noremap = true, silent = true })
vim.keymap.set('n', 'j', "v:hlsearch == 0 ? 'j' : ':set nohls<CR>j'", { expr = true, silent = true  })
vim.keymap.set('n', 'k', "v:hlsearch == 0 ? 'k' : ':set nohls<CR>k'", { expr = true, silent = true  })


-- Formatting
vim.keymap.set({ 'n', 'v' }, '<leader>fm', function()
    vim.lsp.buf.format({ async = false })
end, { desc = 'LSP formatting', silent = true, noremap = true })

-- Enable streamer mode
vim.keymap.set({ 'n' }, '<leader>sm', '<cmd>SM<CR>', { silent = true, noremap = true })

-- Easy resizing
vim.keymap.set({ 'n' }, '<leader>=', '<cmd>wincmd 5+<CR>', { silent = true, noremap = true })
vim.keymap.set({ 'n' }, '<leader>-', '<cmd>wincmd 5-<CR>', { silent = true, noremap = true })
vim.keymap.set({ 'n' }, '<leader>0', '<cmd>wincmd 5><CR>')
vim.keymap.set({ 'n' }, '<leader>9', '<cmd>wincmd 5<<CR>')

-- Toggle fullscreen netrw
vim.keymap.set({ 'n' }, '<leader>pv', function()
    if vim.bo.filetype == 'netrw' then
        vim.cmd.Rex()
    else
        vim.cmd.Ex()
    end
end)

-- Clipboard integreity -- Copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y', { silent = true, noremap = true })

-- Replace in select mode without overwriting register/clipboard
vim.keymap.set({ 'x' }, '<leader>p', [["_dP]], { silent = true, noremap = true })

-- Kinda like refactoring, start %s for current word
vim.keymap.set(
    'n',
    '<leader>sb',
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { silent = true, noremap = true }
)

vim.keymap.set({ 'v' }, 'J', ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set({ 'v' }, 'K', ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>yf', '<cmd>%y+<CR>', { silent = true, desc = 'Yank entire file', noremap = true })

vim.keymap.set(
    { 'c' },
    [[<leader>\]],
    [[\(\)<Left><Left>]],
    { silent = true, noremap = true, desc = 'Put Capture Group in expression in command mode.' }
)

vim.keymap.set({ 'c' }, '<leader>am', [[\@<=]], {
    silent = true,
    noremap = true,
    desc = 'Put a "Match After" pattern in command mode.',
})

-- Toggle :Lexplore
vim.keymap.set({ 'n' }, '<leader>ns', '<Plug>NetrwShrink', { noremap = true, silent = true })

-- LSP
vim.keymap.set({ 'n' }, '<leader>rn', function ()
    vim.lsp.buf.rename()
end)

vim.keymap.set({ 'n' }, '<leader>ho', function ()
    vim.lsp.buf.hover()
end)

vim.keymap.set({ 'n' }, '<leader>ri', function()
    vim.lsp.buf.implmentations()
end)

vim.keymap.set({ 'n' }, '<leader>hs', function()
    vim.lsp.buf.signature_help()
end)


local fns = require('kolkhis.functions')
vim.keymap.set({ 'i', 'n' }, '<C-c>', fns.lower_upper_toggle, { noremap = true, silent = true })
vim.keymap.set({ 'i', 'n' }, '<C-x>', fns.camel_snake_toggle, { noremap = true, silent = true })

--[[ Markdown-Specific Keymaps ]]
local md_aug_id = vim.api.nvim_create_augroup('MarkdownAug', { clear = false })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.md' },
    callback = function()
        -- Add a Markdown bullet point and checkbox "* [ ]"
        vim.keymap.set({ 'n', 'i', 'v' }, ',lt', function()
            fns:md_todo_handler()
        end, { silent = true, noremap = true, buffer = true })

        -- Put in linebreaks (two spaces)
        vim.keymap.set({ 'n', 'v' }, ',lb', function()
            fns:md_add_linebreaks()
        end, { silent = true, noremap = true, buffer = true })

        -- Toggle the selection/line between an unordered-list and normal line
        vim.keymap.set({ 'n', 'v' }, ',ls', function()
            fns:md_ul_handler()
        end, { silent = true, noremap = true, buffer = true })

        -- Toggle the selection/line between an ordered-list and normal line
        vim.keymap.set({ 'n', 'v' }, ',lc', function()
            fns:md_ol_handler()
        end, { silent = true, noremap = true, buffer = true })

        -- Reformat weirdly formatted markdown
        vim.keymap.set({ 'n', 'v' }, ',le', function()
            fns:reformat_markdown()
        end, { silent = true, noremap = true, buffer = true })

        -- Generate table of contents
        vim.keymap.set({ 'n' }, ',lw', function()
            fns:generate_toc()
        end)

        -- Wrap current selection in a code block
        vim.keymap.set({ 'n', 'v' }, ',lz', function()
            fns:wrap_code_block()
        end)
    end,
    group = md_aug_id,
    desc = [[Add keybindings ( ,ls ,lc ,lt ,lb ,lw ,lz ) to add list items, todo boxes, table of contents, code blocks, and linebreaks.]],
})

-- Test keybinding
vim.keymap.set({  'v' }, '<leader>as', function()
    -- fns:wrap_code_block()
    print("Nothing mapped to test key.")
end)

