Bacon = require('baconjs')
$ = require('jquery')

inputs = $(document).asEventStream('keydown')

Keys =
  LEFT: 37
  RIGHT: 39

module.exports = {inputs, Keys}