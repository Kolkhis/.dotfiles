local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)
lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»',
})
lsp.setup()

local os = require('kolkhis.detect_os')
if os.is_linux or os.is_termux then
    ConfigPath = vim.fs.normalize('~/.dotfiles/nvim/.config/nvim/stylua.toml')
else
    ConfigPath = vim.fs.normalize('E:/Coding/.config/stylua.toml')
end

-- Set up neodev before lspconfig
require('neodev').setup({})

local lspconfig = require('lspconfig')

local function setup_lua_ls()
    lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                completion = {
                    callSnippet = 'Replace',
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false, -- Fix for "Configure current file" prompt
                },
                formatting = {
                    formatAs = 'lua',
                    styluaArgs = { '--config-path', ConfigPath },
                },
            },
        },
    })
end

local function error_handler(err)
    print(('Error encountered while setting up lua_ls: \n%s'):format(err))
end
xpcall(setup_lua_ls, error_handler)

-- ############### null-ls ###############
local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

local format_sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.djlint,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.shfmt.with({
        extra_args = { '-i', '4', '-ci' },
    }),
    -- null_ls.builtins.diagnostics.shellcheck,
}

if not os.is_termux then -- Termux doesn't have clang support yet
    table.insert(format_sources, null_ls.builtins.formatting.clang_format)
end

null_ls.setup({
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
    end,
    sources = format_sources,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = require('mason-lspconfig').get_installed_servers()

for _, server in ipairs(servers) do
    lspconfig[server].setup({
        capabilities = capabilities,
    })
end
