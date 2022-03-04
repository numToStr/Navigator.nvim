local tmux = require('Navigator.tmux')
local A = vim.api
local cmd = A.nvim_command

---@class Config
---@field auto_save '"current"'|'"all"' When you want to save the modified buffers when moving to tmux
---@field disable_on_zoom boolean Disable navigation when tmux is zoomed in

---Just some state and defaults
---@class Nav
---@field last_pane boolean
---@field config Config
local N = {
    last_pane = false,
    config = nil,
}

local function wincmd(way)
    cmd(('wincmd %s'):format(way))
end

---For setting up the plugin with the user provided options
---@param opts Config
function N.setup(opts)
    N.config = {
        disable_on_zoom = false,
        auto_save = nil,
    }

    if opts ~= nil then
        N.config = vim.tbl_extend('keep', opts, N.config)
    end

    function _G.__navigator_reset_last_pane()
        N.last_pane = false
    end

    vim.cmd([[
        augroup NavigatorGroup
            au!
            autocmd WinEnter * lua __navigator_reset_last_pane()
        augroup END
    ]])
end

---Checks whether we need to move to the nearby tmux pane
---@param at_edge boolean
---@return boolean
function N.back_to_tmux(at_edge)
    if N.config.disable_on_zoom and tmux.is_zoomed() then
        return false
    end

    return N.last_pane or at_edge
end

---For smoothly navigating through neovim splits and tmux panes
---@param direction string
function N.navigate(direction)
    -- For moments when you have this plugin installed
    -- but for some reason you didn't bother to install tmux
    if not tmux.is_tmux then
        return wincmd(direction)
    end

    -- window id before navigation
    local cur_win = A.nvim_get_current_win()
    local tmux_last_pane = direction == 'p' and N.last_pane

    if not tmux_last_pane then
        wincmd(direction)
    end

    -- After navigation, if the old window and new window matches
    local at_edge = cur_win == A.nvim_get_current_win()

    -- then we can assume that we hit the edge
    -- there is tmux pane besided the edge
    -- So we can navigate to the tmux pane
    if N.back_to_tmux(at_edge) then
        tmux.change_pane(direction)

        local save = N.config.auto_save

        if save == 'current' then
            cmd('update')
        elseif save == 'all' then
            cmd('wall')
        end

        N.last_pane = true
    else
        N.last_pane = false
    end
end

return N
