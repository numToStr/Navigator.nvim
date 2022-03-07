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

#### Tmux

This plugin doesn't provides any configuration for `tmux`. You can read [here](https://github.com/christoomey/vim-tmux-navigator#tmux) to how to setup your tmux.

Or, you can use [tmux-tilish](https://github.com/jabirali/tmux-tilish) which is an excellent tmux plugin.

### ⚒️ Setup

```lua
-- Configuration
require('Navigator').setup()

-- Keybindings
vim.keymap.set('n', "<A-h>", require('Navigator').left)
vim.keymap.set('n', "<A-k>", require('Navigator').up)
vim.keymap.set('n', "<A-l>", require('Navigator').right)
vim.keymap.set('n', "<A-j>", require('Navigator').down)
vim.keymap.set('n', "<A-p>", require('Navigator').previous)
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
}
```

### 🔥 Usage

Following are the functions that are exported as part of the lua API.

> NOTE: This plugin doesn't creates default keybinding or commands

- Go to left split/pane

```lua
require('Navigator').left()
```

- Go to upper split/pane

```lua
require('Navigator').up()
```

- Go to right split/pane

```lua
require('Navigator').right()
```

- Go to down split/pane

```lua
require('Navigator').down()
```

- Go to previous split/pane

```lua
require('Navigator').previous()
```

### 💐 Credits

- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Motivator and Vimscript cousin
