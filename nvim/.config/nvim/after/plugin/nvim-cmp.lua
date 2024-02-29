local cmp = require('cmp')
local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.filetype_extend('html', { 'djangohtml' })
luasnip.filetype_extend('html', { 'javascript' })
luasnip.filetype_extend('python', { 'django' })

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),

    -- Sources for autocomplete
    sources = cmp.config.sources({
        { name = 'cody' },
        { name = 'nvim_lsp' },
        { name = 'cmp_luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})

-- Buffer completions for search
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
        { name = 'path' },
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

-- ################## Autopairs ##################
-- If you want insert `(` after accepting autocompletion
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = { sh = false, bash = false },
    })
)
local npairs = require('nvim-autopairs')

npairs.setup({
    fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'", '<' },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        comma_check = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
    },
})
