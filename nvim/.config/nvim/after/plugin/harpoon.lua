local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

vim.keymap.set('n', '<C-n>', function() ui.nav_file(1) end)
vim.keymap.set('n', '<C-h>', function() ui.nav_file(2) end)
vim.keymap.set('n', '<C-y>', function() ui.nav_file(3) end)
vim.keymap.set('n', '<C-s>', function() ui.nav_file(4) end)
vim.keymap.set('n', '<C-p>', function()
  local current = mark.get_index_of(vim.api.nvim_buf_get_name(0))
  if current then
    local next = mark.get_index_of(mark.get_current_index() + 1)
    if next then
      ui.nav_file(current + 1)
    else
      ui.nav_file(1)
    end
  end
end)
