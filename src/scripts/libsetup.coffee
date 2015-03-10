Bacon = require('baconjs')
$ = require('jquery')

window?.Bacon = Bacon
$.fn.asEventStream = Bacon.$.asEventStream