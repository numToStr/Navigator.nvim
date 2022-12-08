---@class WezTerm: Vi
---@field private direction table<Direction, string>
---@field private execute fun(arg: string)
local WezTerm = require('Navigator.mux.vi'):new()

---Creates a new WezTerm navigator instance
---@return WezTerm
function WezTerm:new()
    assert(os.getenv('TERM_PROGRAM') == 'WezTerm', '[Navigator] WezTerm is not running!')

    local function execute(arg)
        local exec = string.format('wezterm cli %s', arg)
        return require('Navigator.utils').execute(exec)
    end

    ---@type WezTerm
    local state = {
        execute = execute,
        direction = { p = 'Prev', h = 'Left', k = 'Up', l = 'Right', j = 'Down' },
    }
    self.__index = self
    return setmetatable(state, self)
end

---Implements the command to switch panes in wezterm
---@param direction Direction
---@return WezTerm
function WezTerm:navigate(direction)
    self.execute(string.format('activate-pane-direction %s', self.direction[direction]))
    return self
end

return WezTerm
