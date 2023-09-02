---@mod navigator.wezterm WezTerm navigator
---@brief [[
---This module provides navigation and interaction for WezTerm, and uses |navigator.vi|
---as a base class. This is used automatically when wezterm is detected on host system
---but can also be used to manually override the mux.
---
---Read also: https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration
---@brief ]]

---@private
---@class WezTerm: Vi
---@field private direction table<Direction, string>
---@field private execute fun(arg: string): unknown
local WezTerm = require('Navigator.mux.vi'):new()

---Creates a new WezTerm navigator instance
---@return WezTerm
---@usage [[
---local ok, wezterm = pcall(function()
---    return require('Navigator.mux.wezterm'):new()
---end)
---
---require('Navigator').setup({
---    mux = ok and wezterm or 'auto'
---})
---@usage ]]
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

---Checks if wezterm is zoomed in
---@return boolean
function WezTerm:zoomed()
    local ok, panes = pcall(vim.json.decode, self.execute('list --format json'))
    if not ok then
      return false
    end
    local active_pane_id = tonumber(os.getenv('WEZTERM_PANE'))
    for _, pane in ipairs(panes) do
      if pane.pane_id == active_pane_id then
        return pane.is_zoomed
      end
    end
    return false
end

---Switch pane in wezterm
---@param direction Direction See |navigator.api.Direction|
---@return WezTerm
function WezTerm:navigate(direction)
    self.execute(string.format('activate-pane-direction %s', self.direction[direction]))
    return self
end

return WezTerm
