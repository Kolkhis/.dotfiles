--[[Resources:

API docs
https://neovim.io/doc/user/api.html#API

Pynvim docs
https://pynvim.readthedocs.io/en/latest/usage/python-plugin-api.html#nvim-api-methods-vim-api

Lua reference
https://learnxinyminutes.com/docs/lua/

Regex
:h character-classes
https://www.vimregex.com/


-- Dev repo for apt
-- sudo add-apt-repository ppa:neovim-ppa/unstable -y

--]]



--[=[ Regex with vim ]=]--

--[[
			Pattern atom

    ^ start matching from beginning of a line
        /^This match This only at beginning of line
    $ match pattern should terminate at end of a line
        /)$ match ) only at end of line
        /^$ match empty line
    . match any single character, excluding new line
        /c.t match 'cat' or 'cot' or 'c2t' or 'c^t' but not 'cant'

For more info, :h pattern-atoms


			Pattern Qualifiers

    *greedy match preceding character 0 or more times
        /abc* match 'ab' or 'abc' or 'abccc' or 'abcccccc' etc
    \+ greedy match preceding character 1 or more times
        /abc\+ match 'abc' or 'abccc' but not 'ab'
    \? match preceding character 0 or 1 times (\= can also be used)
        /abc\? match 'ab' or 'abc' but not 'abcc'
    \{-} non-greedy match preceding character 0 or more times
        Consider this line of text 'This is a sample text'
        /h.\{-}s will match: 'his'
        /h.*s will match: 'his is a s'
        Read more on non-greedy matching
    \{min,max} greedy match preceding character min to max times (including min and max)
        min or max can be left unspecified as they default to 0 and infinity respectively
        greedy match, tries to match as much as possible
    \{-min,max} non-greedy match, tries to match as less as possible
    \{number} match exactly with specified number
        /c\{5} match exactly 'ccccc'

For more info, 
:h pattern-overview
:h character-classes

]]--


--[[  

On Termux and WSL, comment out shell opts set.lua.

Add "Edit with Neovim" to dotfiles
Windows Registry Editor Version 5.00


[HKEY_CLASSES_ROOT\*\shell\Edit with Neovim]
"Icon"="C:\Users\username\AppData\Local\Programs\Neovim\bin\nvim-qt.exe"
OR, if installed globally:
"Icon"="C:\Program Files\Neovim\bin\nvim-qt.exe"

[HKEY_CLASSES_ROOT\*\shell\Edit with Neovim\command]
@="C:\Users\username\AppData\Local\Programs\Neovim\bin\nvim-qt.exe" "%1"
OR, if installed globally:
@="C:\Program Files\Neovim\bin\nvim-qt.exe" "%1"



vim.fn functions:
https://neovim.io/doc/user/usr_41.html#function-list




--]]

--- Playing with the vim.api
-- vim.keymap.set('n', '<leader>tk', function ()
-- 	-- vim.cmd('lua print("wowowow")')
-- 	-- local buf = vim.api.nvim_get_current_buf()
-- 	-- vim.api.nvim_set_current_buf(buffer)
-- 	-- vim.api.nvim_create_autocmd(event, opts?)
-- 	-- Trying to create a floating window
-- 	local buf = vim.api.nvim_create_buf(false, true)
-- 	vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
-- 	-- vim.api.nvim_buf_set_text(buf, 1, 1, -1, -1, 'wowowowoowowow')
-- 	vim.api.nvim_buf_set_lines(buf, 0, 0, false, {'Wowowowowoowow'})
-- end)
-- local win = vim.api.nvim_get_current_win()








--[[


anything in nvim/plugin will load/run at runtime.

package.loaded has a table of loaded packages.

vim.api.nvim_get_keymaps



:h wincmd

:e https://github.com/somefile.c -- this works

--]]

--[=[ Refactoring tip ]=]--
--[=[ 
-- Grep with Telescope, add to quickfix list
-- Then, to apply a cmd to each thing:
:cdo <cmd>

:h cdo

]=]
--[[
--
-- Disable LSP for current buffer
-- :lua vim.lsp.diagnostics.disable(vim.api.nvim_get_current_buf())
--]]









