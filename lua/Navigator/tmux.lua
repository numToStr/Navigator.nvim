local T = {}

local TMUX = os.getenv('TMUX')
local TMUX_PANE = os.getenv('TMUX_PANE')

local tmux_directions = {
    p = 'l',
    h = 'L',
    k = 'U',
    l = 'R',
    j = 'D',
}

---Are we really using tmux
T.is_tmux = TMUX ~= nil

---For getting tmux socket
---@return string
local function get_socket()
    -- The socket path is the first value in the comma-separated list of $TMUX.
    return vim.split(TMUX, ',')[1]
end

---For executing a tmux command
---@param arg string Tmux command to run
---@return number
local function execute(arg)
    local t_cmd = string.format('tmux -S %s %s', get_socket(), arg)

    local handle = assert(io.popen(t_cmd), string.format('Navigator: Unable to execute > [%s]', t_cmd))
    local result = handle:read()

    handle:close()

    return result
end

---For execting `tmux select-pane` command
---@param direction string
function T.change_pane(direction)
    return execute(string.format("select-pane -t '%s' -%s", TMUX_PANE, tmux_directions[direction]))
end

---To check whether the tmux pane is zoomed
---@return boolean
function T.is_zoomed()
    -- if result is 1 then tmux pane is zoomed
    return execute("display-message -p '#{window_zoomed_flag}'") == '1'
end

---To check whether only one tmux pane exists in a direction
---@param direction string
---@return boolean
function T.single_pane(direction)
    -- Check if only one tmux pane exists
    if execute("display-message -p '#{window_panes}'") == '1' then
        return true
    end

    -- Check if tmux pane is zoomed
    if T.is_zoomed() and require('Navigator.navigate').config.disable_on_zoom then
        return true
    end

    -- Compare dimensions of the tmux pane and tmux window in direction
    if direction == 'h' or direction == 'l' then
        return execute("display-message -p '#{pane_width}'") == execute("display-message -p '#{window_width}'")
    elseif direction == 'j' or direction == 'k' then
        return execute("display-message -p '#{pane_height}'") == execute("display-message -p '#{window_height}'")
    end
end

return T
