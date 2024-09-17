local os = require('kolkhis.detect_os')
-- Sourcegraph config. All keys are optional
if os.is_linux and not os.is_termux then
    local commands = require('sg.cody.commands')
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
                commands.ask_range(0, 0, -1, question)
                -- vim.cmd((':%% CodyAsk %s'):format(question))
            else
                vim.cmd.norm('I')
                local start_point, end_point = vim.fn.line("'<"), vim.fn.line("'>")
                if start_point and end_point then
                    commands.ask_range(start_point, end_point, -1, question)
                else
                    vim.cmd('echoerr "No selection to be passed to Cody."')
                end
                -- vim.cmd(("'<,'>CodyAsk %s"):format(question))
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


     -- Cody autocompletion keymap (WIP)
    vim.keymap.set({ 'i', 'n' }, 'zy', function ()
        commands.autocomplete({
            -- REQUEST
            ---@diagnostic disable:assign-type-mismatch
            filename = vim.api.nvim_buf_get_name(0), row = vim.fn.line('.'), col = vim.fn.col('.') },
            -- CALLBACK
            function (err, data)
                if err then
                    vim.print(err)
                    return
                end
                vim.print(data)
                vim.print("Data: ", data.completionEvent.items[1].insertText)
                vim.api.nvim_put({data.completionEvent.items[1].insertText}, 'c', true, true)
            end)
    end)

end





--[[ 
{
  completionEvent = {
    id = "d7ff2741-cb70-473b-a1eb-d58c6f74328b",
    items = { {
        charCount = 9,
        insertText = "im.cmd([[",
        stopReason = "stop"
      } },
    }
}
--]]


