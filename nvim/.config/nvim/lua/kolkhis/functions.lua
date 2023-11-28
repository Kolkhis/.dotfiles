M = {}

--- Turn camelCase to snake_case, and vice versa
M.camel_snake_toggle = function()
  local cword = vim.fn.expand('<cword>')
  local camelCase = vim.regex([[^\l.*\(\u\)]]):match_str(cword)
  local snake_case = vim.regex([[^\w.*\(_\)]]):match_str(cword)
  local new_word = cword
  if snake_case then
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
