---@mod navigator.vi Neovim navigator
---@brief [[
---This module provides navigation and interaction for Neovim. This also acts
---as a base class for other multiplexer implementation.
---
---Read: https://github.com/numToStr/Navigator.nvim/wiki/Custom-Multiplexer
---@brief ]]

---@private
---@class Vi
local Vi = {}
local cmd = vim.api.nvim_command

---Creates new Neovim navigator instance
---@return Vi
function Vi:new()
    self.__index = self
    return setmetatable({}, self)
end

---Checks whether neovim is maximized
---@return boolean #For neovim, it'll always returns `false`
function Vi.zoomed()
    return false
end

---Navigate inside neovim
---@param direction Direction See |navigator.api.Direction|
---@return Vi
function Vi:navigate(direction)
    cmd('wincmd ' .. direction)
    return self
end

return Vi
