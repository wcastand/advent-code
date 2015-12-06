fs = require 'fs'
log = (args...) -> console.log(args...)
entry = Array.from(fs.readFileSync(__dirname + '/entry.txt').toString())
# entry.pop()

class House
  constructor: (pos) ->
    @x = pos.x
    @y = pos.y
    @count = 1

  pos: -> {@x, @y}


cpos =
  x: 0
  y: 0
rpos =
  x: 0
  y: 0

NORTH = '^'
SOUTH = 'v'
EAST = '>'
WEST = '<'

houses = []

entry.forEach (x, idx) ->
  t = if idx % 2 == 0 then cpos else rpos
  switch x
    when NORTH then t.y--
    when SOUTH then t.y++
    when WEST then t.x--
    when EAST then t.x++
  h = houses.filter (house) ->
    p = house.pos()
    p.x == t.x && p.y == t.y
  if h.length > 0
    h[0].count++
  else
    h = new House(t)
    houses.push h

console.log "Part two: #{houses.length} houses receive at least one present"