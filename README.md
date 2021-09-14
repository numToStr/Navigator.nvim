<h1 align='center'>Navigator.nvim</h1>

<h4 align='center'>✨ Smoothly navigate between splits and panes ✨</h4>

![Navigator](https://user-images.githubusercontent.com/24727447/113504572-92f22180-9556-11eb-963a-218e17c13704.gif "Navigator navigating to the moon")

<!-- <p align='center'><a href="https://user-images.githubusercontent.com/24727447/113504213-4dccf000-9554-11eb-8dcb-43d13e20be59.mp4" target="_blank" >Source</a></p> -->

### Requirements

-   Neovim 0.5

### Installation

#### Neovim

-   With [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua

use {
    'numToStr/Navigator.nvim',
    config = function()
        require('Navigator').setup()
    end
}

```

#### Tmux

This plugin doesn't provides any configuration for `tmux`. You can read [here](https://github.com/christoomey/vim-tmux-navigator#tmux) to how to setup your tmux.

Or, you can use [tmux-tilish](https://github.com/jabirali/tmux-tilish) which is an excellent tmux plugin.

### Setup

```lua
-- Configuration
require('Navigator').setup()

-- Keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)
```

#### Configuration

Following options can be given when calling `setup({config})`. Below is the default configuration

```lua
{
    -- When you want to save the modified buffers when moving to tmux
    -- `nil` - Don't save (default)
    -- `current` - Only save the current modified buffer
    -- `all` - Save all the buffers
    auto_save = nil,

    -- Disable navigation when tmux is zoomed in
    disable_on_zoom = false
}
```

### Usage

> This plugin doesn't comes with any default keybinding but rather gives you the flexibility to setup your own keybindings with the provided functions

-   Go to left split or pane

```lua
lua require('Navigator').left()
```

-   Go to upper split or pane

```lua
lua require('Navigator').up()
```

-   Go to right split or pane

```lua
lua require('Navigator').right()
```

-   Go to down split or pane

```lua
lua require('Navigator').down()
```

-   Go to previous split or pane

```lua
lua require('Navigator').previous()
```

### Credits

This plugin is a port of [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) in lua.
