fs = require 'fs'
# entry = fs.readFileSync(__dirname + '/entry.txt').toString().split('\n')

log = (args...) -> console.log(args...)

# fr = /([^aieou]*[aieou]){3,}/
# sr = /([a-zA-Z0-3])\1{1,}/
# tr = /^((?!(xy|ab|cd|pq)).)*$/

# log entry.length

# entry = entry.filter (x) -> fr.test x
# log entry.length

# entry = entry.filter (x) -> sr.test x
# log entry.length

# entry = entry.filter (x) -> tr.test x
# log entry.length
input = fs.readFileSync(__dirname + '/entry.txt').toString().split('\n')

count = 0
input.forEach (v) ->
	if v.match(/([a-z][a-z])[a-z]*\1/) and v.match(/([a-z])[a-z]\1/)
		count++

console.log count
