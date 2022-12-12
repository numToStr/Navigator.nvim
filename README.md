<h1 align='center'>Navigator.nvim</h1>
<p align="center"><sup>✨ Smoothly navigate between neovim and multiplexer ✨</sup></p>

![Navigator](https://user-images.githubusercontent.com/24727447/157040356-1f44323a-c7b6-4955-8207-5e6cade08c9e.gif "Navigating to the moon")

This plugin provides a set of [functions](#lua-api) and [commands](#commands) that allows you to seemlessly navigate between neovim and different [terminal multiplexers](#multiplexers).

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

### ⚒️ Setup

#### Neovim

```lua
require('Navigator').setup()
```

- Keybindings

> **Note** - This plugin doesn't provide any keybindings by default, feel free to use (and modify) the following or create your own keybindings.

```lua
vim.keymap.set('n', '<A-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set('t', '<A-h>', '<CMD>NavigatorLeft<CR>')

vim.keymap.set('n', '<A-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set('t', '<A-l>', '<CMD>NavigatorRight<CR>')

vim.keymap.set('n', '<A-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set('t', '<A-k>', '<CMD>NavigatorUp<CR>')

vim.keymap.set('n', '<A-j>', '<CMD>NavigatorDown<CR>')
vim.keymap.set('t', '<A-j>', '<CMD>NavigatorDown<CR>')

vim.keymap.set('n', '<A-p>', '<CMD>NavigatorPrevious<CR>')
vim.keymap.set('t', '<A-p>', '<CMD>NavigatorPrevious<CR>')
```

#### Multiplexer(s)

> **Note** - This plugin doesn't provide any configuration for multiplexers, feel free to use (and modify) the snippet for multiplexer of your choice by following the links below.

- [Tmux](https://github.com/numToStr/Navigator.nvim/wiki/Tmux-Integration)
- [Wezterm](https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration)

#### Configuration (optional)

Following options can be given when calling `setup({config})`. Below is the default configuration

```lua
{
    -- Save modified buffer(s) when moving to mux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = nil,

    -- Disable navigation when the current mux pane is zoomed in
    disable_on_zoom = false

    -- Multiplexer to use
    -- 'auto' - Chooses mux based on priority (default)
    -- table - Custom mux to use
    mux = 'auto'
}
```

> Read: [How to create and integrate custom multiplexer?](https://github.com/numToStr/Navigator.nvim/wiki/Custom-Multiplexer)

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
