<h1 align='center'>Navigator.nvim</h1>
<p align="center"><sup>✨ Smoothly navigate between splits and panes ✨</sup></p>

![Navigator](https://user-images.githubusercontent.com/24727447/157040356-1f44323a-c7b6-4955-8207-5e6cade08c9e.gif "Navigating to the moon")

### 🚀 Installation

#### Neovim

- With [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    'numToStr/Navigator.nvim',
    config = function()
        require('Navigator').setup()
    end
}
```

- With [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'numToStr/Navigator.nvim'

" Somewhere after plug#end()
lua require('Navigator').setup()
```


### ⚒️ Tmux setup

### Neovim

```lua
-- Configuration
require('Navigator').setup()

-- Keybindings
vim.keymap.set('n', "<A-h>", '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<A-l>", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<A-k>", '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<A-j>", '<CMD>NavigatorDown<CR>')
vim.keymap.set('n', "<A-p>", '<CMD>NavigatorPrevious<CR>')
```

#### Tmux

This plugin doesn't provides any configuration for `tmux`. You can read [here](https://github.com/christoomey/vim-tmux-navigator#tmux) to how to setup your tmux.

Or, you can use [tmux-tilish](https://github.com/jabirali/tmux-tilish) which is an excellent tmux plugin.

### ⚒️ Wezterm setup

#### Neovim:

```lua
-- Configuration
require('Navigator').setup()

-- Keybindings
vim.keymap.set('n', "<C-w>h", '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<C-w>l", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<C-w>k", '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<C-w>j", '<CMD>NavigatorDown<CR>')
vim.keymap.set('n', "<C-w>p", '<CMD>NavigatorPrevious<CR>')
```

#### Wezterm:

```lua
local function isViProcess(pane)
    local proc = pane:get_foreground_process_name()
    if (proc:find('vim') or proc:find('nvim')) then return true end
    return false
end

local function conditionalActivatePane(window, pane, pane_direction,
                                       vim_direction)
    if (isViProcess(pane)) then
        window:perform_action(act.Multiple {
            act.SendKey { key = 'w', mods = 'CTRL' },
            act.SendKey { key = vim_direction }
        }, pane)
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction),
            pane)
    end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane) conditionalActivatePane(window, pane, 'Right', 'l') end)
wezterm.on('ActivatePaneDirection-left', function(window, pane) conditionalActivatePane(window, pane, 'Left', 'h') end)
wezterm.on('ActivatePaneDirection-up', function(window, pane) conditionalActivatePane(window, pane, 'Up', 'k') end)
wezterm.on('ActivatePaneDirection-down', function(window, pane) conditionalActivatePane(window, pane, 'Down', 'j') end)

return {
    keys = {
        { key = 'h', mods = 'ALT', action = act.EmitEvent 'ActivatePaneDirection-left' },
        { key = 'j', mods = 'ALT', action = act.EmitEvent 'ActivatePaneDirection-down' },
        { key = 'k', mods = 'ALT', action = act.EmitEvent 'ActivatePaneDirection-up' },
        { key = 'l', mods = 'ALT', action = act.EmitEvent 'ActivatePaneDirection-right' }
    }
}
```

#### Configuration (optional)

Following options can be given when calling `setup({config})`. Below is the default configuration

```lua
{
    -- When you want to save the modified buffers when moving to tmux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = nil,

    -- Disable navigation when tmux is zoomed in
    disable_on_zoom = false

    -- Which mux program to use outside of neovim
    -- 'auto' (default)
    -- 'tmux'
    -- 'wezterm'
    mux = "tmux"
}
```

### 🔥 Usage

#### Commands

- `NavigatorLeft` - Go to left split/pane

- `NavigatorRight` - Go to right split/pane

- `NavigatorUp` - Go to upper split/pane

- `NavigatorDown` - Go to down split/pane

- `NavigatorPrevious` - Go to previous split/pane

#### Lua API

```lua
require('Navigator').left()

require('Navigator').right()

require('Navigator').up()

require('Navigator').down()

require('Navigator').previous()
```

### 💐 Credits

- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Motivator and Vimscript cousin
