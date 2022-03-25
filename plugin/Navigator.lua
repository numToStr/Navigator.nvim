local N = require('Navigator')
local ucmd = vim.api.nvim_add_user_command

ucmd('NavigatorLeft', N.left, {})
ucmd('NavigatorRight', N.right, {})
ucmd('NavigatorUp', N.up, {})
ucmd('NavigatorDown', N.down, {})
ucmd('NavigatorPrevious', N.previous, {})
