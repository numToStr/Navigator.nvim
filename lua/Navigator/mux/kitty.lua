---@mod navigator.kitty Kitty navigator
---@brief [[
---This module provides navigation and interaction for kitty, and uses |navigator.vi|
---as a base class. This is used automatically when kitty is detected on host system
---but can also be used to manually override the mux.
---
---Read also: https://github.com/numToStr/Navigator.nvim/wiki/kitty-Integration
---@brief ]]

---@private
---@class Kitty: Vi
---@field private direction table<Direction, string>
---@field private execute fun(arg: string): unknown
local Kitty = require('Navigator.mux.vi'):new()

---Creates a new Kitty navigator instance
---@return Kitty
---@usage [[
---local ok, kitty = pcall(function()
---    return require('Navigator.mux.kitty'):new()
---end)
---
---require('Navigator').setup({
---    mux = ok and kitty or 'auto'
---})
---@usage ]]
function Kitty:new()
    -- Kitty sets TERM, but not TERM_PROGRAM
    assert(os.getenv('TERM') == 'xterm-kitty', '[Navigator] Kitty is not running!')

    local U = require('Navigator.utils')

    ---@type Kitty
    local state = {
        execute = function(arg)
            return U.execute(string.format('kitty @ %s', arg))
        end,
        direction = { h = 'left', j = 'bottom', k = 'top', l = 'right', },
    }
    self.__index = self
    return setmetatable(state, self)
end

---Switch pane in kitty
---@param direction Direction See |navigator.api.Direction|
---@return Kitty
function Kitty:navigate(direction)
    self.execute(string.format('kitten navigator.py %s', self.direction[direction]))
    return self
end

return Kitty

