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
            vim.cmd([[s/^\(\s*\)\?\(- \|\* \|\d\{1,}\. \)\[.\] /\1\2/]])
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
            vim.cmd([['<,'>s/^\(\s*\)\?\(- \|\* \|\d\{1,}\. \)\?\[.\] /\1\2/]])
            vim.cmd.norm('gv')
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
                vim.cmd([[s/^\(\s*\)\?\(-\|\*\) \[.\] \?/\1/]])
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
            vim.cmd([['<,'>s/^\(\s*\)\?\(\*\|-\) \[.\]/\1/]])
        elseif self.match_ul(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\(\*\|-\) /\1/]])
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

---Not currently in use
---@param line_number number
function M.add_single_ul_item(line_number)
    vim.cmd.norm(('%dGI* '):format(line_number))
end

---Not currently in use
---@param line_number number
function M.add_single_ol_item(line_number)
    vim.cmd.norm(('%dGI1. '):format(line_number))
end

---Take in a list of line numbers and makes each of them an unordered list item.
---@param line_numbers table
function M:add_multiple_ul_items(line_numbers)
    vim.cmd.norm('I')
    -- local selection = self.get_selection()
    -- line_numbers = selection.line_numbers
    for i = 1, #line_numbers do
        vim.cmd(([[%ds/^\(\s*\)\?/\1* /']]):format(line_numbers[i]))
    end
end

---Take in a list of line numbers and makes each of them an ordered list item.
---@param line_numbers table
function M.add_multiple_ol_items(line_numbers)
    vim.cmd.norm('I')
    for _, line_number in ipairs(line_numbers) do
        vim.cmd(([[%ds/^\(\s*\)\?/\11. /']]):format(line_number))
    end
    if #line_numbers > 1 then
        -- Automatically number them
        vim.cmd(([[norm! %dGjV%dGgk]]):format(line_numbers[1], line_numbers[-1]))
    end
end

----------------[[ Pattern Matching Functions ]]----------------

--- Check if the line is an ordered list item (`1. `)
---@param line string
---@return boolean is_ordered_list: true if the line is an ordered list item
function M.match_ol(line)
    return vim.fn.match(line, [[^\(\s*\)\?\d\{1,}\. ]]) ~= -1
end

--- Check if the line is an unordered list item (`* `)
---@param line string
---@return boolean is_unordered_list: true if the line is an unordered list item
function M.match_ul(line)
    return vim.fn.match(line, [[^\(\s*\)\?\(-\|\*\) ]]) ~= -1
end

--- Check if line is a TODO item (`* [ ]`, `* [x]`, `1. [ ]`, `1. [x]`, etc)
---@param line string
---@return boolean is_todo_item: true if the line is a TODO item
function M.match_todo(line)
    return vim.fn.match(line, [[^\(\s*\)\?\(-\|\*\|\d\{-1,}\.\) \(\[.\]\) ]]) ~= -1
end

--- Check if the line is indented.
--- Indentation is defined as any number of spaces or tabs.
---@param line string
---@return boolean is_indented: true if the line is indented
function M.match_indented(line)
    return vim.fn.match(line, [[^\(\s\)\{1,}]]) ~= -1
end

--- Check for incompleted TODO item (`[ ]`)
---@param line string
---@return boolean is_incompleted_todo: true if the line is an incompleted TODO item
function M.match_incomplete_todo(line)
    return vim.fn.match(line, [[^\(\s*\)\?\([*-]\|\d\{1,}\. \)\[ \] \?]]) ~= -1
end

--- Check for a completed TODO item (`[x]`)
---@param line string
---@return boolean is_completed_todo: true if the line is an completed TODO item
function M.match_complete_todo(line)
    return vim.fn.match(line, [[^\(\s*\)\?\([*-]\|\d\{1,}\. \)\[x\] \?]]) ~= -1
end

--- Check if the line is a code block start for any language. i.e., (```python)
---@param line string
---@return boolean is_code_block_start: true if the line is a code block start
function M.match_code_block_start(line)
    return vim.fn.match(line, [[^\(\s*\)\?[`]\{3}\(\w\)\{1,}]]) ~= -1
end

--- Check if the line is a code block end. i.e., (```)
---@param line string
---@return boolean is_code_block_end: true if the line is a code block end
function M.match_code_block_end(line)
    return vim.fn.match(line, [[^\(\s*\)\?[`]\{3}$]]) ~= -1
end

----------------[[ Case Toggle Functions ]]----------------

--- Turn camelCase to snake_case, and visa versa
--- Modifies the current word under cursor if it is camelCase or snake_case.
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

--- Switch the current word under cursor between all-caps and all-lowercase
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

------------------------In Progress-----------------------------

--- TODO:
--- [x] Loop through each line in visual selection
--- [ ] Account for when lines are broken into multiple lines
---
--- Strip out all of the weird markdown formatting from the current visual selection or current line.
function M.strip_nonsense()
    local mode = vim.api.nvim_get_mode().mode
    local line_start, line_end = vim.fn.line('.'), vim.fn.line('.')
    local range, line = '', ''
    if mode == 'n' then
        range, line = tostring(vim.fn.line('.')), vim.fn.getline('.')
    else
        vim.cmd.norm('I')
        line_start, line_end = vim.fn.line("'<"), vim.fn.line("'>")
        range, line = "'<,'>", vim.fn.getline("'<")
    end
    for i = line_start, line_end do
        range = tostring(i)
        line = vim.fn.getline(i)

        if vim.regex([[\(^\s*[*|-]\)]]):match_str(line) then
            if vim.regex([[^\s*-\s*]]):match_str(line) then
                vim.cmd(([[%ss/^\(\s*\)\?-\s*/\1\* /]]):format(range))
            end
            if vim.regex([[^\(\s*\)\([*-]\)\s*]]):match_str(line) then
                vim.cmd(([[%ss/^\(\s*\)[*-]\s*/\1\* /]]):format(range))
            end
            if vim.regex([[[^0-9]\. \([A-Za-z`]\)]]):match_str(line) then
                vim.cmd(([[%ss/\([^0-9]\)\. \([A-Za-z`]\)/\1\.  \r    * \2/g]]):format(range))
            end
        else
            if vim.regex([[[^0-9]\zs\. \([A-Za-z`]\)]]):match_str(line) then
                vim.cmd(([[%ss/[^0-9]\zs\. \([A-Za-z`]\)/\.  \r\1/g]]):format(range))
            end
        end
        if vim.regex([[\*\{2,}]]):match_str(line) then
            vim.cmd(([[%ss/\*\{2}//g]]):format(range))
        end
    end
end

--- Use syntax ID to determine if the line is a header or not
function M.match_markdown_header(ln_num)
    local syntax_id = vim.fn.synID(ln_num, vim.fn.col('.'), 1)
    local synid_name = vim.fn.synIDattr(syntax_id, 'name')
    if not synid_name then
        return false
    end
    if synid_name and synid_name:match('markdownH.*') then
        return true
    end
    return false
end

--- Inserts a Markdown table of contents into the current buffer, at the cursor.
function M:generate_toc()
    local toc = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
        if line:match('^#+ .+') then
            if self.match_markdown_header(i) then
                line = line:gsub('(.*)%s+$', '%1')
                local level, title = line:match('^(#+) (.+[^%s$])')
                if #level < 5 then
                    table.insert(toc, { level = #level, title = title })
                end
            end
        end
    end

    local toc_lines = {}
    table.insert(toc_lines, '## Table of Contents')
    for _, header in ipairs(toc) do
        local spacing = string.rep('    ', header.level - 2)
        local link_dest = header.title:lower():gsub('([.(),`{}:^$])', ''):gsub('%s', '-')
        -- link_dest = link_dest:gsub('%s', '-')
        local link = ([[%s* [%s](#%s) ]]):format(spacing, header.title:gsub(':$', ''), link_dest)
        table.insert(toc_lines, link)
    end

    local completed_toc = table.concat(toc_lines, '\n')
    vim.fn.setreg('a', completed_toc)
    vim.cmd.norm('Oo')
    vim.cmd('normal! "ap')
end

----------------[[ Visual Selection Functions ]]----------------

--- Gets the current visual selection.
--- Saves it into a table, with the line numbers as the keys, and
--- the text as the values.
--- The selection contains a list (selection.line_numbers) of
--- the sorted line numbers, sorted in ascending order (lowest to highest)
--- for easier processing.
--- An example of looping over the returned selection: >
---
---     local selection = require('kolkhis.functions'):get_selection()
---     if not selection.line_numbers then
---         return vim.notify("no line numbers found")
---     end
---         local current_ln = selection[line_number]
---         local current_line_contents = current_ln.text
---         local current_line_number = current_ln.line_number
---         vim.notify(
---         ("Line number: %d \nLine text: %s"):format(
---             current_line_number, vim.inspect(current_line_contents)
---         ))
---     end
---@return table selection: A table containing the current visual selection.
function M.get_selection()
    if vim.api.nvim_get_mode().mode ~= 'n' then
        vim.cmd.norm('I') -- Set visual marks
    end

    local selection = {}
    selection.line_numbers = {}
    local ln_start, ln_end = vim.fn.line("'<"), vim.fn.line("'>")
    if ln_start and ln_start == ln_end then
        selection[ln_start] = { text = vim.fn.getline(ln_start) }
        selection.line_numbers = { ln_start }
        return selection
    end

    for i = vim.fn.line("'<"), vim.fn.line("'>") do
        table.insert(selection.line_numbers, i)
        selection[i] = { text = vim.fn.getline(i), line_number = i }
    end
    table.sort(selection.line_numbers)
    selection.number_of_lines = table.maxn(selection.line_numbers)
    vim.cmd.norm('gv') -- Preserve selection
    return selection
end

---Work in progress. Not yet implemented.
--- Loops over the current visual selection and performs
--- all check functions on each line.
--- Saves the results into the line items of the `selection` table.
function M:loop_selection()
    local selection = self.get_selection()
    for _, ln_num in ipairs(selection.line_numbers) do
        local line = selection[ln_num].text
        -- TODO: Add handling for these cases
        selection[ln_num].is_todo = self.match_todo(line)
        selection[ln_num].is_ordered_list = self.match_ol(line)
        selection[ln_num].is_unordered_list = self.match_ul(line)
        selection[ln_num].is_incompleted_todo = self.match_incomplete_todo(line)
        selection[ln_num].is_completed_todo = self.match_complete_todo(line)
    end
    vim.cmd.norm('gv')
end

-- TODO: Function to break lines that are too long:
--       '<'>s/^\(.\{,85}[,.]\?\)/\1\r /g
--       Maybe use vim.g.textwidth instead of 85?

function M:wrap_code_block()
    local ln_start, ln_end = vim.fn.line('.'), vim.fn.line('.')
    if vim.api.nvim_get_mode().mode ~= 'n' then
        vim.cmd.norm('I')
        ln_start, ln_end = vim.fn.line("'<"), vim.fn.line("'>")
    end
    local start_line = vim.fn.getline(ln_start)
    if self.match_code_block_start(start_line) or
        self.match_code_block_end(start_line) then
        vim.cmd(([[%ds/^\(\s*\)\?`\{3}.\{-}\n//]]):format(ln_start))
        vim.cmd(([[%ds/^\(\s*\)\?`\{3}\n//]]):format(ln_end - 1))
        -- vim.cmd.norm(("%dggdd%dggdd"):format(ln_start, ln_end - 1))
        return true
    end
    local indentation = start_line:match('^(%s*)')
    vim.cmd.norm(([[%dgg]]):format(ln_start-1))
    vim.api.nvim_put({('%s```'):format(indentation)}, 'l', true, true)
    vim.cmd.norm(([[%dgg]]):format(ln_end+1))
    vim.api.nvim_put({('%s```'):format(indentation)}, 'l', true, true)
    vim.cmd.norm(("%dggA"):format(ln_start))
    return true
end


return M
