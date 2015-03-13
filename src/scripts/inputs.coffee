Bacon = require('baconjs')
$ = require('jquery')

keyPresses = ->
  return $(document).asEventStream('keydown')
    .throttle(20)
    .map '.which'
    .log()

Keys =
  LEFT: 37
  RIGHT: 39
  UP: 38

module.exports = {keyPresses, Keys}