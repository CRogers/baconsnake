Bacon = require('baconjs')
$ = require('jquery')

keyPresses = -> $(document).asEventStream('keyup')

Keys =
  LEFT: 37
  RIGHT: 39
  SPACE: 32

ticks = ->
  spaces = $(document)
    .asEventStream('keydown')
    .throttle(20)
    .filter (event) -> event.which == Keys.SPACE
  $('#tick').asEventStream('click').merge(spaces)

module.exports = {keyPresses, ticks, Keys}