fs = require 'fs'
log = (args...) -> console.log(args...)


entry = fs.readFileSync(__dirname + '/input.txt').toString().split('\n')
entry.pop()

class Command
  constructor: (@type, @cmd, @target, @source) ->
    @evaluated = false

wires = []
values = []

splitLine = (s) ->
  ss = s.split('->')
  ss[0] = ss[0].trim().split ' '
  ss[1] = ss[1].replace ' ', ''
  return ss

parse = (s) ->
  r = s[0]
  target = s[1]

  type = r.length
  if type == 3
    cmd = r[1]
    source = []
    source.push(if /^[0-9]+$/.test(r[0]) then parseInt(r[0]) else r[0])
    source.push(if /^[0-9]+$/.test(r[2]) then parseInt(r[2]) else r[2])
  else if type == 2
    cmd = r[0]
    source = if /^[0-9]+$/.test(r[1]) then parseInt(r[1]) else r[1]
  else
    cmd = 'ASSIGN'
    source = if /^[0-9]+$/.test(r[0]) then parseInt(r[0]) else r[0]

  wires.push new Command type, cmd, target, source

mapCmd = ->
  entry.forEach (x) ->
    parse splitLine x

scanSource = (s, t) ->
  if s instanceof Array
    for key, val of s
      if val == t
        return true
    return false
  else
    if s == t
      return true

findOutput = (t) ->
  if values['a']? then return
  wires.forEach (x) ->
    switch x.type
      when 1
        if !t?
          if typeof x.source == 'string'
            if values[x.source]?
              r1 = values[x.source]
            else
              return
          else
            r1 = x.source
          values[x.target] = r1
          findOutput(x.target)
      when 2
        if t? and scanSource(x.source, t)
          if typeof x.source == 'string'
            if values[x.source]?
              r1 = ~values[x.source]
            else
              return
          else
            r1 = ~x.source
          values[x.target] = r1
          findOutput(x.target)
      when 3
        if t? and scanSource(x.source, t)
          switch x.cmd
            when 'AND'
              if typeof x.source[0] == 'string'
                if values[x.source[0]]?
                  r1 = values[x.source[0]]
                else
                  return
              else
                r1 = x.source[0]
              if typeof x.source[1] == 'string'
                if values[x.source[1]]?
                  r2 = values[x.source[1]]
                else
                  return
              else
                r2 = x.source[1]
              values[x.target] = r1 & r2
              findOutput(x.target)
            when 'OR'
              if typeof x.source[0] == 'string'
                if values[x.source[0]]?
                  r1 = values[x.source[0]]
                else
                  return
              else
                r1 = x.source[0]
              if typeof x.source[1] == 'string'
                if values[x.source[1]]?
                  r2 = values[x.source[1]]
                else
                  return
              else
                r2 = x.source[1]
              values[x.target] = r1 | r2
              findOutput(x.target)
            when 'LSHIFT'
              if typeof x.source[0] == 'string'
                if values[x.source[0]]?
                  r1 = values[x.source[0]]
                else
                  return
              else
                r1 = x.source[0]
              if typeof x.source[1] == 'string'
                if values[x.source[1]]?
                  r2 = values[x.source[1]]
                else
                  return
              else
                r2 = x.source[1]
              values[x.target] = r1 << r2
              findOutput(x.target)
            when 'RSHIFT'
              if typeof x.source[0] == 'string'
                if values[x.source[0]]?
                  r1 = values[x.source[0]]
                else
                  return
              else
                r1 = x.source[0]
              if typeof x.source[1] == 'string'
                if values[x.source[1]]?
                  r2 = values[x.source[1]]
                else
                  return
              else
                r2 = x.source[1]
              values[x.target] = r1 >> r2
              findOutput(x.target)

mapCmd()
findOutput()

log values['a']
