local os = require('kolkhis.detect_os')
local check_venv = function()
    if vim.env['VIRTUAL_ENV'] then
        if os.is_linux then
            local d = vim.fn.system([[pwd | sed 's;${HOME};~;' | sed -E 's;.*/(.*/.*/.*$);\1;' 2>/dev/null ]])
            return ('%s - (venv)'):format(d):gsub('\n', '')
        else
            return ('%s - (venv)'):format(vim.fs.basename(vim.env.PWD))
        end
    else
        if os.is_linux then
            local d = vim.fn.system([[pwd | sed 's;${HOME};~;' | sed -E 's;.*/(.*/.*/.*$);\1;' 2>/dev/null ]])
            return ('%s'):format(d):gsub('\n', '')
        else
            return ('%s'):format(vim.fs.basename(vim.env.PWD))
        end
    end
end

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { check_venv, 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
})
