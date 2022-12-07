local T = {}

local wezterm_directions = {
    p = 'Prev',
    h = 'Left',
    k = 'Up',
    l = 'Right',
    j = 'Down'
}

---Implements the check for wezterm existence
function T.is_running()
    local handle = io.popen("pstree -sA $$")
    if handle == nil then return false end
    local result = handle:read()
    handle:close()
    return ((result or ""):find("wezterm")) and true or false
end

---Executes a command in wezterm
---@param arg string Wezterm command to run
---@return number
local function execute(arg)
    local t_cmd = string.format('wezterm cli %s', arg)

    local handle = assert(io.popen(t_cmd), string.format(
        'Navigator: Unable to execute > [%s]', t_cmd))
    local result = handle:read()

    handle:close()

    return result
end

---Implements the command to switch panes in wezterm
---@param direction string
function T.change_pane(direction)
    return execute(string.format("activate-pane-direction %s",
        wezterm_directions[direction]))
end

---Checks whether the current wezterm pane is maximized
---@return boolean
function T.is_zoomed()
    -- TODO There is currently no way to check whether a wezterm window
    -- is maximized from the cli yet.
    return false
end

return T
