local U = {}

---Executes a child process
---@param cmd string
---@return unknown
function U.execute(cmd)
    local handle = assert(io.popen(cmd), string.format('[Navigator] Unable to execute cmd - %q', cmd))
    local result = handle:read()
    handle:close()
    return result
end

---Loads mux
---@return Vi
function U.load_mux()
    local ok_tmux, tmux = pcall(function()
        return require('Navigator.mux.tmux'):new()
    end)
    if ok_tmux then
        return tmux
    end
    local ok_wez, wezterm = pcall(function()
        return require('Navigator.mux.wezterm'):new()
    end)
    if ok_wez then
        return wezterm
    end
    return require('Navigator.mux.vi'):new()
end

return U
