<h1 align='center'>Navigator.nvim</h1>

<h4 align='center'>Smoothly navigate between splits and panes</h4>

> Note: This plugin is a lua port of famous vim-tmux-navigator

### Requirements

-   Neovim Nightly (0.5)

### Installation

-   With [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua

use {
    'numToStr/Navigator.nvim',
    config = function()
        require('Navigator.nvim').setup()
    end
}

```

### Configuration

This plugin provides the following configuration which can be given when calling `setup()`.

-   `auto_save`: When you want to save the modified buffers when moving to tmux

    Values:

    -   `nil` - Don't save (default)
    -   `current` - Only save the current modified buffer
    -   `all` - Save all the buffers

-   `disable_on_zoom`: Disable navigation when tmux is zoomed in (`false` by default)

### Commands

This plugin doesn't comes with any default keybinding but rather gives you the flexibility to setup your own keybindings with the provided functions

-   `require('Navigator.nvim').left()` - Go left to split or pane

-   `require('Navigator.nvim').up()` - Go up to split or pane

-   `require('Navigator.nvim').right()` - Go right to split or pane

-   `require('Navigator.nvim').down()` - Go down to split or pane

-   `require('Navigator.nvim').previous()` - Move to previous split or pane

### Setup

```lua

-- Configuration
require('Navigator.nvim').setup({
    auto_save = 'current',
    disable_on_zoom = true
})

-- Keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', "<A-h>", "require('Navigator.nvim').left()", opts)
map('n', "<A-k>", "require('Navigator.nvim').up()", opts)
map('n', "<A-l>", "require('Navigator.nvim').right()", opts)
map('n', "<A-j>", "require('Navigator.nvim').down()", opts)
map('n', "<A-p>", "require('Navigator.nvim').previous()", opts)
```

### Credits

[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
