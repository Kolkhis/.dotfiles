-- set space to do nothing, then add it as map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- local opts = { silent = true, noremap = true }  -- Maybe streamline this stuff into a module/loop
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'i', 'v' }, 'zj', '<Esc>', { silent = true, noremap = true }) -- remap escape key (for awful keyboards)

-- Keep cursor centered
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', { silent = true, noremap = true })

-- hella sexy remap (by me). paste register in insert mode
vim.keymap.set('i', '<C-Space>', function()
  local w = vim.fn.getreg('*')
  print(('The register contents:\n%s'):format(w))
  vim.api.nvim_put({ w }, 'c', true, true) -- after, follow)
  -- vim.cmd.normal('"*p')
end, { silent = true, noremap = true })

-- Navigate word wraps
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Formatting
vim.keymap.set({ 'n', 'v' }, '<leader>fm', function()
  -- TODO: Make command to get range if in visual mode
  vim.lsp.buf.format({ async = false })
end, { desc = 'LSP formatting', silent = true, noremap = true })

-- Enable streamer mode
vim.keymap.set('n', '<leader>sm', '<cmd>SM<CR>', { silent = true, noremap = true })

-- Easy resizing
vim.keymap.set('n', '<leader>=', '<cmd>resize +5<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>-', '<cmd>resize -5<CR>', { silent = true, noremap = true })

-- Toggle fullscreen netrw
vim.keymap.set('n', '<leader>pv', function()
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
vim.keymap.set('x', '<leader>p', [["_dP]], { silent = true, noremap = true })

-- Kinda like refactoring, start %s for current word
vim.keymap.set(
  'n',
  '<leader>sb',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { silent = true, noremap = true }
)

local os = require('kolkhis.detect_os')
-- Give current file execute permissions
if os.is_linux or os.is_phone then
  vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, noremap = true })
end

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
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
vim.keymap.set('n', '<leader>ns', '<Plug>NetrwShrink', { noremap = true, silent = true })

local fns = require('kolkhis.functions')
vim.keymap.set({ 'i', 'n' }, '<C-c>', fns.lower_upper_toggle, { noremap = true, silent = true })
vim.keymap.set({ 'i', 'n' }, '<C-x>', fns.camel_snake_toggle, { noremap = true, silent = true })

--[[ Markdown-Specific Keymaps ]]
local md_aug_id = vim.api.nvim_create_augroup('MarkdownAug', { clear = false })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.md' },
  callback = function()
    -- Add a Markdown bullet point and checkbox "* [ ]"
    vim.keymap.set({ 'n', 'i' }, ',td', function()
      vim.cmd.norm('I* [ ] ')
    end, { silent = true, noremap = true, buffer = true })

    -- Put in two spaces at the end of lines (that don't end in 2 spaces, comma, or codeblock)
    vim.keymap.set({ 'n', 'v' }, ',lb', function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == 'n' then
        vim.cmd([[%s/\([^,\| \{2}\|`\{3}]$\)/\1  /]])
      else
        vim.cmd([['<,'>s/\([^,\| \{2}\|`\{3}]$\)/\1  /]])
      end
    end, { silent = true, noremap = true, buffer = true })

    -- 'listify' the selection
    vim.keymap.set({ 'v', 'n' }, ',ls', function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == 'n' then
        vim.cmd.norm('I* ')
      else
        vim.cmd.norm('I')
        vim.cmd([['<,'>s/^/* /]])
      end
    end, { silent = true, noremap = true, buffer = true })

    -- 'numbered-listify' the selection
    vim.keymap.set({ 'v', 'n' }, ',lc', function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == 'n' then
        vim.cmd.norm('I1. ')
      else
        vim.cmd.norm('I')
        vim.cmd([['<,'>s/^/1. /]])
      end
    end, { silent = true, noremap = true, buffer = true })

  end,
  group = md_aug_id,
  desc = 'Add keybindings ( ,tt ,td ,lb ) to add bullet points, todo boxes, and linebreaks.',
})
