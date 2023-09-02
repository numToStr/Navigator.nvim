local U = {}

---Executes a child process
---@param cmd string
---@return unknown
function U.execute(cmd)
    local handle = assert(io.popen(cmd), string.format('[Navigator] Unable to execute cmd - %q', cmd))
    local result = handle:read("*a")
    handle:close()
    return result
end

---Returns executable suffix based on platform
---@return string
function U.suffix()
    local uname = vim.loop.os_uname()
    if string.find(uname.release, 'WSL.*$') or string.find(uname.sysname, '^Win') then
        return '.exe'
    end
    return ''
end

return U
