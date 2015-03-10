Bacon = require('baconjs')
$ = require('jquery')

keyPresses = -> $(document).asEventStream('keydown')

ticks = -> $('#tick').asEventStream('click')

Keys =
  LEFT: 37
  RIGHT: 39

module.exports = {keyPresses, ticks, Keys}