-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local handlers = require('nvim-autopairs.completion.handlers')

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = {
            -- "*" is a alias to all filetypes
            ['*'] = {
                ['('] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    handler = handlers['*'],
                },
            },
            lua = {
                ['('] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    ---@param char string
                    ---@param item table item completion
                    ---@param bufnr number buffer number
                    ---@param rules table
                    ---@param commit_character table<string>
                    handler = function(char, item, bufnr, rules, commit_character)
                        -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                    end,
                },
            },
            -- Disable for tex
            tex = false,
        },
    })
)

local npairs = require('nvim-autopairs')

-- fast wrap stuff
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

-- Fix doubling up parens on autocomplete (acutally maybe this broke their fix?)
-- _G.MUtils = _G.MUtils or {}
-- MUtils.completion_confirm = function()
--   return npairs.completion_tab()
-- end
