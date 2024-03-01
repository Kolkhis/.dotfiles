require('material').setup({
    contrast = {
        terminal = false,
        floating_windows = false,
        filetypes = {},
    },
    plugins = {
        'nvim-cmp',
        'nvim-web-devicons',
        'telescope',
    },
    high_visibility = { darker = true, },
    lualine_style = 'stealth',
    custom_highlights = {
        Comment = { fg = '#424769' }, -- 424769 7077A1 45474B
        Cursor = { fg = 'White', bg = 'Red' },
    },
})
vim.cmd.colorscheme('material-deep-ocean')

