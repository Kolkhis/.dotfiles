local os = require('kolkhis.detect_os')
-- Sourcegraph configuration. All keys are optional
if os.is_linux then
  require('sg').setup({})
  vim.keymap.set('n', '<leader>ss', function()
    -- "<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<CR>"
    require('sg.extensions.telescope').fuzzy_search_results()
  end)
  ---Prompts user to ask Cody about the current selection
  local function ask_cody()
    vim.ui.input({ prompt = 'Ask Cody > ' }, function(question)
      vim.cmd((":'<,'>CodyAsk %s"):format(question))
    end)
  end

  local function cody_task()
    local mode = vim.api.nvim_get_mode()
    if mode == 'n' then
      vim.ui.input({ prompt = 'Cody Task (global) > ' }, function(task)
        vim.cmd((':%CodyTask %s'):format(task))
      end)
    else
      vim.ui.input({ prompt = 'Cody Task > ' }, function(task)
        vim.cmd((":'<,'>CodyTask %s"):format(task))
      end)
    end
  end
  -- -- TODO: Get prompt
  -- vim.keymap.set('v', '<leader>ca', ask_cody, { noremap = true, desc = "Ask Cody about the current selection" })

  vim.keymap.set({ 'n', 'v' }, '<leader>ca', function()
    local mode = vim.api.nvim_get_mode()
    if mode.mode == 'n' then
      vim.ui.input({ prompt = 'Ask Cody about file > ' }, function(question)
        vim.cmd((':0,$CodyAsk %s'):format(question))
      end)
    else
      vim.ui.input({ prompt = 'Ask Cody about selection > ' }, function(question)
        vim.cmd((":'<,'>CodyAsk %s"):format(question))
      end)
    end
  end)

  vim.keymap.set(
    { 'n', 'v' },
    '<leader>co',
    '<cmd>CodyToggle<CR>',
    { silent = true, noremap = true, desc = 'Toggle the Cody Chat Window' }
  )

  vim.keymap.set({ 'n', 'v' }, '<leader>cp', function()
    vim.ui.input({ prompt = 'Cody Task -> ' }, function(task)
      vim.cmd((':CodyTask %s'):format(task))
    end)
  end)

  vim.keymap.set({ 'n', 'v' }, '<leader>cp', function()
    local mode = vim.api.nvim_get_mode()
    if mode == 'n' then
      vim.ui.input({ prompt = 'Cody Task (global) > ' }, function(task)
        vim.cmd((':0;$CodyTask %s'):format(task))
      end)
    else
      vim.ui.input({ prompt = 'Cody Task > ' }, function(task)
        vim.cmd((":'<,'>CodyTask %s"):format(task))
      end)
    end
  end, { noremap = true, desc = 'Task [C]ody with a [P]rompt.' })

end

-- End of os.is_linux() check
