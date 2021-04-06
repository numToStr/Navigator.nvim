local tmux = require("Navigator.tmux")
local api = vim.api
local cmd = api.nvim_command
local exec = api.nvim_exec

local N = {}

local function wincmd(direction)
    cmd("wincmd " .. direction)
end

-- Just some state and defaults
function N:new()
    local state = {
        last_pane = false,
        config = {
            disable_on_zoom = false, -- boolean
            auto_save = nil -- 'current' | 'all'
        }
    }

    self.__index = self

    return setmetatable(state, self)
end

-- For setting up the plugin with the user provided options
function N:setup(opts)
    local c = self.config

    self.config = opts and vim.tbl_extend("keep", opts, c) or c

    function _G.__navigator_reset_last_pane()
        self.last_pane = false
    end

    exec(
        [[
            augroup NavigatorGroup
              au!
              autocmd WinEnter * lua __navigator_reset_last_pane()
            augroup END
        ]],
        false
    )
end

function N:back_to_tmux(at_edge)
    if self.config.disable_on_zoom and tmux.is_zoomed() then
        return false
    end

    return self.last_pane or at_edge
end

-- For smoothly navigating through neovim splits and tmux panes
function N:navigate(direction)
    -- For moments when you have this plugin installed
    -- but for some reason you didn't bother to install tmux
    if not tmux.is_tmux then
        wincmd(direction)

        return
    end

    -- window id before navigation
    local cur_win = api.nvim_get_current_win()
    local tmux_last_pane = direction == "p" and self.last_pane

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
    if self:back_to_tmux(at_edge) then
        tmux.change_pane(direction)

        local w = self.config.auto_save

        if w ~= nil then
            if w == "current" then
                cmd("update")
            end

            if w == "all" then
                cmd("wall")
            end
        end

        self.last_pane = true
    else
        self.last_pane = false
    end
end

return N:new()
