local n = require('Navigator.navigate')

local N = {
    setup = n.setup,
}

---Go to left split/pane
function N.left()
    n.navigate('h')
end

---Go to above split/pane
function N.up()
    n.navigate('k')
end

---Go to right split/pane
function N.right()
    n.navigate('l')
end

---Go to below split/pane
function N.down()
    n.navigate('j')
end

---Go to previous split/pane
function N.previous()
    n.navigate('p')
end

return N
