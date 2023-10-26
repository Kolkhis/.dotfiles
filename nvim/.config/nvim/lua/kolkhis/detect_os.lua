--[[ This module is currently being used to determine the operating system.
--	 The purpose being, if the OS is Linux, the `vim.o.shell` option won't be
--	 changed. Possibly can find some other uses for it as well.
--]]
local M = {}

M.os = vim.loop.os_uname().sysname
M.machine = vim.loop.os_uname().machine
function M.get_os()
  return vim.loop.os_uname().sysname
end

function M.check_linux()
  return M.os == 'Linux'
end

function M.check_windows()
  return M.os == 'Windows_NT'
end

function M.check_neither()
  return M.os ~= 'Windows_NT' and M.os ~= 'Linux'
end

M.is_windows = (M.os == 'Windows_NT')
M.is_linux = (M.os == 'Linux')
M.is_phone = (M.machine == 'aarch64')
M.is_neither = (M.os ~= 'Windows_NT' and M.os ~= 'Linux')


return M




