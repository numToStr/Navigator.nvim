local tmux = require('Navigator.tmux')
local api = vim.api
local cmd = api.nvim_command

-- Just some state and defaults
local N = {
    last_pane = false,
    config = {
        disable_on_zoom = false, -- boolean
        auto_save = nil, -- 'current' | 'all'
    },
}

local function wincmd(direction)
    cmd('wincmd ' .. direction)
end

-- For setting up the plugin with the user provided options
function N.setup(opts)
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

function N.back_to_tmux(at_edge)
    if N.config.disable_on_zoom and tmux.is_zoomed() then
        return false
    end

    return N.last_pane or at_edge
end

-- For smoothly navigating through neovim splits and tmux panes
function N.navigate(direction)
    -- For moments when you have this plugin installed
    -- but for some reason you didn't bother to install tmux
    if not tmux.is_tmux then
        wincmd(direction)

        return
    end

    -- window id before navigation
    local cur_win = api.nvim_get_current_win()
    local tmux_last_pane = direction == 'p' and N.last_pane

    if not tmux_last_pane then
        wincmd(direction)
    end

    -- window id after navigation
    local new_win = api.nvim_get_current_win()

    -- After navigation, if the old window and new window matches
    local at_edge = cur_win == new_win

    -- then we can assume that we hit the edge
    -- there is tmux pane besided the edge
    -- So we can navigate to the tmux pane
    if N.back_to_tmux(at_edge) then
        tmux.change_pane(direction)

        local w = N.config.auto_save

        if w ~= nil then
            if w == 'current' then
                cmd('update')
            end

            if w == 'all' then
                cmd('wall')
            end
        end

        N.last_pane = true
    else
        N.last_pane = false
    end
end

return N
