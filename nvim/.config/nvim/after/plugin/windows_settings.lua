local os = require('kolkhis.detect_os')

if os.is_windows then
  vim.o.shell = 'pwsh.exe'
  vim.o.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
  vim.o.shellxquote = ''
end
