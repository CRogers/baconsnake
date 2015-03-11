Bacon = require('baconjs')
$ = require('jquery')

keyPresses = -> $(document).asEventStream('keydown').throttle(20)

Keys =
  LEFT: 37
  RIGHT: 39
  SPACE: 32

module.exports = {keyPresses, Keys}