---@class Tmux: Vi
---@field private pane string
---@field private direction table<Direction, string>
---@field private execute fun(arg: string): unknown
local Tmux = require('Navigator.mux.vi'):new()

---Creates a new Tmux navigator instance
---@return Tmux
function Tmux:new()
    local instance = os.getenv('TMUX')
    local pane = os.getenv('TMUX_PANE')

    assert(instance and pane, '[Navigator] Tmux is not running!')

    local socket = string.match(instance, '^(.-),')
    local cmd = instance:find('^.*tmate') and 'tmate' or 'tmux'

    ---@type Tmux
    local state = {
        pane = pane,
        execute = function(arg)
            return require('Navigator.utils').execute(string.format('%s -S %s %s', cmd, socket, arg))
        end,
        direction = { p = 'l', h = 'L', k = 'U', l = 'R', j = 'D' },
    }
    self.__index = self
    return setmetatable(state, self)
end

---Checks if tmux is zoomed in
---NOTE: You can return `false`, if mux is not tmux
---@return boolean
function Tmux:zoomed()
    return self.execute("display-message -p '#{window_zoomed_flag}'") == '1'
end

---Execute navigation command
---@param direction Direction
---@return Tmux
function Tmux:navigate(direction)
    self.execute(string.format("select-pane -t '%s' -%s", self.pane, self.direction[direction]))
    return self
end

return Tmux
