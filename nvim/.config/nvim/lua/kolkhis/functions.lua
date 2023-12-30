M = {}

--- Check current markdown line for a TODO item (`* [ ]`, `* [x]`, `* [_]`)
--- If the current line is an ordered list item, convert it into a TODO item.
function M:md_todo_handler()
    local line = vim.fn.getline('.')
    local mode = vim.api.nvim_get_mode().mode
    if line == nil then
        vim.notify('Problem encountered when parsing line')
        return
    end
    if mode == 'n' then
        if self.match_todo(line) then
            vim.cmd([[s/\(\*\|\d\.\) \[.\] //]])
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
            vim.cmd([['<,'>s/\(\*\|\d\.\) \(\[ \]\|\[x\]\|\[_\]\) //]])
        elseif self.match_ul(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/\* /* [ ] ]])
        elseif self.match_ol(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/\(\d\.\) /\1 [ ] ]])
        else
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\w/\1* [ ] \2/]])
        end
    end
    vim.notify(vim.inspect(line))
end

function M:md_ul_handler()
    local mode = vim.api.nvim_get_mode().mode
    local line = vim.fn.getline('.')
    if mode == 'n' then
        if self.match_ul(line) then
            vim.cmd.norm('^2x')
        elseif self.match_ol(line) then
            vim.cmd.norm('^3xI* ')
        else
            vim.cmd.norm('I* ')
        end
    else
        if self.match_ul(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/* //]])
        elseif self.match_ol(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\d\. /\1* /]])
        else
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\(\w\)/\1* \2/]])
        end
    end
end

function M:md_ol_handler()
    local mode = vim.api.nvim_get_mode().mode
    local line = vim.fn.getline('.')
    if mode == 'n' then
        if self.match_ol(line) then
            vim.cmd.norm('^3x')
        elseif self.match_ul(line) then
            vim.cmd.norm('^2xI1. ')
        else
            vim.cmd.norm('I1. ')
        end
    else
        if self.match_ol(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/\d\. //]])
        elseif self.match_ul(line) then
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\* /\11. /]])
        else
            vim.cmd.norm('I')
            vim.cmd([['<,'>s/^\(\s*\)\?\(\w\)/\11. \2/]])
        end
    end
end

function M:md_add_linebreaks()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'n' then
        vim.cmd([[%s/\([^,\| \{2}\|`\{3}]$\)/\1  /]])
    else
        vim.cmd([['<,'>s/\([^,\| \{2}\|`\{3}]$\)/\1  /]])
    end
end

function M.match_ol(line)
    return vim.regex([[^\(\s*\)\?\d\+\. ]]):match_str(line)
end

function M.match_ul(line)
    -- vim.fn.match(vim.fn.getline('.'), [[^\(\s*\)\?\* ]]) ~= -1
    return vim.regex([[^\(\s*\)\?\* ]]):match_str(line)
end

function M.match_todo(line)
    return vim.regex([[^\(\s*\)\?\(\*\|\d\.\) \(\[ \]\|\[x\]\|\[_\]\) ]]):match_str(line)
end

--- Turn camelCase to snake_case, and vice versa
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
