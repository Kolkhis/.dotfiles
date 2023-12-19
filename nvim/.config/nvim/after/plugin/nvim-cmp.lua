local cmp = require('cmp')

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),

    -- Sources for autocomplete

    -- Buffer completions for search
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },

        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
    }),
})

-- set up snips (this only adds frameworks to filetypes)
-- local luasnip = require('luasnip')
-- luasnip.filetype_extend('python', {'django'} )

-- sources = cmp.config.sources({
--   { name = 'nvim_lsp' },
--   { name = 'luasnip' }, -- For luasnip users.
-- }, {
--   { name = 'buffer' },
-- }),
