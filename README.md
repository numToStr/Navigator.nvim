<h1 align='center'>Navigator.nvim</h1>
<p align="center"><sup>✨ Smoothly navigate between neovim and multiplexer(s) ✨</sup></p>

![Navigator](https://user-images.githubusercontent.com/24727447/157040356-1f44323a-c7b6-4955-8207-5e6cade08c9e.gif "Navigating to the moon")

`Navigator.nvim` provides set of [functions](#lua-api) and [commands](#commands) that allows you to seamlessly navigate between neovim and different [terminal multiplexers](#multiplexers).

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
vim.keymap.set({'n', 't'}, '<A-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({'n', 't'}, '<A-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({'n', 't'}, '<A-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set({'n', 't'}, '<A-j>', '<CMD>NavigatorDown<CR>')
vim.keymap.set({'n', 't'}, '<A-p>', '<CMD>NavigatorPrevious<CR>')
```

#### Multiplexer(s)

> **Note** - This plugin doesn't provide any configuration for multiplexers, feel free to use (and modify) the snippet for multiplexer of your choice by following the links below.

- [Tmux](https://github.com/numToStr/Navigator.nvim/wiki/Tmux-Integration)
- [WezTerm](https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration)
- [Zellj](https://github.com/numToStr/Navigator.nvim/wiki/Zellij-Integration)

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
    disable_on_zoom = false,

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

> Read `:h navigator.commands` for more info

#### Lua API

```lua
require('Navigator').left()
require('Navigator').right()
require('Navigator').up()
require('Navigator').down()
require('Navigator').previous()
```

> Read `:h navigator.api` for more info

### 💐 Credits

- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Motivator and Vimscript cousin
