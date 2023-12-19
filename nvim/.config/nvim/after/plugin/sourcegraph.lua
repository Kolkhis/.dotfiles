local os = require('kolkhis.detect_os')
-- Sourcegraph config. All keys are optional
if os.is_linux then
    local sg = require('sg')
    local sgui = require('sg.extensions.telescope')
    sg.setup({})
    vim.keymap.set('n', '<leader>ss', function()
        sgui.fuzzy_search_results()
    end)

    local cody_ask = function()
        local mode = vim.api.nvim_get_mode().mode
        local prompt = mode == 'n' and 'Ask Cody (file) > ' or 'Ask Cody (selection) > '
        vim.ui.input({ prompt = prompt }, function(question)
            if mode == 'n' then
                vim.cmd((':%% CodyAsk %s'):format(question))
            else
                vim.cmd.norm('I')
                vim.cmd(("'<,'>CodyAsk %s"):format(question))
            end
        end)
    end

    local cody_task = function()
        local mode = vim.api.nvim_get_mode().mode
        local prompt = mode == 'n' and 'Cody Task (file) > ' or 'Cody Task (selection) > '
        vim.ui.input({ prompt = prompt }, function(task)
            if mode == 'n' then
                vim.cmd(('%% CodyTask %s'):format(task))
            else
                vim.cmd.norm('I')
                vim.cmd((":'<,'>CodyTask %s"):format(task))
            end
        end)
    end

    vim.keymap.set(
        { 'n', 'v' },
        '<leader>co',
        '<cmd>CodyToggle<CR>',
        { silent = true, noremap = true, desc = 'Toggle the [Co]dy Chat Window' }
    )

    vim.keymap.set({ 'n', 'v' }, '<leader>ca', cody_ask, {
        silent = true,
        noremap = true,
        desc = 'Get [C]ody to [A]nswer a question about the file or selection',
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>cp', cody_task, {
        silent = true,
        noremap = true,
        desc = 'Task [C]ody with a [P]rompt about file or selection.',
    })
end
