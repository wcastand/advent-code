fs = require 'fs'

entry = fs.readFileSync(__dirname + '/entry.txt').toString().split('\n')
entry.pop()

class Box
  constructor: (d) ->
    [@l, @w, @h] = d.split('x')
    @l = parseInt @l
    @w = parseInt @w
    @h = parseInt @h
  _surface: ->
    2*@l*@w + 2*@w*@h + 2*@h*@l
  _smallest: ->
    Math.min.apply Math, [@l*@w, @h*@w, @l*@h]
  _max: (a) ->
    Math.max.apply Math, a
  _perimeter: ->
    val = [@l, @w, @h]
    i = @_max val
    idx = val.findIndex (t) ->
      i == t
    val.splice(idx, 1)
    2*val[0] + 2*val[1]
  _cubic: ->
    @l * @w * @h

  required: ->
    @_smallest() + @_surface()
  ribbon: ->
    @_cubic() + @_perimeter()

boxes = []
entry.forEach (x) ->
  boxes.push new Box x

paper = 0
ribbon = 0
boxes.forEach (x) ->
  paper += x.required()
  ribbon += x.ribbon()

console.info "Part one, They should order #{paper} square feet of paper"
console.info "Part two, They should order #{ribbon} feet of ribbon"