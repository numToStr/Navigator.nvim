local A = vim.api
local cmd = A.nvim_command

---State and defaults
---@class Nav
---@field last_pane boolean
---@field config? Config
local N = {
    last_pane = false,
    config = nil,
}

---Detect and load correct mux
---@return Vi
local function load_mux()
    local ok_zellij, zellij = pcall(function()
        return require('Navigator.mux.zellij'):new()
    end)
    if ok_zellij then
        return zellij
    end
    local ok_tmux, tmux = pcall(function()
        return require('Navigator.mux.tmux'):new()
    end)
    if ok_tmux then
        return tmux
    end
    local ok_wezterm, wezterm = pcall(function()
        return require('Navigator.mux.wezterm'):new()
    end)
    if ok_wezterm then
        return wezterm
    end
    return require('Navigator.mux.vi'):new()
end

---For setting up the plugin with the user provided options
---@param opts Config
function N.setup(opts)
    ---@type Config
    local config = {
        disable_on_zoom = false,
        auto_save = nil,
        mux = 'auto',
    }

    if opts ~= nil then
        N.config = vim.tbl_extend('keep', opts, config)
    else
        N.config = config
    end

    if N.config.mux == 'auto' then
        N.config.mux = load_mux()
    end

    A.nvim_create_autocmd('WinEnter', {
        group = A.nvim_create_augroup('NAVIGATOR', { clear = true }),
        callback = function()
            N.last_pane = false
        end,
    })
end

---Checks whether we need to move to the nearby mux pane
---@param at_edge boolean
---@return boolean
local function back_to_mux(at_edge)
    if N.config.disable_on_zoom and N.config.mux:zoomed() then
        return false
    end
    return N.last_pane or at_edge
end

---For smoothly navigating through neovim splits and mux panes
---@param direction string
function N.navigate(direction)
    -- window id before navigation
    local cur_win = A.nvim_get_current_win()

    local mux_last_pane = direction == 'p' and N.last_pane
    if not mux_last_pane then
        cmd('wincmd ' .. direction)
    end

    -- After navigation, if the old window and new window matches
    local at_edge = cur_win == A.nvim_get_current_win()

    -- then we can assume that we hit the edge
    -- there is mux pane besided the edge
    -- So we can navigate to the mux pane
    if back_to_mux(at_edge) then
        N.config.mux:navigate(direction)

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
