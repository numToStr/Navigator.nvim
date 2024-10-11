local U = {}

---Executes a child process
---@param cmd string
---@return unknown
function U.execute(cmd)
    local handle = assert(io.popen(cmd .. '>/dev/null 2>&1'), string.format('[Navigator] Unable to execute cmd - %q', cmd))
    local result = handle:read()
    handle:close()
    return result
end

local suffix_cache = nil
---Returns executable suffix based on platform
---@return string
U.suffix = function()
	if not suffix_cache then
		suffix_cache = '' -- default to empty, overwrite if it's windows
		local obj = vim.system({ 'wezterm.exe', '--help' }):wait() -- if exe exists
		if obj.code == 0 then
			suffix_cache = '.exe'
		end
	end
	return suffix_cache
end

return U
