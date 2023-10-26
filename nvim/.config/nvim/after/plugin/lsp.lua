local lsp = require('lsp-zero')
lsp.preset('recommended')

local os = require('kolkhis.detect_os')
if os.is_linux or os.is_phone then
  ConfigPath = vim.fs.normalize('~/.config/nvim/stylua.toml')
else
  ConfigPath = vim.fs.normalize('E:/Coding/.config/stylua.toml')
end

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

-- Set up neodev before lspconfig
require('neodev').setup({})

-- EXPERIMENT: Try error handling for termux port (Maybe not needed - lua ls is now set up)
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

-- .lua_ls.setup(lsp.nvim_lua_ls())
local function error_handler(err)
  print('Error encountered while setting up lua_ls: ' .. err)
end
local success = xpcall(setup_lua_ls, error_handler)

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»',
})

lsp.setup()

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

local format_sources = {
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.djlint,
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.formatting.beautysh,
}

--- ocaml
-- null_ls.builtins.formatting.ocamlformat

--- perl
-- null_ls.builtins.formatting.perltidy
--
--- nginx
-- null_ls.builtins.formatting.nginx_beautifier
--
--
--- bash/.sh Quotes variables and stuff
-- null_ls.builtins.formatting.shellharden 


if not os.is_phone then -- Termux doesn't have clang support yet
  table.insert(format_sources, null_ls.builtins.formatting.clang_format)
end

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
    --- you can add more stuff here if you need it
  end,
  sources = format_sources,
})

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- require('lspconfig')['pyright'].setup({ capabilities = capabilities })
