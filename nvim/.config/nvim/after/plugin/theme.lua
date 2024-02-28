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
    custom_colors = function(colors)
        colors.syntax.comments = '#35374B'
    end,
    custom_highlights = {
        Comment = { fg = '#35374B' }, -- Add hlgroups
        Cursor = { fg = 'White', bg = 'Red' },
    },
})
vim.cmd.colorscheme('material-deep-ocean')

