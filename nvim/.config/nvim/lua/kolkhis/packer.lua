--[[
-- Git cmds for easy portability (first time setup).

-- Linux:
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

-- Windows:
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
--]]

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use('Kolkhis/streamer-mode.nvim')
  -- use('E:/Coding/nvim_plugin/dev/streamer-mode.nvim')

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

  use('tpope/vim-commentary') -- Commenting with gc / gcgc / gcc

  use('tpope/vim-fugitive') -- Git sht

  -- theme
  use('marko-cerovac/material.nvim')

  -- icons
  use('nvim-tree/nvim-web-devicons')

  --[[ LSP/autocompletion stuff ]]

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
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' },
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
  --

  use({ 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }) -- LuaLine: sexy status line

  use({ 'akinsho/bufferline.nvim', tag = '*', requires = 'nvim-tree/nvim-web-devicons' }) -- Bufferline for tab views of buffers.
end)
