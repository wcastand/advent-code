fs = require 'fs'
log = (args...) -> console.log(args...)


entry = fs.readFileSync(__dirname + '/input.txt').toString().split('\n')

countLightsOn = ->
  count = 0
  for x in lights
    for y in x
      if y.state then count++
  return count

class Light
  constructor: (@state = off) ->

  turn: (state) ->
    @state = state

  toggle: ->
    @state = !@state

lights = new Array(1000)

createGrid = ->
  for x in [0..999]
    lights[x] = new Array(1000)
    for y in [0..999]
      lights[x][y] = new Light()

parse = (s) ->
  s.split(' ')

turns = (state, s, e) ->
  log state, s, e
  for x in [s.x..e.x]
    log x
    for y in [s.y..e.y]
      lights[x][y].turn(state)

toggles = (s, e) ->
  for x in [s.x..e.x]
    for y in [s.y..e.y]
      lights[x][y].toggle()

posFromString = (s) ->
  parsed = s.split(',')
  return {x: parsed[0], y: parsed[1]}

createGrid()
entry.forEach (i) ->
  parsed = parse i
  switch parsed[0]
    when 'turn'
      switch parsed[1]
        when 'on' then turns on, posFromString(parsed[2]), posFromString(parsed[4])
        when 'off' then turns off, posFromString(parsed[2]), posFromString(parsed[4])
    when 'toggle'
      toggles posFromString(parsed[1]), posFromString(parsed[3])

log countLightsOn()
