Bacon = require('baconjs')
$ = require('jquery')

$.fn.asEventStream = Bacon.$.asEventStream

Bacon.Observable::slidingWindowBy = (lengthObs) ->
  self = @
  return new Bacon.EventStream (sink) ->
    buf = []
    length = 0

    self.onValue (x) ->
      buf.unshift(x)
      buf = buf.slice(0, length)
      sink(new Bacon.Next(buf))

    lengthObs.onValue (n) ->
      length = n