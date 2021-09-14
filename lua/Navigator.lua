local n = require('Navigator.navigate')

local N = {
    setup = n.setup,
}

function N.left()
    n.navigate('h')
end

function N.up()
    n.navigate('k')
end

function N.right()
    n.navigate('l')
end

function N.down()
    n.navigate('j')
end

function N.previous()
    n.navigate('p')
end

return N
