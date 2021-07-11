# snek
a bad command line snake game, with an equally bad ai to play it

## how to use?
lua grid.lua (size x) (size y) (debug) (ultra hard mode) (ai) 

`lua grid.lua 11 11 0 0 0` play on a 10x10 grid with manual control

`lua grid.lua 11 11 0 0 1` let the "ai" play on a 10x10 grid

`lua grid.lua 11 11 0 1 0` play on a 10x10 grid in ultra hard mode with manual control

`lua grid.lua 11 11 0 1 1` let the "ai" play on a 10x10 grid in ultra hard mode

### size x
number of units in the x axis, 1 will be taken off to avoid a bug
### size y
number of units in the y axis, 1 will be taken off to avoid a bug
### debug
if 1 then a debug grid and some extra info will be shown
### ultra hard mode
if 1 then snake has unlimited length after eating the first apple, have fun
### ai
let some artificial nonintelligence play for you
