--[[ This module is currently being used to determine the operating system.
--	 The purpose being, if the OS is Linux, the `vim.o.shell` option won't be
--	 changed. Possibly can find some other uses for it as well.
--]]

local M = {}

M.uname = vim.loop.os_uname()
M.sysname = M.uname.sysname
M.machine = M.uname.machine

--- Calls os_uname to get the system name (sysname)
---@return string sysname
function M.get_os()
    return M.sysname
end

--- Returns true if `sysname` is "Linux"
---@return boolean is_linux
function M.check_linux()
    return M.sysname == 'Linux'
end

--- Returns true if `sysname` is "Windows_NT"
---@return boolean is_windows
function M.check_windows()
    return M.sysname == 'Windows_NT'
end

--- Returns true if `sysname` is neither "Windows_NT" or "Linux"
---@return boolean is_neither
function M.check_neither()
    return M.sysname ~= 'Windows_NT' and M.sysname ~= 'Linux'
end

M.is_windows = (M.sysname == 'Windows_NT')
M.is_linux = (M.sysname == 'Linux')
M.is_termux = (M.machine == 'aarch64')
M.is_neither = (M.sysname ~= 'Windows_NT' and M.sysname ~= 'Linux')

return M
