---@mod navigator.zellij Zellij navigator
---@brief [[
---This module provides navigation and interaction for Zellij, and uses |navigator.vi|
---as a base class. This is used automatically when zellij is detected on host
---system but can also be used to manually override the mux.
---Read also: https://github.com/numToStr/Navigator.nvim/wiki/Zellij-Integration
---@brief ]]

---@private
---@class Zellij: Vi
---@field private direction table<Direction, string>
---@field private execute fun(arg: string): unknown
local Zellij = require('Navigator.mux.vi'):new()

---Creates a new Zellij navigator instance
---@return Zellij
---@usage [[
---local ok, zellij = pcall(function()
---    return require('Navigator.mux.zellij'):new()
---end)
---
---require('Navigator').setup({
---    mux = ok and zellij or 'auto'
---})
---@usage ]]
function Zellij:new()
    assert(os.getenv('ZELLIJ'), '[Navigator] Zellij is not running!')

    ---@type Zellij
    local state = {
        execute = function(arg)
            return require('Navigator.utils').execute(string.format('zellij action %s', arg))
        end,
        direction = {
            p = 'focus-previous-pane',
            h = 'move-focus-or-tab left',
            j = 'move-focus down',
            k = 'move-focus up',
            l = 'move-focus-or-tab right',
        },
    }
    self.__index = self
    return setmetatable(state, self)
end

---Switch pane in zellij
---@param direction Direction See |navigator.api.Direction|
---@return Zellij
function Zellij:navigate(direction)
    self.execute(string.format("%s", self.direction[direction]))
    return self
end

return Zellij
