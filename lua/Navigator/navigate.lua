local A = vim.api
local cmd = A.nvim_command

local mux_set = { 'tmux', 'wezterm' }
local mux

---@class Config
---@field auto_save '"current"'|'"all"' When you want to save the modified buffers when moving to mux
---@field disable_on_zoom boolean Disable navigation when mux is zoomed in

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

--Select the correct mux depending on user choice in configuration
--@param choice string
local function load_mux(choice)
    if choice == "auto" then
        local testing_mux
        for _, v in ipairs(mux_set) do
            testing_mux = require('Navigator.' .. v)
            if testing_mux.is_running() then return testing_mux end
        end
    else
        for _, v in ipairs(mux_set) do
            if v == choice then return require('Navigator.' .. mux_set[choice]) end
        end
    end
    error("Navigator: Unable to detect mux, please select manually.")
end

---For setting up the plugin with the user provided options
---@param opts Config
function N.setup(opts)
    N.config = {
        disable_on_zoom = false,
        auto_save = nil,
        mux = "auto",
    }

    if opts ~= nil then
        N.config = vim.tbl_extend('keep', opts, N.config)
    end

    A.nvim_create_autocmd('WinEnter', {
        group = A.nvim_create_augroup('NAVIGATOR', { clear = true }),
        callback = function()
            N.last_pane = false
        end,
    })

    mux = load_mux(N.config['mux'])
end

---Checks whether we need to move to the nearby mux pane
---@param at_edge boolean
---@return boolean
function N.back_to_mux(at_edge)
    if N.config.disable_on_zoom and mux.is_zoomed() then return false end

    return N.last_pane or at_edge
end

---For smoothly navigating through neovim splits and mux panes
---@param direction string
function N.navigate(direction)
    -- For moments when you have this plugin installed
    -- but for some reason you didn't bother to install mux
    if not mux.is_running() then return wincmd(direction) end

    -- window id before navigation
    local cur_win = A.nvim_get_current_win()
    local mux_last_pane = direction == 'p' and N.last_pane

    if not mux_last_pane then wincmd(direction) end

    -- After navigation, if the old window and new window matches
    local at_edge = cur_win == A.nvim_get_current_win()

    -- then we can assume that we hit the edge
    -- there is mux pane besided the edge
    -- So we can navigate to the mux pane
    if N.back_to_mux(at_edge) then
        mux.change_pane(direction)

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
