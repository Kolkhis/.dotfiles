M = {}


--- Makes the selected line(s) TODO items. 
--- If the selected line(s) are already TODO items, they will be converted
--- into normal list items. 
--- If nothing is selected, the current line will be used.
---@diagnostic disable:param-type-mismatch
function M:md_todo_handler()
    local line = vim.fn.getline('.')
    local mode = vim.api.nvim_get_mode().mode
    if line == nil then
        vim.notify('Problem encountered when parsing line')
        return
    end
    if mode == 'n' then
        if self.match_todo(line) then
            vim.cmd([[s/^\(\s*\)\?\(\* \|\d\{1,}\. \)\[.\] /\1\2/]])
        elseif self.match_ul(line) then
            vim.cmd.norm('^a [ ]')
        elseif self.match_ol(line) then
            vim.cmd([[s/\(\d\.\) /\1 [ ] ]])
        else
            vim.cmd.norm('I* [ ] ')
        end
    else
        if self.match_todo(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\(\* \|\d\{1,}\. \)\?\[.\] /\1\2/]])
            vim.cmd.norm('gv')
            -- vim.cmd([['<,'>s/^\(\s*\)\?\(\* \|\d\{1,}\. \)\(\[.\]\) /\1\2/]])
        elseif self.match_ul(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\* /\1* [ ] ]])
            vim.cmd.norm('gv')
        elseif self.match_ol(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\(\d\{1,}\)\. /\1\2. [ ] ]])
            vim.cmd.norm('gv')
        else
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?/\1* [ ] /]])
            vim.cmd.norm('gv')
        end
    end
end

--- Handler for unordered list items (`* `, `* [ ]`, `* [x]`)
--- Makes the selected line(s) unordered list items.
--- If the selected line(s) are already unordered list items, they will be
--- converted to normal lines.
--- If the selected line(s) are ordered list items, they will be converted to
--- unordered list items.
--- If nothing is selected, the current line will be used.
function M:md_ul_handler()
    local mode = vim.api.nvim_get_mode().mode
    local line = vim.fn.getline('.')
    if line == nil then
        vim.notify('Problem encountered when parsing line')
        return
    end

    if mode == 'n' then
        if self.match_ul(line) then
            if self.match_todo(line) then
                vim.cmd([[s/^\(\s*\)\?\* \[.\] \?/\1/]])
            else
                vim.cmd.norm('^2x')
            end
        elseif self.match_ol(line) then
            vim.cmd.norm('^3xI* ')
        else
            vim.cmd.norm('I* ')
        end
    else
        if self.match_todo(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\* \[.\]/\1/]])
        elseif self.match_ul(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\* /\1/]])
        elseif self.match_ol(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\d\{1,}\. /\1* /]])
        else
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?/\1* /]])
        end
    end
end

--- Handler for ordered list items (`1. `, `2. [ ]`, `3. [x]`)
--- Makes the selected line(s) ordered list items.
--- If the selected line(s) are already ordered list items, they will be
--- converted to normal lines.
--- If the selected line(s) are unordered list items, they will be converted to
--- ordered list items.
--- If the selected are both ordered list items and TODO items, they will be
--- converted to normal lines.
--- If nothing is selected, the current line will be used.
function M:md_ol_handler()
    local mode = vim.api.nvim_get_mode().mode
    local line = vim.fn.getline('.')
    if line == nil then
        vim.notify('Problem encountered when parsing line')
        return
    end

    if mode == 'n' then
        if self.match_ol(line) then
            if self.match_todo(line) then
                vim.cmd([[s/^\(\s*\)\?\(\d\{1,}\. \)\[.\] /\1/]])
            else
                vim.cmd.norm('^3x')
            end
        elseif self.match_ul(line) then
            vim.cmd.norm('^2xI1. ')
        else
            vim.cmd.norm('I1. ')
        end
    else
        if self.match_ol(line) then
            if self.match_todo(line) then
                vim.cmd.norm('I')
                vim.cmd([['<,'>s/^\(\s*\)\?\(\d\{1,}\. \)\[.\] /\1/]])
            else
                vim.cmd.norm('I')
                vim.cmd([['<,'>s/\(\s*\)\?\d\{1,}\. /\1/]])
            end
        elseif self.match_ul(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\* /\11. /]])
        else
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?/\11. /]])
            if vim.fn.line("'<") ~= vim.fn.line("'>") then
                vim.cmd([[norm! '<jV'>gk]]) -- Automatically number them 
            end
        end
    end
end

--- Add linebreaks (two spaces) to the end of lines that don't end with
--- a comma, two spaces, or three backticks (code blocks).
function M:md_add_linebreaks()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'n' then
        vim.cmd([[%s/\([^,\| \{2}\|`\{3}]$\)/\1  /]])
    else
        vim.cmd([['<,'>s/\([^,\| \{2}\|`\{3}]$\)/\1  /]])
    end
end

--- Check if the line is an ordered list item (`1. `)
---@param line string
---@return nil
function M.match_ol(line)
    return vim.fn.match(line, [[^\(\s*\)\?\d\+\. ]]) ~= -1
end

--- Check if the line is an unordered list item (`* `)
---@param line string
---@return boolean is_unordered_list: true if the line is an unordered list item
function M.match_ul(line)
    return vim.fn.match(line, [[^\(\s*\)\?\* ]]) ~= -1
end

--- Check if line is a TODO item (`* [ ]`, `* [x]`, `1. [ ]`, `1. [x]`, etc)
---@param line string
---@return boolean is_todo_item: true if the line is a TODO item
function M.match_todo(line)
    return vim.fn.match(line, [[^\(\s*\)\?\(\*\|\d\.\) \(\[ \]\|\[x\]\|\[_\]\) ]]) ~= -1
end

--- Check for incompleted TODO item (`[ ]`)
---@param line string
---@return boolean is_incompleted_todo: true if the line is an incompleted TODO item
function M.match_incomplete_todo(line)
    return vim.fn.match(line, [[^\(\s*\)\? \?\[ \] \?]]) ~= -1
end

--- Check for a completed TODO item (`[x]`)
---@param line string
---@return boolean: true if the line is an completed TODO item
function M.match_complete_todo(line)
    return vim.fn.match(line, [[^\(\s*\)\? \?\[x\] \?]]) ~= -1
end


--- Turn camelCase to snake_case, and visa versa
---@diagnostic disable: param-type-mismatch
M.camel_snake_toggle = function()
    local cword = vim.fn.expand('<cword>')
    local camelCase = vim.regex([[^\l.*\(\u\)]]):match_str(cword)
    local snake_case = vim.regex([[^\w.*\(_\)]]):match_str(cword)
    local new_word = cword
    if snake_case then
        local all_caps = vim.regex([[\([A-Z_]\+\)]]):match_str(cword)
        if all_caps then
            new_word = cword:lower()
        end
        local index, _ = new_word:find('_')
        while index do
            local charToUpper = new_word:sub(index + 1, index + 1):upper()
            new_word = new_word:sub(1, index - 1) .. charToUpper .. new_word:sub(index + 2)
            index, _ = new_word:find('_')
        end
    elseif camelCase then
        local index, _ = new_word:find('%u')
        while index do
            local char_to_lower = new_word:sub(index, index)
            new_word = new_word:sub(1, index - 1) .. '_' .. char_to_lower:lower() .. new_word:sub(index + 1)
            index, _ = new_word:find('%u')
        end
    else
        return
    end
    if new_word then
        vim.cmd(('normal! viws%s'):format(new_word))
        return new_word
    end
end

--- Toggle between all-caps and all-lowercase
M.lower_upper_toggle = function()
    local cword = vim.fn.expand('<cword>')
    local lcase = cword:match('%l')
    local ucase = cword:match('%u')
    if lcase and not ucase then
        vim.cmd('execute "normal! gUiw"')
    elseif not lcase and ucase then
        vim.cmd('execute "normal! guiw"')
    elseif lcase and ucase then
        vim.cmd('execute "normal! gUiw"')
    else
        return
    end
end

return M
