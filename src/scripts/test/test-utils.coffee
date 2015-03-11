Bacon = require('baconjs')

eventsProducedBy = (observableFunc) ->
  whenGivenEvents: (events...) ->
    bus = new Bacon.Bus()
    observable = observableFunc(bus)

    outputEvents = []
    observable.onValue (value) ->
      outputEvents.push(value)

    for event in events
      bus.push(event)

    return outputEvents

module.exports = {eventsProducedBy}