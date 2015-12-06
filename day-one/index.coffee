fs = require 'fs'

entry = Array.from(fs.readFileSync(__dirname + '/entry.txt').toString())

level = 0
basement = null
entry.forEach (v, i) ->
  if v == '('
    level++
  else
    level--
  if level == -1 && basement == null
    basement = i + 1

console.log "Part one, santa hit floor : #{level}"
console.log "Part two, santa hit the basement at position : #{basement}"

