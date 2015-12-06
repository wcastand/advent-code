crypto = require 'crypto'
log = (args...) -> console.log(args...)

entry = 'iwrupvqb'

t = ''
n = 0

# while !t.startsWith('00000')
while !t.startsWith('000000')
  c = crypto.createHash('md5')
  t = c.update(entry + n).digest('hex')
  n++

log t, n - 1