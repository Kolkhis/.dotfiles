local bufferline = require('bufferline')
bufferline.setup({
  options = {
    mode = 'tabs', -- set to "tabs" to only show tabpages instead -- "tabs" | "buffers"
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon', -- | 'underline' | 'none',
    },
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    separator_style = 'slant', {'|', '|'},
    buffer_close_icon = '󰅖',
    color_icons = true, -- whether or not to add the filetype icon highlights
	diagnostics = "nvim_lsp",
    -- get_element_icon = function(element)
    --   -- element consists of {filetype: string, path: string, extension: string, directory: string}
    --   -- This can be used to change how bufferline fetches the icon
    --   -- for an element e.g. a buffer or a tab.
    --   -- e.g.
    --   local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
    --   return icon, hl
    -- end,
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
  },
})
