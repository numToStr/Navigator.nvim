---@class Vi
local Vi = {}

---Creates new Neovim navigator instance
---NOTE: This can be used as a base for other navigators
---@return Vi
function Vi:new()
    self.__index = self
    return setmetatable({}, self)
end

---Checks whether neovim is maximized
---NOTE: This is only useful for `tmux`, for other mux(s) return false would suffice
---@return boolean
function Vi.zoomed()
    return false
end

---Navigate inside neovim
---@param direction Direction
---@return Vi
function Vi:navigate(direction)
    vim.api.nvim_command('wincmd ' .. direction)
    return self
end

return Vi
