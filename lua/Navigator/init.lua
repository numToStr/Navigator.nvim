---@brief [[
---*navigator-nvim.txt*    For Neovim version 0.7           Last change: 2020 Dec 16
---
---
---                |\ |  _.    o  _   _. _|_  _  ._  ._     o ._ _
---                | \| (_| \/ | (_| (_|  |_ (_) | o | | \/ | | | |
---                               _|
---
---             · Smoothly navigate between neovim and multiplexer(s) ·
---
---@brief ]]

---@toc navigator.contents

---@mod navigator-nvim Introduction
---@brief [[
---Navigator.nvim provides set of functions and commands that allows you to seamlessly
---navigate between neovim and different terminal multiplexers. It also allows you to
---integrate your own custom multiplexer.
---@brief ]]

---@mod navigator.commands Commands
---@brief [[
---This plugin provides the following commands:
---
--- *NavigatorLeft* - Go to left split/pane
--- *NavigatorRight* - Go to right split/pane
--- *NavigatorUp* - Go to upper split/pane
--- *NavigatorDown* - Go to down split/pane
--- *NavigatorPrevious* - Go to previous split/pane
---@brief ]]

---@mod navigator.api API and Config
local n = require('Navigator.navigate')
local Nav = {}

---@class Config
---Save modified buffer(s) when moving
---to mux from neovim (default: `nil`)
---@field auto_save? '"current"'|'"all"'
---Disable navigation when the current
---mux pane is zoomed in (default: `false`)
---@field disable_on_zoom boolean
---@field mux '"auto"'|Vi Multiplexer to use (default: "auto")

---Enum of navigation direction analogous of neovim window movement
---@alias Direction
---| '"p"' # Previous Pane
---| '"h"' # Left Pane
---| '"j"' # Lower Pane
---| '"k"' # Upper Pane
---| '"l"' # Right Pane

---Configure the plugin
---@param opts Config
---@usage [[
----- With default config
---require('Navigator').setup()
---
----- With custom config
---require('Navigator').setup({
---    auto_save = 'current'
---    disable_on_zoom = true
---})
---@usage ]]
function Nav.setup(opts)
    n.setup(opts)
end

---Go to left split/pane
---@usage [[
---require('Navigator').left()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-h>', require('Navigator').left)
---@usage ]]
function Nav.left()
    n.navigate('h')
end

---Go to upper split/pane
---@usage [[
---require('Navigator').up()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-k>', require('Navigator').up)
---@usage ]]
function Nav.up()
    n.navigate('k')
end

---Go to right split/pane
---@usage [[
---require('Navigator').right()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-l>', require('Navigator').right)
---@usage ]]
function Nav.right()
    n.navigate('l')
end

---Go to down split/pane
---@usage [[
---require('Navigator').down()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-j>', require('Navigator').down)
---@usage ]]
function Nav.down()
    n.navigate('j')
end

---Go to previous split/pane
---@usage [[
---require('Navigator').previous()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-p>', require('Navigator').previous)
---@usage ]]
function Nav.previous()
    n.navigate('p')
end

---Resize down split/pane
---@usage [[
---require('Navigator').size_down()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-j>', require('Navigator').size_down)
---@usage ]]
function Nav.size_down()
    n.resize('j')
end

---Resize up split/pane
---@usage [[
---require('Navigator').size_up()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-k>', require('Navigator').size_up)
---@usage ]]
function Nav.size_up()
    n.resize('k')
end

---Resize left split/pane
---@usage [[
---require('Navigator').size_left()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-h>', require('Navigator').size_left)
---@usage ]]
function Nav.size_left()
    n.resize('h')
end

---Resize right split/pane
---@usage [[
---require('Navigator').size_right()
---
----- With keybinding
---vim.keymap.set({'n', 't'}, '<A-l>', require('Navigator').size_right)
---@usage ]]
function Nav.size_right()
    n.resize('l')
end
return Nav
