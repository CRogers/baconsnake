Bacon = require('baconjs')
$ = require('jquery')
_ = require('lodash')

Keys =
  LEFT: 37
  RIGHT: 39
  UP: 38

keyPresses = ->
  keys = $(document).asEventStream('keydown')
    .throttle(20)
    .map '.which'
  #keys.map((key) -> _.invert(Keys)[key]).log('Key pressed:')
  return keys

module.exports = {keyPresses, Keys}