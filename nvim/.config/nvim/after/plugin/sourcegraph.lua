-- Sourcegraph configuration. All keys are optional
require("sg").setup({})
vim.keymap.set('n', '<leader>ss', "<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<CR>")


---Prompts user to ask Cody about the current selection
local function ask_cody()
    vim.ui.input({prompt = "Ask Cody >"}, function (question)
        vim.cmd((":'<,'>CodyAsk %s"):format(question))
    end)
end
  -- TODO: Get prompt
vim.keymap.set('v', '<leader>ca', ask_cody, { silent = false, noremap = true, desc = "Ask Cody about the current selection" })

vim.keymap.set({'n', 'v'}, '<leader>co', '<cmd>CodyToggle<CR>', { silent = true, noremap = true, desc = "Toggle the Cody Chat Window"})
