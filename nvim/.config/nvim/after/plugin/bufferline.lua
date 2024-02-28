local bufferline = require('bufferline')
bufferline.setup({
    options = {
        mode = 'tabs', -- 'tabs' | 'buffers'
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon', -- | 'underline' | 'none',
        },
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        separator_style = 'slant',
        { '|', '|' },
        buffer_close_icon = '󰅖',
        color_icons = true, -- whether or not to add the filetype icon highlights
        diagnostics = 'nvim_lsp',
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
    },
})
vim.o.showtabline = 1
