local ucmd = vim.api.nvim_create_user_command

local N = require('Navigator')

ucmd('NavigatorLeft', N.left, {})
ucmd('NavigatorRight', N.right, {})
ucmd('NavigatorUp', N.up, {})
ucmd('NavigatorDown', N.down, {})
ucmd('NavigatorPrevious', N.previous, {})
