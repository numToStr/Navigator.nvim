local ucmd = vim.api.nvim_create_user_command

local N = require('Navigator')

ucmd('NavigatorLeft', N.left, {})
ucmd('NavigatorRight', N.right, {})
ucmd('NavigatorUp', N.up, {})
ucmd('NavigatorDown', N.down, {})
ucmd('NavigatorPrevious', N.previous, {})

ucmd('NavigatorSizeLeft', N.size_left, {})
ucmd('NavigatorSizeRight', N.size_right, {})
ucmd('NavigatorSizeUp', N.size_up, {})
ucmd('NavigatorSizeDown', N.size_down, {})
