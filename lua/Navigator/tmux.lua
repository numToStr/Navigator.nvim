local T = {}

local TMUX = os.getenv("TMUX")
local TMUX_PANE = os.getenv("TMUX_PANE")

local tmux_directions = {
    p = "l",
    h = "L",
    k = "U",
    l = "R",
    j = "D"
}

-- Do we really using tmux
T.is_tmux = TMUX ~= nil

-- For getting tmux socket
function T.get_socket()
    -- The socket path is the first value in the comma-separated list of $TMUX.
    return vim.split(TMUX, ",")[1]
end

-- For executing a tmux command
function T.execute(arg)
    local t_cmd = string.format("tmux -S %s %s", T.get_socket(), arg)

    local handle = io.popen(t_cmd)
    local result = handle:read("l")
    handle:close()

    return result
end

-- For execting `tmux select-pane` command
function T.change_pane(direction)
    local arg = string.format("select-pane -t '%s' -%s; echo $?;", TMUX_PANE, tmux_directions[direction])

    -- If result is 0 then it succeeds
    return T.execute(arg) == "0"
end

function T.is_zoomed()
    -- if result is 1 then tmux pane is zoomed
    return T.execute("display-message -p '#{window_zoomed_flag}'") == "1"
end

return T
