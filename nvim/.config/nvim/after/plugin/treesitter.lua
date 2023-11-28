require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  -- `:TSInstallInfo` for a list of available parsers
  ensure_installed = {
    'bash',
    'python',
    'c',
    'lua',
    'vim',
    'vimdoc',
    'javascript',
    'typescript',
    'perl',
    'rust',
    'cpp',
    'java',
    'r',
    'html',
    'htmldjango',
    'css',
    'sql',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'php',
    'phpdoc',
    'markdown',
    'markdown_inline',
    'comment',

    'xml',
    'csv',
    'json',
    'yaml',
    'toml',
    'ini',

    'gpg',
    'regex',
    'todotxt',
    'regex',
    'awk',
    'pymanifest',
    'dockerfile',
    'query',
    'make',
    'cmake',
    'http',
    'diff',
    'jq',
    'passwd',

    'gitcommit',
    'gitignore',
    'git_config',
    'git_rebase',
    'gitattributes',
  },

  sync_install = false,
  auto_install = false,
  ignore_install = {},
  modules = {},

  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    highlight = { enable = false },
    indent = { enable = false },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
    additional_vim_regex_highlighting = true,
  },
})
-- `:h nvim-treesitter-incremental-selection-mod`
