local n = require('Navigator.navigate')

local Navigator = {}

function Navigator.setup(opts)
    n:setup(opts)
end

function Navigator.left()
    n:navigate('h')
end

function Navigator.up()
    n:navigate('k')
end

function Navigator.right()
    n:navigate('l')
end

function Navigator.down()
    n:navigate('j')
end

function Navigator.previous()
    n:navigate('p')
end

return Navigator
