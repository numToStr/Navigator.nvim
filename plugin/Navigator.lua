local ucmd = vim.api.nvim_create_user_command

-- NOTE: remove this after 0.7 release
if not ucmd then
    vim.cmd([[
        command NavigatorLeft lua require'Navigator'.left()
        command NavigatorRight lua require'Navigator'.right()
        command NavigatorUp lua require'Navigator'.up()
        command NavigatorDown lua require'Navigator'.down()
        command NavigatorPrevious lua require'Navigator'.previous()
    ]])
else
    local N = require('Navigator')

    ucmd('NavigatorLeft', N.left, {})
    ucmd('NavigatorRight', N.right, {})
    ucmd('NavigatorUp', N.up, {})
    ucmd('NavigatorDown', N.down, {})
    ucmd('NavigatorPrevious', N.previous, {})
end
