-- telescope.defaults.layout_config / layout_strategy / telescope.actions

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local utils = require('telescope.utils')
require('telescope').setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = { height = 0.5 },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<C-p>'] = actions.move_selection_previous,
                ['<C-n>'] = actions.move_selection_next,
                ['<C-k>'] = actions.cycle_history_prev,
                ['<C-j>'] = actions.cycle_history_next,
                ['<C-f>'] =  actions.send_selected_to_qflist, -- actions.smart_add_to_qflist,
            },

            n = {
                ['o'] = actions.file_vsplit,
                ['<Tab>'] = actions.toggle_selection,
                ['<C-d>'] = actions.preview_scrolling_down,
                ['<C-u>'] = actions.preview_scrolling_up,
                ['<C-p>'] = actions.move_selection_previous,
                ['<C-n>'] = actions.move_selection_next,
                ['<C-f>'] =  actions.send_selected_to_qflist, -- actions.smart_add_to_qflist,
            },
        },
    },
})

-- -- Need to prepend 'lua.' to get autocompletion (y tho).
-- local actions = require('lua.telescope.actions')
-- local builtin = require('lua.telescope.builtin')
-- local themes = require('lua.telescope.themes')
-- local telescope = require('lua.telescope').setup({})
-- local utils = require('lua.telescope.utils')

--------------------------Seach Current Word Usage
vim.keymap.set('n', '<leader>su', function()
    builtin.grep_string(themes.get_dropdown({
        cwd = utils.buffer_dir(),
    }))
end, { silent = true, noremap = true, desc = '[S]earch [U]sages of Current Word' })

--------------------------Diagnostics
vim.keymap.set('n', '<leader>sd', function()
    builtin.diagnostics(themes.get_dropdown())
end, { silent = true, noremap = true, desc = '[S]earch [D]iagnostics' })

--------------------------Old Files
vim.keymap.set('n', '<leader>of', function()
    builtin.oldfiles(themes.get_dropdown())
end, { silent = true, noremap = true, desc = '[?] Find Recently [O]pened [F]iles' })

--------------------------Open Buffers
vim.keymap.set('n', '<leader><space>', function()
    builtin.buffers(themes.get_dropdown())
end, { silent = true, noremap = true, desc = '[ ] Find existing buffers' })

--------------------------Current Buffer Fuzzy Find
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(themes.get_dropdown({ winblend = 5, previewer = false }))
end, { silent = true, noremap = true, desc = '[/] Fuzzily search in current buffer' })

--------------------------Command History
vim.keymap.set({ 'n', 'v' }, '<leader>ch', function()
    builtin.command_history(themes.get_dropdown())
end, { silent = true, noremap = true, desc = '[C]ommand [H]istory' })

--------------------------Registers
vim.keymap.set('n', '<leader>rs', function()
    builtin.registers(themes.get_cursor())
end, { silent = true, noremap = true, desc = 'Vim [R]egister [S]earch' })

--------------------------Quickfix
vim.keymap.set({ 'n' }, '<leader>qf', function()
    builtin.quickfix(themes.get_dropdown())
end, { silent = true, noremap = true, desc = '[Q]uick[f]ix' })

--------------------------Man Pages
vim.keymap.set('n', '<leader>ma', function()
    builtin.man_pages(themes.get_ivy())
end, { silent = true, noremap = true, desc = '[Ma]n Pages' })

--------------------------Search Help
vim.keymap.set('n', '<leader>sh', function()
    builtin.help_tags(themes.get_ivy({ winblend = 5 }))
end, { silent = true, noremap = true, desc = '[S]earch [H]elp Tags' })

vim.keymap.set('n', '<leader>hw', function()
    local word = vim.fn.expand('<cword>')
    builtin.help_tags(themes.get_ivy({ winblend = 2 }))
    vim.cmd(('normal! i%s'):format(vim.fn.expand('<cword>')))
    vim.api.nvim_put({ word }, 'c', true, false)
end, { silent = true, noremap = true, desc = 'Search [H]elp Tags for [W]ord' })

vim.keymap.set('n', '<leader>hW', function()
    local word = vim.fn.expand('<cWORD>')
    builtin.help_tags(themes.get_ivy({ winblend = 2 }))
    vim.cmd(('normal! i%s'):format(vim.fn.expand('<cWORD>')))
    vim.api.nvim_put({ word }, 'c', true, false)
end, { silent = true, noremap = true, desc = 'Search [H]elp Tags for [W]ord' })
--------------------------

--------------------------All Telescope Builtin Pickers
vim.keymap.set('n', '<leader>pp', function()
    builtin.builtin(themes.get_dropdown())
end, { silent = true, noremap = true, desc = 'Telesco[p]e Builtin [P]ickers' })

--------------------------Git Status
vim.keymap.set('n', '<leader>gs', function()
    builtin.git_status(themes.get_dropdown())
end, { silent = true, noremap = true, desc = '[G]it [S]tatus' })

--------------------------Git Commits
vim.keymap.set('n', '<leader>gc', function()
    builtin.git_commits(themes.get_ivy())
end, { silent = true, noremap = true, desc = '[G]it [C]ommits' })

--------------------------Current Buffer Commits
vim.keymap.set('n', '<leader>gh', function()
    builtin.git_bcommits(themes.get_dropdown())
end, { silent = true, noremap = true, desc = "[G]it [H]istory of Current Buffer" })

--------------------------Live Grep
vim.keymap.set('n', '<leader>ps', function()
    builtin.live_grep(themes.get_dropdown({
        grep_open_files = false,
        cwd = utils.buffer_dir(),
    }))
end, { silent = true, noremap = true, desc = '[P]arse [S]tring by Grep' })

--------------------------Grep String
vim.keymap.set('n', '<leader>pw', function()
    vim.ui.input({ prompt = 'Grep > ' }, function(q)
        builtin.grep_string(themes.get_dropdown({
            search = q,
            grep_open_files = false,
            cwd = utils.buffer_dir(),
        }))
    end)
end, { silent = true, noremap = true, desc = 'Search [P]roject with [G]rep Under Cursor' })

vim.keymap.set('n', '<leader>pW', function()
    builtin.grep_string({ search = vim.fn.expand('<cWORD>') })
end, { silent = true, noremap = true, desc = 'Search [P]roject for c[W]ORD Under Cursor' })

--------------------------Find Files
vim.keymap.set('n', '<leader>fi', function()
    builtin.find_files(themes.get_dropdown({
        hidden = true,
    }))
end, { silent = true, noremap = true, desc = '<leader>fi Search [Fi]les' })

--------------------------Git Files
vim.keymap.set('n', '<leader>pf', function()
    builtin.git_files(themes.get_dropdown({
        cwd = utils.buffer_dir(),
        layout_config = { prompt_position = 'bottom' },
    }))
end, { silent = true, noremap = true, desc = '<leader>pg [P]roject Git [F]iles' })

--------------------------Telescope Builtin Commands
vim.keymap.set({ 'n', 'v' }, '<leader>cm', function()
    builtin.commands(themes.get_ivy({ winblend = 5, layout_config = { prompt_position = 'top' } }))
end, { silent = true, noremap = true, desc = 'List All [C]o[m]mands' })

vim.keymap.set({ 'n' }, '<leader>pa', function()
    builtin.autocommands()
end, { silent = true, noremap = true, desc = '[A]uto [c]ommands' })

vim.api.nvim_create_user_command('P', function()
    require('telescope.builtin').planets()
end, {})

