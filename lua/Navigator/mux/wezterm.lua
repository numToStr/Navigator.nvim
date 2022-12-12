---@class WezTerm: Vi
---@field private direction table<Direction, string>
---@field private execute fun(arg: string): unknown
local WezTerm = require('Navigator.mux.vi'):new()

---Creates a new WezTerm navigator instance
---@return WezTerm
function WezTerm:new()
    assert(os.getenv('TERM_PROGRAM') == 'WezTerm', '[Navigator] WezTerm is not running!')

    local U = require('Navigator.utils')
    local suffix = U.suffix()

    ---@type WezTerm
    local state = {
        execute = function(arg)
            return U.execute(string.format('wezterm%s cli %s', suffix, arg))
        end,
        direction = { p = 'Prev', h = 'Left', k = 'Up', l = 'Right', j = 'Down' },
    }
    self.__index = self
    return setmetatable(state, self)
end

---Switch pane in wezterm
---@param direction Direction
---@return WezTerm
function WezTerm:navigate(direction)
    self.execute(string.format('activate-pane-direction %s', self.direction[direction]))
    return self
end

return WezTerm
