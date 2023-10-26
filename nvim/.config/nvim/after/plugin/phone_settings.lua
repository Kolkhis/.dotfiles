local os = require('kolkhis.detect_os')

if os.is_linux and not os.is_phone then
  require('bufferline').setup({
    options = {
      separator_style = 'thin',
      { '-', '-' },
    },
  })
end

if os.is_phone then
  require('neo-tree').setup({
    popup_border_style = 'rounded',
    window = {
      position = 'left',
      width = 20,
    },
  })
end

if os.is_windows then
  vim.o.shell = 'pwsh.exe'
  vim.o.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
  vim.o.shellxquote = ''
end
