<h1 align='center'>Navigator.nvim</h1>

<h4 align='center'>✨ Smoothly navigate between splits and panes ✨</h4>

![Navigator](https://user-images.githubusercontent.com/24727447/113504572-92f22180-9556-11eb-963a-218e17c13704.gif "Navigator navigating to the moon")

<!-- <p align='center'><a href="https://user-images.githubusercontent.com/24727447/113504213-4dccf000-9554-11eb-8dcb-43d13e20be59.mp4" target="_blank" >Source</a></p> -->

<!-- > Note: This plugin is a lua port of famous vim-tmux-navigator -->

### Requirements

-   Neovim Nightly (0.5)

### Installation

-   With [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua

use {
    'numToStr/Navigator.nvim',
    config = function()
        require('Navigator').setup()
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

-   `require('Navigator').left()` - Go left to split or pane

-   `require('Navigator').up()` - Go up to split or pane

-   `require('Navigator').right()` - Go right to split or pane

-   `require('Navigator').down()` - Go down to split or pane

-   `require('Navigator').previous()` - Go to previous split or pane

### Setup

```lua

-- Configuration
require('Navigator').setup({
    auto_save = 'current',
    disable_on_zoom = true
})

-- Keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)
```

### Credits

[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
