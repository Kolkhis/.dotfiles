--
-- -- Change width if on the phone
-- local os = require('kolkhis.detect_os')
-- if os.is_phone then
-- 	W = 20
-- else
-- 	W = 30
-- end
--[=[ 
require('neo-tree').setup({
  popup_border_style = 'rounded',
  window = {
    hijack_netrw_behavior = 'disabled',
    position = 'left',
    -- width = W,
    width = 30,

    mappings = {
      ['<space>'] = {
        'toggle_node',
        nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
    },
  },
  -- "open_default", -- netrw disabled, opening a directory opens neo-tree
  -- in whatever position is specified in window.position
  -- "open_current",  -- netrw disabled, opening a directory opens within the
  -- window like netrw would, regardless of window.position
  -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
})
]=]

--filesystem = {
--  filtered_items = {
--    hide_by_name = {
--      --"node_modules"
--    },
--    hide_by_pattern = { -- uses glob style patterns
--      --"*.meta",
--      --"*/src/*/tsconfig.json",
--    },
--    always_show = { -- remains visible even if other settings would normally hide it
--      --".gitignored",
--    },
--    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
--      --".DS_Store",
--      --"thumbs.db"
--    },
--    never_show_by_pattern = { -- uses glob style patterns
--      --".null-ls_*",
--    },
--  },
--},

-- git_status = {
--   window = {
--     position = "float",
--     mappings = {
--       ["A"]  = "git_add_all",
--       ["gu"] = "git_unstage_file",
--       ["ga"] = "git_add_file",
--       ["gr"] = "git_revert_file",
--       ["gc"] = "git_commit",
--       ["gp"] = "git_push",
--       ["gg"] = "git_commit_and_push",
--     }
--   }
-- }

