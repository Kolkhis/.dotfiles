--[[
-- Git cmds for easy portability (first time setup).

-- Linux:
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

-- Windows:
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
--]]
return require('packer').startup(function(use)
    -- :h packer.use
    use('wbthomason/packer.nvim')

    if require('kolkhis.detect_os').is_linux then
        use({ 'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua' })
        use('/home/kolkhis/Repos/github.com/kolkhis/streamer-mode.nvim/')
    else
        use('Kolkhis/streamer-mode.nvim')
    end

    use('ThePrimeagen/harpoon')

    --Telescope
    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } },
    })

    use('nvim-telescope/telescope-fzf-native.nvim', { build = 'make' })

    use('nvim-treesitter/nvim-treesitter', {
        run = function()
            vim.cmd('TSUpdate')
        end,
    }) -- treesitter. Highlighting syntax and stuff

    --[[ SIR TIMOTHY POPE - POPE OF VIM ]]

    use('tpope/vim-commentary') -- Commenting with gc / gcgc / gcc
    use('tpope/vim-fugitive') -- Git sht
    use('tpope/vim-surround')
    use('tpope/vim-repeat')

    -- theme
    use('marko-cerovac/material.nvim')

    -- icons
    use('nvim-tree/nvim-web-devicons')

    --[[ LSP/autocompletion stuff ]]

    use({
        'williamboman/mason.nvim',
        run = function()
            local language_servers = {
                'awk-language-server',
                'bash-language-server',
                'black',
                'clang-format',
                'clangd',
                'css-lsp',
                'djlint',
                'gopls',
                'html-lsp',
                'jq',
                'lua-language-server',
                'marksman',
                'prettierd',
                'pyright',
                'shellcheck',
                'shfmt',
                'stylua',
                'tailwindcss-language-server',
                'typescript-language-server',
                'vim-language-server',
            }
            local server_str = ''
            -- Check if servers are already installed
            local mason_registry = require('mason-registry')
            for i, server in ipairs(language_servers) do
                local installed = mason_registry.is_installed(server)
                if not installed then
                    server_str = ('%s%s '):format(server_str, server) -- server_str .. server .. ' '
                end
            end

            -- install any missing language servers
            if server_str ~= '' then
                vim.cmd(('MasonInstall %s'):format(server_str))
            else
                -- if servers are already installed, update them
                server_str = table.concat(language_servers, ' ')
                vim.cmd(('MasonUpdate %s'):format(server_str))
            end
        end,
    })

    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- lsp
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },

            -- snipsnip
            { 'rafamadriz/friendly-snippets' },
            {
                'L3MON4D3/LuaSnip',
                tag = 'v2.*',
                after = 'nvim-cmp',
                requires = { 'rafamadriz/friendly-snippets' },
            }, -- Required
        },
    })

    use('folke/neodev.nvim')

    -- null-ls - formatting
    use('jose-elias-alvarez/null-ls.nvim')

    -- Auto pairs
    use({
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    })

    -- Rainbow Parentheseseseses
    -- use('HiPhish/nvim-tx-rainbow2')

    --[[  End of LSP stuff  ]]

    use({ 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }) -- LuaLine: sexy status line

    use({ 'akinsho/bufferline.nvim', tag = '*', requires = 'nvim-tree/nvim-web-devicons' }) -- Bufferline for tab views of buffers.

    -- vim-go for sweet Go integration
    use({
        'fatih/vim-go',
        -- run = function()
            -- vim.cmd('GoUpdateBinaries')
        -- end,
    })
end)
